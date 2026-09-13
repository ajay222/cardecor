# Car Décor Business Manager V2.12

## Database-connected fixes

### Representative
- Uses Supabase to load active décor products.
- Inserts sales without requesting the inserted row back.
- Does NOT need SELECT permission on the `sales` table.
- After a sale, refreshes products only; it does not make an Admin-only sales query.

### Payment modes
1. Cash
2. UPI
3. Card
4. Cash and Online

Cash and Online requires Cash + UPI to equal the final amount.

### Admin
- Uses Supabase Authentication.
- Can read/manage sales, products and expenses according to RLS.
- Daily/monthly reporting remains database-backed.

### Required database migration
Run `supabase_v2_12_migration.sql` once in Supabase SQL Editor. It adds
`expense_type` to `expenses`, matching the Admin expense form.
