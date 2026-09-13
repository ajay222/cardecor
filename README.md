# Car Décor Business Manager V2.11 — Supabase Connected

V2.10 UI is now connected to the Supabase project using the browser-safe publishable key.

## Important setup
1. Run `supabase_rls_admin.sql` in Supabase SQL Editor.
2. Create one Admin user in Supabase Authentication → Users.
3. Use that email/password in the Admin Login section.
4. Do NOT put the database password or service-role/secret key in the website.

Representative access remains login-free. Sales are inserted directly into Supabase. Admin reads sales/products/expenses after Supabase Auth login.
