-- Execute no SQL Editor do projeto Supabase. Pode ser executado mais de uma vez.
create table if not exists public.user_workspaces (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{"settings":{"tax":6,"fee":5,"commission":0,"target":20,"min":10},"products":[]}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.user_workspaces enable row level security;
revoke all on public.user_workspaces from anon;
grant select, insert, update, delete on public.user_workspaces to authenticated;

drop policy if exists "workspace_owner_select" on public.user_workspaces;
drop policy if exists "workspace_owner_insert" on public.user_workspaces;
drop policy if exists "workspace_owner_update" on public.user_workspaces;
drop policy if exists "workspace_owner_delete" on public.user_workspaces;

create policy "workspace_owner_select" on public.user_workspaces
  for select to authenticated using ((select auth.uid()) = user_id);
create policy "workspace_owner_insert" on public.user_workspaces
  for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "workspace_owner_update" on public.user_workspaces
  for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "workspace_owner_delete" on public.user_workspaces
  for delete to authenticated using ((select auth.uid()) = user_id);
