-- Car Décor Manager V2.12 migration
-- Adds the expense_type column expected by the website.
ALTER TABLE public.expenses
ADD COLUMN IF NOT EXISTS expense_type text NOT NULL DEFAULT 'Shop Expense';

-- Keep the Representative restricted: no expense access is granted to anon.
-- Admin access remains through the existing authenticated RLS policies.
