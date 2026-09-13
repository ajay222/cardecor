-- Car Décor Manager V2.11: RLS + Admin permissions
-- Run this AFTER the original table-creation SQL.

-- Remove prototype policies if they exist.
drop policy if exists "Anyone can view active products" on public.products;
drop policy if exists "Anyone can create sales" on public.sales;

-- PRODUCTS
create policy "Public can view active products"
on public.products for select
to anon, authenticated
using (active = true);

create policy "Authenticated admin can view all products"
on public.products for select
to authenticated
using (true);

create policy "Authenticated admin can add products"
on public.products for insert
to authenticated
with check (true);

create policy "Authenticated admin can update products"
on public.products for update
to authenticated
using (true) with check (true);

-- SALES
create policy "Representatives can create sales"
on public.sales for insert
to anon, authenticated
with check (true);

create policy "Authenticated admin can view sales"
on public.sales for select
to authenticated
using (true);

create policy "Authenticated admin can update sales"
on public.sales for update
to authenticated
using (true) with check (true);

create policy "Authenticated admin can delete sales"
on public.sales for delete
to authenticated
using (true);

-- EXPENSES
create policy "Authenticated admin can view expenses"
on public.expenses for select
to authenticated
using (true);

create policy "Authenticated admin can add expenses"
on public.expenses for insert
to authenticated
with check (true);

create policy "Authenticated admin can update expenses"
on public.expenses for update
to authenticated
using (true) with check (true);

create policy "Authenticated admin can delete expenses"
on public.expenses for delete
to authenticated
using (true);
