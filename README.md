# SIGDC
Base técnica en desarrollo. No es una versión operativa; no contiene datos comerciales ficticios. Consulte [arquitectura](docs/arquitectura.md) y [especificación maestra](docs/especificacion-maestra.md).

## Desarrollo
Node.js 24 y npm. Desde `/workspace/DISTRIBUIDORA`:

```sh
npm ci
cp .env.example .env
# Completar únicamente URL y clave pública del proyecto Supabase de desarrollo.
npm run dev
```
No sobrescribir un `.env` existente. Nunca incluir service_role, contraseñas ni credenciales administrativas en variables VITE_. Sin configuración la aplicación muestra explícitamente conexión pendiente.

## Supabase de desarrollo
1. Crear o usar un proyecto bajo una cuenta controlada por la distribuidora, separado de producción.
2. Aplicar `supabase/migrations/202610200001_foundation.sql` mediante una conexión administrativa segura o el editor SQL. La migración es transaccional y se aplica una vez mediante el historial de migraciones.
3. Deshabilitar registro público en Auth. Configurar Site URL y Redirect URLs para el origen de desarrollo y posteriormente el dominio Cloudflare Pages. Configurar correo e invitaciones con SMTP verificado antes del uso real.
4. Invitar al primer administrador desde el panel Auth. Su perfil se crea desactivado; un operador autorizado activa el UUID y asigna el rol en una transacción. Sustituir el UUID de ejemplo por el usuario real; nunca ejecutar con un identificador inventado:

```sql
begin;
update public.user_profiles set active=true where id='<UUID_REAL>';
insert into public.user_roles(user_id,role) values('<UUID_REAL>','admin');
commit;
```

Las invitaciones desde la propia aplicación y la administración visual de usuarios siguen pendientes. La recuperación necesita configuración de correo y se completa con el formulario de contraseña después del enlace seguro. No se crea ninguna cuenta ni almacén automáticamente.

## Validación
```sh
npm test
npm run build
```
Prueba SQL reproducible en un PostgreSQL 17 **efímero y exclusivo para pruebas**:
```sh
docker run -d --name sigdc-db-test -e POSTGRES_HOST_AUTH_METHOD=trust postgres:17-alpine
# Esperar a que docker exec sigdc-db-test pg_isready -U postgres responda.
docker exec -i sigdc-db-test psql -U postgres -v ON_ERROR_STOP=1 < tests/bootstrap.sql
docker exec -i sigdc-db-test psql -U postgres -v ON_ERROR_STOP=1 < supabase/migrations/202610200001_foundation.sql
docker exec -i sigdc-db-test psql -U postgres -v ON_ERROR_STOP=1 < tests/security.sql
docker rm -f sigdc-db-test
```
No publicar puertos de ese contenedor ni usar autenticación trust para entornos reales. El bootstrap simula únicamente el contrato mínimo auth.uid; no es Supabase Auth.

## Despliegue futuro
Cloudflare Pages: comando `npm ci && npm run build`, salida `dist`, Node 24, variables públicas de Supabase. Configurar Auth para el dominio definitivo, aplicar migraciones por operador autorizado y realizar pruebas de aceptación antes de publicar. PWA, dominio, SMTP, copias de seguridad y restauración todavía no están preparados para producción.
