-- Diagnóstico exclusivamente de lectura. Ejecutar en SQL Editor del proyecto correcto.
begin read only;
select e.name as expected_table, c.oid is not null as present,
       c.relrowsecurity as rls_enabled
from unnest(array['user_profiles','user_roles','warehouses',
'user_warehouse_assignments','company_settings','audit_logs']) e(name)
left join pg_namespace n on n.nspname='public'
left join pg_class c on c.relnamespace=n.oid and c.relname=e.name and c.relkind='r'
order by e.name;
select tablename,policyname,cmd,roles,qual,with_check
from pg_policies where schemaname='public'
and tablename in ('user_profiles','user_roles','warehouses','user_warehouse_assignments','company_settings','audit_logs')
order by tablename,policyname;
select p.proname, p.prosecdef as security_definer, p.proconfig,
pg_get_functiondef(p.oid) as definition
from pg_proc p join pg_namespace n on n.oid=p.pronamespace
where n.nspname='public' and p.proname in ('my_access','has_role','create_profile','audit_change');
select event_object_schema,event_object_table,trigger_name,action_statement
from information_schema.triggers
where trigger_schema='public' or (event_object_schema='auth' and trigger_name='auth_profile');
select table_name,grantee,privilege_type
from information_schema.role_table_grants
where table_schema='public' and grantee in ('anon','authenticated')
and table_name in ('user_profiles','user_roles','warehouses','user_warehouse_assignments','company_settings','audit_logs')
order by table_name,grantee,privilege_type;
select to_regclass('supabase_migrations.schema_migrations') is not null as migration_history_exists;
commit;
-- Si migration_history_exists es true, ejecutar aparte:
-- select version from supabase_migrations.schema_migrations order by version;
-- SQL Editor no registra automáticamente una ejecución manual en ese historial.
