\set ON_ERROR_STOP on
begin;
insert into auth.users values ('00000000-0000-0000-0000-000000000001'),('00000000-0000-0000-0000-000000000002'),('00000000-0000-0000-0000-000000000003');
update public.user_profiles set active=true;
insert into public.user_roles values ('00000000-0000-0000-0000-000000000001','admin'),('00000000-0000-0000-0000-000000000002','seller'),('00000000-0000-0000-0000-000000000003','warehouse');
insert into public.warehouses(id,name) values ('10000000-0000-0000-0000-000000000001','Almacén de prueba A'),('10000000-0000-0000-0000-000000000002','Almacén de prueba B');
insert into public.user_warehouse_assignments values ('00000000-0000-0000-0000-000000000003','10000000-0000-0000-0000-000000000001');
set local role authenticated;
select set_config('request.jwt.claim.sub','00000000-0000-0000-0000-000000000002',true);
do $$ begin
 if (select count(*) from public.user_profiles)<>1 then raise exception 'Fuga de perfiles';end if;
 if public.has_role('admin') then raise exception 'Escalada de rol';end if;
 if (select count(*) from public.warehouses)<>0 then raise exception 'Fuga de almacenes';end if;
 if (select count(*) from public.audit_logs)<>0 then raise exception 'Fuga de auditoría';end if;
 update public.user_profiles set active=false;
 if found then raise exception 'Vendedor modificó perfil';end if;
 begin
 insert into public.user_roles values(auth.uid(),'admin');
 raise exception 'Vendedor pudo escalar permisos';
 exception when insufficient_privilege then null; end;
end $$;
select set_config('request.jwt.claim.sub','00000000-0000-0000-0000-000000000003',true);
do $$ begin if (select count(*) from public.warehouses)<>1 then raise exception 'Aislamiento de almacenes incorrecto';end if; end $$;
select set_config('request.jwt.claim.sub','00000000-0000-0000-0000-000000000001',true);
do $$ begin
 if (select count(*) from public.user_profiles)<>3 then raise exception 'Admin sin acceso';end if;
 if (select count(*) from public.audit_logs)=0 then raise exception 'Auditoría ausente';end if;
 update public.user_profiles set active=false where id='00000000-0000-0000-0000-000000000002';
end $$;
select set_config('request.jwt.claim.sub','00000000-0000-0000-0000-000000000002',true);
do $$ begin if cardinality(public.my_access())<>0 then raise exception 'Suspensión ineficaz';end if;end $$;
rollback;
