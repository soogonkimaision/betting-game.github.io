create table if not exists public.predictions (
  id uuid primary key default gen_random_uuid(),
  name text not null check (char_length(name) <= 20),
  country text not null,
  created_at timestamptz not null default now()
);

alter table public.predictions
drop constraint if exists predictions_country_check;

alter table public.predictions
add constraint predictions_country_check
check (country in ('체코', '대한민국', '무승부'));

alter table public.predictions enable row level security;

drop policy if exists "Anyone can read predictions" on public.predictions;
create policy "Anyone can read predictions"
on public.predictions
for select
to anon
using (true);

drop policy if exists "Anyone can add predictions" on public.predictions;
create policy "Anyone can add predictions"
on public.predictions
for insert
to anon
with check (true);

drop policy if exists "Anyone can delete predictions" on public.predictions;
create policy "Anyone can delete predictions"
on public.predictions
for delete
to anon
using (true);
