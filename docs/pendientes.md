# Estado de implementación

Fase 0 parcial: código de acceso, recuperación y cambio de contraseña, resolución de roles, perfiles, almacenes, asignaciones y auditoría con RLS. La conexión real a Supabase, correo, invitaciones, gestión visual de usuarios, registro de accesos Auth y pruebas E2E están pendientes. Ninguna fase se declara completada sin esas comprobaciones.

Fases 1–6 pendientes. La interfaz enumera accesos asignados, pero no simula módulos comerciales. Los valores comerciales de la sección 23 permanecen sin configurar.

Las variables públicas de Supabase ya están presentes. La comprobación remota está bloqueada por un 403 del proxy de red; no se puede confirmar aún si la migración existe en el proyecto real. No se ejecutaron escrituras remotas. Consultar conexion-supabase.md para los pasos manuales y supabase/checks/phase0_readonly.sql para inspección de solo lectura. El código sigue sin commits ni referencias en GitHub. No se desplegó la aplicación comercial.
