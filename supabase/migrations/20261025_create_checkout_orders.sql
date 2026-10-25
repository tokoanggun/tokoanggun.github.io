-- Checkout orders for Toko Anggun.
-- Applied to Supabase project gpkzvhngcccqksuhyoxw.

create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  order_number text not null unique,
  customer_name text not null check (char_length(customer_name) between 2 and 120),
  customer_email text,
  customer_phone text not null check (char_length(customer_phone) between 6 and 40),
  shipping_required boolean not null default false,
  shipping_address text,
  shipping_method text,
  shipping_cost numeric(12,2) not null default 0 check (shipping_cost >= 0),
  subtotal numeric(12,2) not null check (subtotal >= 0),
  total numeric(12,2) not null check (total >= 0),
  payment_method text not null default 'gateway_not_configured',
  payment_status text not null default 'pending',
  order_status text not null default 'new',
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint orders_shipping_details_check check (
    (shipping_required = false) or
    (shipping_required = true and shipping_address is not null and char_length(shipping_address) >= 8)
  )
);

create table if not exists public.order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  product_id uuid references public.products(id) on delete set null,
  product_name text not null,
  unit_price numeric(12,2) not null check (unit_price >= 0),
  quantity integer not null check (quantity between 1 and 99),
  addons jsonb not null default '[]'::jsonb,
  line_total numeric(12,2) not null check (line_total >= 0),
  created_at timestamptz not null default now()
);

create index if not exists orders_created_at_idx on public.orders (created_at desc);
create index if not exists orders_status_idx on public.orders (order_status, payment_status);
create index if not exists order_items_order_id_idx on public.order_items (order_id);

alter table public.orders enable row level security;
alter table public.order_items enable row level security;

drop policy if exists "Admins can read orders" on public.orders;
create policy "Admins can read orders"
on public.orders for select
to authenticated
using (exists (select 1 from public.admin_users au where au.user_id = (select auth.uid())));

drop policy if exists "Admins can read order items" on public.order_items;
create policy "Admins can read order items"
on public.order_items for select
to authenticated
using (exists (select 1 from public.admin_users au where au.user_id = (select auth.uid())));

revoke all on public.orders from anon, authenticated;
revoke all on public.order_items from anon, authenticated;
grant select on public.orders to authenticated;
grant select on public.order_items to authenticated;
