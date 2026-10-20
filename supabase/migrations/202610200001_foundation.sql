begin;
create type public.app_role as enum ('admin','seller','warehouse');
create table public.user_profiles (
 id uuid primary key references auth.users(id) on delete restrict,
 full_name text not null default '', active boolean not null default false,
 created_at timestamptz not null default now()
);
create table public.user_roles (
 user_id uuid references public.user_profiles(id) on delete cascade,
 role public.app_role not null, primary key(user_id,role)
);
create table public.warehouses (
 id uuid primary key default gen_random_uuid(), name text not null check(length(trim(name))>0),
 active boolean not null default true, created_at timestamptz not null default now()
);
create table public.user_warehouse_assignments (
 user_id uuid references public.user_profiles(id), warehouse_id uuid references public.warehouses(id),
 primary key(user_id,warehouse_id)
);
create table public.company_settings (
 id boolean primary key default true check(id), display_name text,
 currency text not null default 'MXN' check(currency='MXN'),
 timezone text not null default 'America/Mexico_City'
);
create table public.audit_logs (
 id bigint generated always as identity primary key,
 actor_id uuid, operation text not null, entity text not null,
 record_id text, created_at timestamptz not null default now(),
 changes jsonb not null
);
create function public.has_role(required public.app_role) returns boolean
language sql stable security definer set search_path = '' as $$
 select exists(select 1 from public.user_profiles p join public.user_roles r on r.user_id=p.id
 where p.id=auth.uid() and p.active and r.role=required)
$$;
create function public.my_access() returns public.app_role[]
language sql stable security definer set search_path = '' as $$
 select coalesce(array_agg(r.role),'{}'::public.app_role[])
 from public.user_roles r join public.user_profiles p on p.id=r.user_id
 where p.id=auth.uid() and p.active
$$;
create function public.audit_change() returns trigger
language plpgsql security definer set search_path = '' as $$
begin
 insert into public.audit_logs(actor_id,operation,entity,record_id,changes)
 values(auth.uid(),tg_op,tg_table_name,coalesce(to_jsonb(new)->>'id',to_jsonb(old)->>'id',to_jsonb(new)->>'user_id',to_jsonb(old)->>'user_id'),
 jsonb_build_object('before',to_jsonb(old),'after',to_jsonb(new)));
 return coalesce(new,old);
end $$;
create function public.create_profile() returns trigger
language plpgsql security definer set search_path = '' as $$
begin
 -- No se confía en metadatos de registro para asignar roles o activar cuentas.
 insert into public.user_profiles(id) values(new.id);
 return new;
end $$;
create trigger auth_profile after insert on auth.users for each row execute function public.create_profile();
alter table public.user_profiles enable row level security;
alter table public.user_roles enable row level security;
alter table public.warehouses enable row level security;
alter table public.user_warehouse_assignments enable row level security;
alter table public.company_settings enable row level security;
alter table public.audit_logs enable row level security;
create policy profile_read on public.user_profiles for select to authenticated using(id=auth.uid() or public.has_role('admin'));
create policy profile_admin on public.user_profiles for update to authenticated using(public.has_role('admin')) with check(public.has_role('admin'));
create policy role_read on public.user_roles for select to authenticated using(user_id=auth.uid() or public.has_role('admin'));
create policy role_admin on public.user_roles for all to authenticated using(public.has_role('admin')) with check(public.has_role('admin'));
create policy warehouse_read on public.warehouses for select to authenticated using(public.has_role('admin') or (public.has_role('warehouse') and exists(select 1 from public.user_warehouse_assignments a where a.warehouse_id=id and a.user_id=auth.uid())));
create policy warehouse_admin on public.warehouses for all to authenticated using(public.has_role('admin')) with check(public.has_role('admin'));
create policy assignment_read on public.user_warehouse_assignments for select to authenticated using(public.has_role('admin') or (user_id=auth.uid() and public.has_role('warehouse')));
create policy assignment_admin on public.user_warehouse_assignments for all to authenticated using(public.has_role('admin')) with check(public.has_role('admin'));
create policy settings_read on public.company_settings for select to authenticated using(cardinality(public.my_access())>0);
create policy settings_admin on public.company_settings for all to authenticated using(public.has_role('admin')) with check(public.has_role('admin'));
create policy audit_admin on public.audit_logs for select to authenticated using(public.has_role('admin'));
create trigger profile_audit after insert or update or delete on public.user_profiles for each row execute function public.audit_change();
create trigger roles_audit after insert or update or delete on public.user_roles for each row execute function public.audit_change();
create trigger warehouses_audit after insert or update or delete on public.warehouses for each row execute function public.audit_change();
create trigger assignments_audit after insert or update or delete on public.user_warehouse_assignments for each row execute function public.audit_change();
create trigger settings_audit after insert or update or delete on public.company_settings for each row execute function public.audit_change();
revoke all on public.user_profiles,public.user_roles,public.warehouses,public.user_warehouse_assignments,public.company_settings,public.audit_logs from anon,authenticated;
grant select,update on public.user_profiles to authenticated;
grant select,insert,update,delete on public.user_roles,public.warehouses,public.user_warehouse_assignments,public.company_settings to authenticated;
grant select on public.audit_logs to authenticated;
revoke execute on function public.has_role(public.app_role),public.my_access(),public.audit_change(),public.create_profile() from public,anon;
grant execute on function public.has_role(public.app_role),public.my_access() to authenticated;
commit;
