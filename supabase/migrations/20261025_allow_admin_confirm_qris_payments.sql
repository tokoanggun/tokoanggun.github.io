-- Allow authenticated Toko Anggun admins to record manual QRIS payment verification.
drop policy if exists "Admins can update order payment status" on public.orders;
create policy "Admins can update order payment status"
on public.orders for update
to authenticated
using (
  exists (
    select 1 from public.admin_users au
    where au.user_id = (select auth.uid())
  )
)
with check (
  exists (
    select 1 from public.admin_users au
    where au.user_id = (select auth.uid())
  )
);

grant update (payment_status, order_status, updated_at) on public.orders to authenticated;
