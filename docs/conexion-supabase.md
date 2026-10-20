# Finalización de Fase 0: Supabase y GitHub

## Resultado de revisión del entorno
Las variables VITE_SUPABASE_URL y VITE_SUPABASE_ANON_KEY están presentes; la URL usa HTTPS y la clave tiene formato público publishable. El nombre ANON_KEY también es compatible con esta clave pública. Esto no demuestra que la clave corresponda al proyecto: falta una respuesta exitosa del servicio.

El código lee import.meta.env y crea el cliente de Supabase. Vite incorpora esas variables al arrancar o compilar: reiniciar el servidor y reconstruir después de cambiarlas. Se ha recompilado con las variables actuales, sin mostrar sus valores.

El proxy del entorno devolvió 403 Forbidden al abrir el túnel hacia el dominio Supabase. Las peticiones directas también fallaron en DNS. No se obtuvo respuesta de Supabase: ni clave inválida ni ausencia de tablas están demostradas. Se guardó un borrador de red que agrega únicamente el dominio del proyecto, conservando el preset existente.

El esquema SQL y sus pruebas existen localmente. No se ha confirmado su aplicación en el proyecto real. Las pruebas PostgreSQL efímeras anteriores no prueban el estado del proyecto remoto.

Git local está en rama work sin commits y todos los archivos fuente están sin seguimiento. `git ls-remote origin` terminó correctamente sin devolver referencias: GitHub no contiene todavía esos cambios. El snapshot del entorno y GitHub son mecanismos diferentes.

## Pasos manuales en orden
1. En configuración del entorno, revisar y guardar la adición del dominio del proyecto Supabase a Internet restringido. Publicar el entorno actualizado si el producto lo requiere. No es publicar la aplicación. Avisar para repetir las comprobaciones de red; no ampliar acceso a todos los dominios.
2. En Supabase, abrir el proyecto que corresponde a la URL configurada y confirmar que está activo. En Connect/API, comparar la URL y la clave **publishable** con las variables del entorno, sin pegarlas en mensajes ni usar claves secret/service_role.
3. Abrir SQL Editor → New query, pegar `supabase/checks/phase0_readonly.sql` y ejecutar. Solo lee metadatos; no consulta contactos, contraseñas ni datos comerciales. Guardar el resultado para revisión.
4. Si las seis tablas aparecen ausentes y no existen las funciones/tipo/trigger de esta migración, abrir una consulta nueva y ejecutar el contenido completo de `supabase/migrations/202610200001_foundation.sql`. Esta acción sí crea estructura en el proyecto; la realiza el operador desde Supabase. No ejecutar bootstrap.sql ni security.sql en el proyecto real. No ejecutar la migración repetidamente: no es idempotente y comienza con CREATE TYPE. Si ya existe cualquier objeto, detenerse y comparar antes; no borrar tablas ni usar DROP para resolver errores.
5. Repetir la consulta de solo lectura. Deben aparecer seis tablas con RLS activado, sus políticas, las cuatro funciones y los triggers. Inspeccionar también privilegios. Si existe el historial supabase_migrations, consultar sus versiones como indica el archivo. Una ejecución desde SQL Editor no agrega automáticamente la versión al historial; registrar fecha y ejecución manual y conciliarla antes de adoptar migraciones CLI.
6. En Authentication → configuración de proveedores/registro, deshabilitar nuevas altas públicas y mantener acceso por invitación. Configurar Site URL y Redirect URLs con el origen HTTPS de desarrollo que realmente se vaya a usar. No poner un localhost de esta máquina como dirección accesible al usuario. Aún no se ha proporcionado un origen de desarrollo accesible al navegador; deberá definirse antes de probar enlaces de correo.
7. Configurar SMTP para enviar invitaciones y recuperación a las direcciones reales autorizadas; no compartir sus credenciales aquí. Revisar requisitos de contraseña y correo. No invitar aún hasta verificar esquema y redirects.
8. Después de verificar lo anterior, ir a Authentication → Users → Invite user y utilizar el correo real de la persona administradora. El trigger creará un perfil desactivado y sin roles. Copiar su UUID desde el panel.
9. En SQL Editor, sustituir el UUID del siguiente bloque por ese UUID real y ejecutarlo una sola vez. El bloque se detiene si no encuentra el perfil. No concede privilegios a partir de datos del navegador.

```sql
begin;
do $$
declare target uuid := '<UUID_REAL_DEL_USUARIO_INVITADO>';
begin
 if not exists(select 1 from auth.users where id=target) then
  raise exception 'Usuario Auth inexistente';
 end if;
 update public.user_profiles set active=true where id=target;
 if not found then raise exception 'Perfil ausente: verificar migración y trigger'; end if;
 insert into public.user_roles(user_id,role) values(target,'admin')
 on conflict(user_id,role) do nothing;
end $$;
commit;
```

Si la cuenta ya existía antes de instalar el trigger, su perfil no se crea retroactivamente. Detenerse y revisar ese caso por separado antes de activar permisos.

10. Abrir la invitación en el origen de desarrollo configurado, establecer una contraseña personal e iniciar sesión. Debe aparecer Administración, Mis clientes, Almacenes y Auditoría como accesos asignados, sin presentar esos módulos como terminados. Probar cierre de sesión y recuperación de contraseña. No enviar contraseñas ni tokens de sesión por chat.
11. Realizar pruebas de acceso con cuentas reales autorizadas de desarrollo: ausencia de privilegios por defecto, vendedor sin administración, RLS por registro y suspensión efectiva. No crear clientes o ventas ficticias en producción. Las pruebas automatizadas de la carpeta tests se ejecutan exclusivamente sobre una base efímera.
12. Para guardar el código en GitHub, revisar primero `git status` y los archivos (no incluir .env, dist ni node_modules). Desde el checkout, crear el primer commit de los archivos fuente revisados y enviarlo a main mediante el acceso GitHub autorizado. Este trabajo solo comprobó el remoto: no hizo commit ni push. Confirmar después en GitHub que aparecen README, src y supabase y que el SHA coincide con el commit local.

No avanzar a Fase 1 hasta comprobar conexión API con clave válida, tablas y políticas reales, invitación, sesión, recuperación y permisos con usuarios autenticados. No se desplegó la aplicación comercial ni se modificaron datos del proyecto Supabase durante esta revisión.
