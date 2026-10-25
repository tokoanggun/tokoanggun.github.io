-- Order tracking and merchant-managed QRIS shipment confirmation.
alter table public.orders
  add column if not exists shipping_confirmed boolean not null default false,
  add column if not exists shipping_courier text,
  add column if not exists tracking_number text,
  add column if not exists shipped_at timestamptz,
  add column if not exists delivered_at timestamptz;

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

grant update (
  payment_status, order_status, updated_at,
  shipping_confirmed, shipping_cost, total,
  shipping_courier, tracking_number, shipped_at, delivered_at
) on public.orders to authenticated;
