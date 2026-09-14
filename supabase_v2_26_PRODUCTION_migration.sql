-- Satish Reddy Car Decor V2.26 PRODUCTION MIGRATION
-- Run this in the PRODUCTION Supabase SQL Editor BEFORE uploading the V2.26 production website.
-- This migration preserves existing sales and adds the fields required by V2.26.

-- 1. Vehicle names are no longer limited to 4 numeric characters.
ALTER TABLE public.sales
  ALTER COLUMN car_last4 TYPE text
  USING car_last4::text;

-- 2. Add V2.26 sales fields that may not exist in the older production schema.
ALTER TABLE public.sales ADD COLUMN IF NOT EXISTS description text;
ALTER TABLE public.sales ADD COLUMN IF NOT EXISTS discount_percent numeric(5,2) NOT NULL DEFAULT 0;
ALTER TABLE public.sales ADD COLUMN IF NOT EXISTS final_amount numeric(12,2) NOT NULL DEFAULT 0;
ALTER TABLE public.sales ADD COLUMN IF NOT EXISTS payment_method text;
ALTER TABLE public.sales ADD COLUMN IF NOT EXISTS cash_amount numeric(12,2) NOT NULL DEFAULT 0;
ALTER TABLE public.sales ADD COLUMN IF NOT EXISTS upi_amount numeric(12,2) NOT NULL DEFAULT 0;
ALTER TABLE public.sales ADD COLUMN IF NOT EXISTS card_amount numeric(12,2) NOT NULL DEFAULT 0;
ALTER TABLE public.sales ADD COLUMN IF NOT EXISTS cost_amount numeric(12,2) NOT NULL DEFAULT 0;
ALTER TABLE public.sales ADD COLUMN IF NOT EXISTS discount_amount numeric(12,2) NOT NULL DEFAULT 0;

-- 3. Preserve historical production sales.
UPDATE public.sales
SET final_amount = selling_price
WHERE COALESCE(final_amount, 0) = 0;

UPDATE public.sales
SET cost_amount = cost_price
WHERE COALESCE(cost_amount, 0) = 0;

UPDATE public.sales
SET discount_amount = ROUND((selling_price * COALESCE(discount_percent, 0) / 100)::numeric, 2)
WHERE COALESCE(discount_amount, 0) = 0
  AND COALESCE(discount_percent, 0) <> 0;

-- 4. Validate discount amount.
ALTER TABLE public.sales
  DROP CONSTRAINT IF EXISTS sales_discount_amount_nonnegative;

ALTER TABLE public.sales
  ADD CONSTRAINT sales_discount_amount_nonnegative
  CHECK (discount_amount >= 0);

-- 5. Add Bike Washing to configurable services.
INSERT INTO public.service_prices
  (service_name, selling_price, cost_price, active)
VALUES
  ('Bike Washing', 0, 0, true)
ON CONFLICT (service_name) DO NOTHING;

-- Bike Washing has no fixed default selling price.
-- Representatives enter the amount manually for each bike.
-- The service row is retained only so the category exists in Admin > Services.

-- 6. Keep the existing admin/representative permissions.
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.sales TO authenticated;
GRANT INSERT ON TABLE public.sales TO anon;
GRANT SELECT ON TABLE public.service_prices TO anon;
GRANT SELECT, UPDATE ON TABLE public.service_prices TO authenticated;

-- Note:
-- Existing RLS policies are intentionally not replaced here.
-- Run this migration first, verify it completes successfully, then upload the V2.26 production website.
