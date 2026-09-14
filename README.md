Satish Reddy Car Decor — V2.26 PRODUCTION

Approved V2.26 production build.

Bike Washing:
- No fixed ₹600 default.
- Representative enters the selling amount manually for every bike.
- Bike Washing service row is stored at ₹0 so it does not prefill a price.
- Cost remains ₹0 by default unless entered by Admin.

IMPORTANT:
1. Run supabase_v2_26_PRODUCTION_migration.sql in PRODUCTION Supabase first.
2. Verify SQL completes successfully.
3. Then upload index.html to the production GitHub Pages repository.
4. Do not run TEST SQL against production.
