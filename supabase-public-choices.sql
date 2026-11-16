-- Public shared rankings for Utah Table.
-- Run this once in the Supabase SQL Editor for project tnfnprwaqwckjzimgwlc.
-- The old authenticated tables remain untouched as a backup.

create table if not exists public.shared_restaurant_choices (
  person_name text not null check (person_name in ('Mark Phillips', 'Craig Youngs', 'Bradley Ross')),
  restaurant_id text not null check (restaurant_id in ('archibalds', 'market', 'maglebys', 'harvest')),
  priority smallint not null check (priority between 1 and 4),
  updated_at timestamptz not null default now(),
  primary key (person_name, restaurant_id),
  unique (person_name, priority)
);

alter table public.shared_restaurant_choices enable row level security;
revoke all on public.shared_restaurant_choices from anon;
grant select, insert, update, delete on public.shared_restaurant_choices to anon;

drop policy if exists "public visitors can manage shared restaurant choices" on public.shared_restaurant_choices;
create policy "public visitors can manage shared restaurant choices"
  on public.shared_restaurant_choices for all to anon
  using (true) with check (true);

-- Preserve rankings previously saved in the authenticated table.
insert into public.shared_restaurant_choices (person_name, restaurant_id, priority, updated_at)
select m.display_name, c.restaurant_id, c.priority, c.updated_at
from public.restaurant_choices c
join public.app_members m on m.user_id = c.user_id
where m.display_name in ('Mark Phillips', 'Craig Youngs', 'Bradley Ross')
on conflict (person_name, restaurant_id)
do update set priority = excluded.priority, updated_at = excluded.updated_at;
