-- Return, exchange, and cancellation requests for Toko Anggun orders.
create table if not exists public.return_requests (
  id uuid primary key default gen_random_uuid(),
  request_number text not null unique
    check (request_number ~ '^RET-[0-9]{8}-[A-F0-9]{8}$'),
  order_id uuid not null references public.orders(id) on delete restrict,
  order_number text not null,
  customer_name text not null check (char_length(customer_name) between 2 and 120),
  customer_phone text not null check (char_length(customer_phone) between 6 and 40),
  request_type text not null check (request_type in ('cancel', 'exchange', 'return_refund')),
  reason text not null check (char_length(trim(reason)) between 3 and 160),
  details text not null check (char_length(trim(details)) between 5 and 1500),
  requested_product text check (requested_product is null or char_length(requested_product) <= 300),
  status text not null default 'submitted'
    check (status in ('submitted', 'reviewing', 'approved', 'rejected', 'completed')),
  admin_notes text check (admin_notes is null or char_length(admin_notes) <= 1500),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  reviewed_at timestamptz,
  resolved_at timestamptz
);

create index if not exists return_requests_created_at_idx
  on public.return_requests (created_at desc);
create index if not exists return_requests_order_id_idx
  on public.return_requests (order_id);
create unique index if not exists return_requests_one_active_per_order_idx
  on public.return_requests (order_id)
  where status in ('submitted', 'reviewing', 'approved');

alter table public.return_requests enable row level security;

drop policy if exists "Admins can read return requests" on public.return_requests;
create policy "Admins can read return requests"
  on public.return_requests for select to authenticated
  using (public.is_admin());

drop policy if exists "Admins can update return requests" on public.return_requests;
create policy "Admins can update return requests"
  on public.return_requests for update to authenticated
  using (public.is_admin())
  with check (public.is_admin());

revoke all on table public.return_requests from anon, authenticated;
grant select, update on table public.return_requests to authenticated;
grant all on table public.return_requests to service_role;
