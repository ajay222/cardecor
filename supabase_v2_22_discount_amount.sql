-- V2.22 TEST: replace percentage discount with fixed rupee discount amount
-- Run this in the TEST Supabase SQL Editor only.

ALTER TABLE public.sales
ADD COLUMN IF NOT EXISTS discount_amount numeric(12,2) NOT NULL DEFAULT 0;

-- Preserve existing percentage-discount sales when migrating to the new field.
UPDATE public.sales
SET discount_amount = ROUND((selling_price * COALESCE(discount_percent, 0) / 100)::numeric, 2)
WHERE discount_amount = 0
  AND COALESCE(discount_percent, 0) <> 0;

ALTER TABLE public.sales
DROP CONSTRAINT IF EXISTS sales_discount_amount_nonnegative;

ALTER TABLE public.sales
ADD CONSTRAINT sales_discount_amount_nonnegative
CHECK (discount_amount >= 0);

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.sales TO authenticated;
GRANT INSERT ON TABLE public.sales TO anon;
