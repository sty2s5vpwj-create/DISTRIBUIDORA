# PROMPT MAESTRO DE DESARROLLO
## Sistema Integral de Gestión para Distribuidora Comercial — SIGDC
**Versión de especificación: 1.0**

### 1. Rol y objetivo

Actúa como un equipo senior de desarrollo de software compuesto por un arquitecto de sistemas, un desarrollador frontend, un desarrollador backend, un especialista en bases de datos PostgreSQL, un diseñador UX/UI y un especialista en seguridad y pruebas.

Tu objetivo es **construir una aplicación web progresiva (PWA) real, instalable y funcional**, destinada a gestionar la operación comercial de una distribuidora mexicana.

No desarrolles una demostración visual desconectada ni una aplicación que dependa de datos ficticios. Construye software modular, mantenible, documentado, seguro y preparado para operar con usuarios simultáneos.

El sistema deberá manejar inventarios, proveedores, múltiples almacenes, clientes, vendedores, compras, pedidos, entregas, cobranza, comisiones, reportes y recomendaciones automáticas basadas en información histórica.

La aplicación será exclusivamente para uso interno de la distribuidora. Los clientes continuarán enviando sus solicitudes por WhatsApp y los vendedores las registrarán manualmente.

**Condiciones obligatorias:**
- Todos los módulos acordados deben estar funcionales antes del lanzamiento de la primera versión.
- Organiza el desarrollo por fases y verifica cada una antes de avanzar.
- Utiliza una base de datos real y persistente.
- Implementa operaciones críticas mediante transacciones seguras.
- No simules funcionalidades pendientes como si estuvieran terminadas.
- No inventes reglas comerciales, cifras, precios, comisiones o clientes.
- Cuando falte información, utiliza parámetros configurables y documenta los pendientes.
- El código fuente y la infraestructura deberán pertenecer a cuentas controladas por la distribuidora.
- Toda la interfaz deberá estar en español.

### 2. Tecnología y arquitectura

Utiliza preferentemente:

- Frontend: React, TypeScript y Vite.
- Interfaz: Tailwind CSS y componentes accesibles tipo shadcn/ui.
- Base de datos: PostgreSQL mediante Supabase.
- Autenticación: Supabase Auth.
- Seguridad de datos: Row Level Security (RLS) y permisos verificados en servidor.
- Backend: funciones PostgreSQL transaccionales y Supabase Edge Functions cuando corresponda.
- Tiempo real: Supabase Realtime con acceso restringido por usuario.
- Gráficos: Recharts o biblioteca equivalente.
- Tablas: componentes con búsqueda, filtros, ordenamiento y paginación.
- Excel: exportación real a XLSX mediante una biblioteca mantenida y con licencia adecuada.
- Códigos: generación de Code 128 y lectura por cámara o lector compatible.
- PWA: manifest, iconos, service worker y soporte de instalación.
- Hosting de frontend: Cloudflare Pages.
- Control de versiones: Git y GitHub.

No utilices servicios adicionales de pago sin documentar previamente su necesidad.

Diseña una estructura modular que permita cambiar o ampliar componentes sin reconstruir toda la aplicación.

La plataforma deberá requerir internet para consultar o modificar información operativa. Cuando no exista conexión, deberá indicar claramente que no es posible completar transacciones. Nunca confirmes una operación si no fue guardada correctamente.

### 3. Contexto del negocio

La distribuidora comercializa productos provenientes de diferentes proveedores. Su proveedor principal actual suministra tizanas, pero la plataforma no deberá identificarse como una aplicación exclusiva de tizanas.

Situación inicial:
- 3 administradores.
- Entre 10 y 15 vendedores.
- Almacenes actuales: Cuautitlán Izcalli y Atizapán, Estado de México.
- Crecimiento previsto a 3 o 4 almacenes.
- 1 proveedor actual.
- Capacidad inicial para al menos 20 proveedores, ampliable.
- Aproximadamente 15 productos o combinaciones comerciales iniciales.
- Productos con diferentes ingredientes y presentaciones.
- Crecimiento gradual en los primeros 4 meses, con mayor expansión posterior.
- Moneda base: MXN.
- Zona horaria: America/Mexico_City.

Ejemplos de productos:
- Besos de manzana: manzana golden, pétalos de rosa, menta y pera.
- Bugambilia: manzana rayada, piña, eucalipto, gordolobo, canela y bugambilia.
- Ponche de frutas: manzana rayada, guayaba, jamaica, canela, pasa y tejocote.

Presentaciones posibles: 50 g, 150 g, 450 g, 500 g y 1 kg, según el producto.

Las presentaciones de 500 g y 1 kg pueden utilizarse para atender pedidos mayores.

No generes automáticamente todas las presentaciones para todos los productos. Permite crear únicamente las variantes comercializadas.

### 4. Sistema de usuarios y permisos

Implementa roles combinables y permisos por función y por registro.

**Administrador**

Tendrá acceso autorizado a:
- Todos los almacenes y movimientos.
- Todos los clientes y sus historiales.
- Todos los proveedores.
- Costos, precios y rentabilidad.
- Ventas y reportes consolidados.
- Compras y autorizaciones.
- Comisiones y reglas comerciales.
- Cuentas por cobrar.
- Parámetros de inventario.
- Asignación de empleados, clientes y almacenes.
- Bitácoras de auditoría.
- Configuración general.

Inicialmente existirán 3 administradores. Cualquiera de ellos podrá autorizar las operaciones sujetas a aprobación. Los administradores también podrán desempeñar funciones de vendedor.

**Vendedor**

Podrá:
- Consultar sus clientes asignados.
- Ver datos de contacto, dirección, ubicación y municipio.
- Registrar pedidos de sus clientes.
- Consultar los precios de venta aplicables.
- Consultar sus pedidos, estados y entregas.
- Solicitar preparación al almacén correspondiente.
- Confirmar recolecciones y entregas cuando sea responsable.
- Adjuntar evidencias.
- Recibir alertas de seguimiento comercial.
- Registrar los resultados de sus contactos.

No podrá:
- Consultar clientes ajenos.
- Acceder al análisis general de consumo de clientes.
- Consultar costos de adquisición y márgenes de utilidad.
- Ver información financiera global.
- Cambiar mínimos, precios base o reglas de comisión.
- Autorizar compras o alterar el historial de ventas.
- Acceder a los reportes consolidados de administración.

**Almacenista**

Podrá:
- Consultar inventario operativo de sus almacenes autorizados.
- Registrar recepciones.
- Preparar pedidos.
- Identificar lotes mediante códigos.
- Registrar movimientos permitidos.
- Gestionar solicitudes de traspaso según permisos.
- Consultar pendientes y faltantes.

No podrá acceder a costos, comisiones, rentabilidad o historiales comerciales confidenciales.

**Creación de cuentas**

Un administrador creará o invitará a cada usuario y le asignará los permisos autorizados.

El empleado completará sus datos personales y establecerá sus credenciales por un procedimiento seguro.

No deberá existir registro público que permita autoseleccionar privilegios. Si se presenta una opción para solicitar rol, esta no concederá permisos sin aprobación administrativa.

Implementa:
- Inicio y cierre de sesión.
- Recuperación segura de contraseña.
- Suspensión de usuarios.
- Permisos granulares.
- Asignación de uno o varios roles.
- Asignaciones a almacenes y clientes.
- Registro de accesos y operaciones críticas.

### 5. Catálogo de proveedores y productos

Permite registrar proveedores con datos comerciales, dirección, contactos, estado y catálogo exclusivo.

Cada producto comercial pertenece a un único proveedor.

Cada producto tendrá:
- Identificador interno.
- Proveedor.
- Nombre comercial.
- Ingredientes.
- Descripción opcional.
- Imagen opcional.
- Estado activo/inactivo.
- Variantes de presentación.

Cada combinación comercial válida de producto y presentación tendrá un SKU permanente y único.

El sistema deberá permitir agregar categorías y productos de nuevos proveedores sin modificaciones estructurales.

Los precios de adquisición serán configurables por administración, con historial de vigencia. Actualmente son estables, los proveedores cobran de contado y los fletes están incluidos en sus precios.

El sistema no deberá imponer cantidades mínimas de compra a proveedores.

### 6. Inventarios y lotes

Gestiona existencias independientes por SKU, lote y almacén.

Distingue rigurosamente:
- Existencia física.
- Cantidad reservada.
- Cantidad disponible.
- Mercancía en tránsito entre almacenes.
- Cantidad pendiente de recibir.
- Cantidad despachada.
- Cantidad devuelta y pendiente de revisión.

La disponibilidad deberá calcularse de forma consistente, restando las reservas activas a las existencias físicas y considerando compromisos de transferencia cuando corresponda.

**Registro de recepción**

Al recibir mercancía:
1. Seleccionar orden de compra o recepción autorizada.
2. Identificar proveedor y almacén.
3. Registrar producto, presentación y cantidad recibida.
4. Comparar contra la cantidad solicitada.
5. Registrar faltantes o diferencias.
6. Generar un lote único con fecha y hora de entrada.
7. Identificar al empleado responsable.
8. Actualizar inventario mediante una transacción.
9. Generar una etiqueta imprimible con código de barras.

El SKU identifica el producto y presentación. El lote identifica una entrada específica. No cambies el SKU por cada recepción.

Los lotes tendrán un registro de antigüedad.

Si el proveedor no proporciona fecha oficial de vencimiento, almacena la fecha de vencimiento como valor desconocido. No inventes fechas de caducidad a partir del ingreso al almacén.

Permite mostrar días en almacén y establecer alertas configurables de antigüedad.

Sugiere utilizar primero los lotes más antiguos cuando no exista información de vencimiento que indique otra prioridad.

**Traspasos**

Permite solicitudes de transferencia entre almacenes, con origen, destino, SKU, lote, cantidad, responsable, estado y confirmación de recepción.

No aumentes la existencia del almacén receptor antes de registrar la recepción correspondiente. Conserva la mercancía en estado de tránsito durante el traslado.

Impide existencias negativas y duplicación de movimientos.

### 7. Políticas de stock y reposición

Los productos habituales tendrán parámetros independientes por SKU y almacén.

Incluye:
- Stock mínimo configurable por administración.
- Nivel objetivo de inventario por almacén.
- Alertas al alcanzar o quedar por debajo del mínimo.
- Historial de modificaciones.
- Recomendaciones de aumento o disminución según consumo.
- Revisión analítica cada 14 días.

No combines automáticamente las necesidades de todos los almacenes: calcula cada requerimiento por separado antes de consolidar una propuesta de compra por proveedor.

Considera ventas históricas, demanda asociada a vendedores y clientes, reservas, pedidos pendientes y existencias existentes.

Las recomendaciones deben explicar qué datos y periodo se utilizaron.

Los cambios automáticos a mínimos y niveles objetivo estarán prohibidos sin autorización de un administrador.

**Productos de temporada**

Incluye un interruptor activable y desactivable exclusivamente por administradores.

Cuando una variante se encuentre en modo temporada:
- No se aplicarán mínimos ordinarios de almacenamiento.
- La compra sugerida responderá a pedidos de clientes confirmados.
- Se descontarán las existencias utilizables y compras pendientes para evitar duplicaciones.
- El producto seguirá apareciendo en inventario y ventas.
- El sistema conservará su historial y configuración normal para cuando se desactive el modo temporada.

### 8. Gestión de clientes

Implementa un expediente comercial con:
- Nombre comercial o razón social.
- Contactos autorizados.
- Teléfono y WhatsApp.
- Dirección de entrega.
- Municipio.
- Datos de ubicación.
- Vendedor asignado.
- Almacén asociado.
- Condiciones comerciales.
- Métodos de pago.
- Condiciones de crédito autorizadas.
- Observaciones administrativas.
- Estado del cliente.
- Historial de pedidos y pagos.
- Frecuencia de compra.
- Consumo por producto.
- Indicadores de evolución comercial.

Separa los datos de contacto visibles para vendedores de las estadísticas y datos sensibles visibles solamente para administración.

Los permisos deberán restringir también las consultas directas a base de datos y archivos.

Conserva un historial auditable cuando cambie el vendedor asignado a un cliente.

### 9. Registro y procesamiento de pedidos

Los vendedores capturarán manualmente los pedidos recibidos mediante WhatsApp.

La interfaz seguirá este orden:
1. Seleccionar cliente asignado.
2. Seleccionar proveedor.
3. Buscar producto por nombre o imagen.
4. Seleccionar presentación.
5. Introducir cantidad.
6. Calcular precio y descuentos aplicables.
7. Agregar al carrito.
8. Permitir agregar productos de otros proveedores.
9. Visualizar resumen, subtotales y total.
10. Confirmar y generar un folio único.

El pedido deberá almacenar una copia histórica de los precios y descuentos aplicados.

**Estados operativos**

Implementa un flujo trazable que contemple:
- Pedido registrado y pendiente de confirmación, cuando aplique.
- Procesando o reservado.
- En preparación.
- Preparado.
- Recolectado o despachado.
- Parcialmente despachado.
- Entregado.
- Parcialmente entregado.
- Cancelado cuando corresponda.
- Devuelto o con devolución parcial.

Al confirmar un pedido, reserva existencias disponibles.

No contabilices la reserva como venta.

Cuando se despache mercancía, disminuye la existencia física, libera la reserva correspondiente y registra la cantidad despachada en los reportes de ventas.

Si un pedido se cancela antes de salir del almacén, libera la reserva sin registrar venta.

No permitas borrar una venta despachada para simular una cancelación. Utiliza un proceso controlado de devolución o ajuste.

Permite pedidos incompletos, pero identifica y comunica los faltantes para evitar entregas múltiples innecesarias.

Las operaciones de pedido y de inventario deberán ser atómicas y seguras frente a usuarios simultáneos.

### 10. Entregas y devoluciones

Registrar:
- Folio de pedido.
- Almacén de origen.
- Responsable de preparación.
- Fecha y hora de salida.
- Responsable de recolección.
- Responsable de entrega.
- Fecha y hora de entrega.
- Cantidades entregadas.
- Evidencia adjunta.
- Observaciones e incidencias.

El vendedor o repartidor autorizado confirmará la entrega.

Genera una alerta de retraso cuando hayan transcurrido 48 horas desde la recolección y la mercancía siga sin entrega confirmada.

Las devoluciones deberán registrar:
- Pedido original.
- Productos y cantidades.
- Motivo.
- Evidencia, si corresponde.
- Condición del producto.
- Resolución aprobada: reposición, reembolso u otra acción autorizada.
- Relación con el proveedor cuando deba solicitarse reposición o devolución.

La mercancía devuelta no deberá volver automáticamente al inventario disponible sin revisión y autorización operativa.

### 11. Precios, ventas, comisiones y cobranza

Implementa:
- Lista de precios de venta.
- Descuentos configurables por volumen.
- Ajustes por método de pago.
- Historial de precios.
- Reglas de comisión por vendedor.
- Ventas netas.
- Costos y utilidad.
- Cuentas por cobrar.
- Registro de pagos.
- Saldos pendientes.
- Comprobantes internos de pedido y pago.
- Folios únicos y consecutivos.

Los métodos de pago actuales son principalmente efectivo y transferencia.

El crédito solo podrá habilitarse para clientes autorizados por administración, conforme a las condiciones configuradas.

Permite pagos parciales, pagos múltiples y conciliación contra pedidos.

No confundas venta despachada, ingreso cobrado y utilidad.

Calcula los márgenes con los costos históricos correspondientes a los lotes despachados, considerando descuentos y devoluciones.

El cálculo de comisiones deberá provenir de reglas configuradas por administración. Como la fórmula definitiva aún no está establecida, no inventes porcentajes ni autorices liquidaciones basadas en valores de prueba.

Los vendedores podrán consultar los importes necesarios para registrar y entregar sus pedidos, pero no tendrán acceso a costos internos, márgenes ni estados financieros generales.

Prepara la arquitectura para incorporar posteriormente facturación electrónica mexicana, sin simular la emisión de CFDI en esta primera versión.

### 12. Compras a proveedores

Crea un módulo de propuestas automáticas y órdenes manuales.

Las propuestas se agruparán por proveedor e incluirán:
- SKU y descripción.
- Presentación.
- Almacén de destino.
- Existencia actual.
- Cantidad reservada.
- Stock mínimo, si aplica.
- Nivel objetivo.
- Pedidos pendientes.
- Cantidad sugerida.
- Costo unitario.
- Importe total.
- Justificación de la recomendación.

Las recomendaciones deberán ser editables.

Una propuesta no será una compra autorizada.

Solo un administrador podrá convertirla en orden de compra aprobada. Registra quién la autorizó, fecha, hora y cambios efectuados.

Permite órdenes de compra manuales.

La recepción podrá realizarse en una o varias operaciones hasta completar la cantidad solicitada o cerrar justificadamente la orden.

La distribución sugerida por almacén dependerá de la demanda real y de los vendedores/clientes asociados, no de porcentajes iguales.

No presupongas calendarios o plazos fijos de entrega del proveedor; la distribuidora organiza sus propias recolecciones.

### 13. Inteligencia comercial

Desarrolla inicialmente algoritmos estadísticos explicables, evitando depender de servicios externos de IA para cálculos que pueden realizarse con el historial.

Para cada cliente calcula, cuando existan datos:
- Fecha del último pedido despachado.
- Productos comprados.
- Frecuencia de compra.
- Intervalo habitual entre pedidos.
- Cantidad media adquirida.
- Tendencia de consumo.
- Próxima fecha probable de pedido.
- Nivel de confianza de la estimación.

Utiliza únicamente operaciones comerciales válidas; excluye pedidos cancelados antes del despacho.

La alerta comercial deberá aparecer 3 días antes de la fecha probable de resurtido.

Si el historial es insuficiente, muestra claramente que todavía no existe una estimación confiable.

Genera indicadores para detectar reducciones de consumo, clientes inactivos y desviaciones de sus patrones habituales.

Cada vendedor verá únicamente las recomendaciones correspondientes a sus clientes.

Permitirá registrar:
- Contactado.
- No respondió.
- Realizó pedido.
- Recordar más tarde.

Los administradores podrán analizar qué notificaciones se atendieron, cuándo y con qué resultado.

No inventes probabilidades ni precisión estadística. Documenta la metodología y sus límites.

### 14. Centro de alertas y notificaciones

Crea un centro de notificaciones dentro de la plataforma, adaptado a los permisos.

**Alertas persistentes de inventario**
- Aparecerán al llegar al mínimo o quedar por debajo.
- No podrán eliminarse manualmente.
- Se resolverán cuando el inventario disponible vuelva al nivel establecido.
- Se conservará el historial de incidencias.
- Se evitarán alertas duplicadas de un mismo evento.

**Alertas comerciales**
- Se evaluarán una vez al día.
- Aparecerán al vendedor correspondiente.
- Podrán descartarse o marcarse como atendidas.
- El seguimiento permanecerá en el historial administrativo.

**Alertas de entregas**
- Advertencia después de 48 horas desde la recolección sin entrega confirmada.
- Identificación de pedido, responsable y estado.
- Cierre al resolver la incidencia, conservando la auditoría.

**Compras y autorizaciones**
- Notificaciones al generar propuestas.
- Avisos de operaciones pendientes de autorización.
- Registro de decisiones administrativas.

### 15. Reportes y análisis administrativo

Diseña un dashboard con filtros por fechas, proveedor, producto, presentación, almacén y vendedor.

Mostrar, según permisos:
- Ventas totales.
- Ventas netas.
- Utilidad.
- Ventas por proveedor.
- Ventas por almacén.
- Ventas por vendedor.
- Cantidades vendidas por SKU.
- Rotación de inventario.
- Existencias y reservas.
- Pedidos pendientes.
- Entregas atrasadas.
- Devoluciones.
- Clientes activos e inactivos.
- Variación mensual de ventas.
- Desempeño contra objetivos configurables.
- Comisiones y cuentas por cobrar.

Los reportes se generarán mensualmente por defecto, pero su periodicidad será configurable por administración.

Permite generar archivos XLSX auténticos, separados por:
- Reporte general.
- Vendedores.
- Proveedores.
- Almacenes.

Cada archivo podrá incluir múltiples hojas individuales y consolidadas con datos estructurados, encabezados claros y fechas.

No incluyas datos confidenciales en exportaciones realizadas por perfiles no autorizados.

Las gráficas siempre deberán corresponder a registros existentes y filtros aplicados, no a datos ficticios.

### 16. Interfaz y experiencia de usuario

La identidad visual inicial será provisional y configurable.

Utiliza un diseño empresarial sobrio, limpio, moderno, accesible y adaptable.

Debe funcionar en:
- Computadoras para administración.
- Celulares para vendedores.
- Computadoras y tabletas para almacenistas.

**Panel de administración**

Incluye navegación hacia configuración, usuarios, clientes, vendedores, proveedores, catálogo, inventarios, almacenes, pedidos, entregas, compras, ventas, finanzas, reportes y alertas.

**Panel del vendedor**

Prioriza:
- Mis clientes.
- Crear pedido.
- Mis pedidos pendientes.
- Pedidos por entregar.
- Pedidos entregados.
- Mis notificaciones.
- Seguimiento comercial.

**Panel de almacén**

Prioriza:
- Existencias.
- Entradas y recepciones.
- Pedidos por preparar.
- Salidas.
- Lotes.
- Traspasos.
- Alertas operativas.

Utiliza buscadores rápidos, filtros combinables, tablas ordenables, botones claros y estados fácilmente identificables.

Utiliza indicadores verdes para existencias disponibles y amarillos para mercancía en proceso, complementados con texto y cantidades. No dependas únicamente de los colores.

El administrador podrá modificar nombre comercial, logotipo y colores de la plataforma desde un módulo de configuración.

### 17. Códigos de barras y escaneo

Genera etiquetas imprimibles utilizando equipos convencionales.

Cada código deberá identificar de forma unívoca el lote o la unidad logística correspondiente.

Permite:
- Generar e imprimir etiquetas.
- Escanear mediante cámara de celular.
- Utilizar lectores de código de barras compatibles.
- Consultar datos del lote.
- Registrar entradas y salidas autorizadas.
- Evitar movimientos repetidos mediante validaciones.

La arquitectura deberá permitir incorporar impresoras y lectores especializados posteriormente.

### 18. Modelo de datos

Construye un esquema PostgreSQL normalizado, con claves primarias, claves foráneas, restricciones, índices, marcas de tiempo y reglas de integridad.

Incluye como mínimo los siguientes conjuntos de entidades:

**Organización y usuarios**
`company_settings`, `warehouses`, `user_profiles`, `user_roles`, `user_warehouse_assignments`.

**Proveedores y productos**
`suppliers`, `products`, `product_ingredients`, `product_variants`, `product_prices`.

**Inventarios**
`inventory_lots`, `stock_movements`, `stock_reservations`, `stock_policies`, `stock_transfers`.

**Clientes**
`customers`, `customer_contacts`, `customer_assignments`, `customer_followups`.

**Pedidos**
`orders`, `order_items`, `order_status_history`.

**Entregas y devoluciones**
`shipments`, `shipment_items`, `delivery_evidence`, `returns`.

**Compras**
`purchase_orders`, `purchase_order_items`, `purchase_receipts`, `purchase_receipt_items`.

**Finanzas**
`payments`, `accounts_receivable`, `commission_rules`, `commissions`.

**Automatización y auditoría**
`notifications`, `purchase_recommendations`, `customer_forecasts`, `report_jobs`, `audit_logs`.

Agrega las entidades auxiliares necesarias para mantener una estructura coherente.

Evita guardar duplicados de información calculable, salvo cuando se trate de valores históricos que deban conservarse.

Diseña vistas o funciones seguras para obtener existencias y estadísticas.

Todas las operaciones que modifiquen stock deberán ser transaccionales y seguras ante concurrencia.

Implementa mecanismos de idempotencia para evitar que un doble clic, una solicitud repetida o un error de conexión dupliquen una reserva, despacho o pago.

### 19. Seguridad obligatoria

- Habilita políticas RLS para todas las tablas expuestas.
- Aplica el principio de mínimo privilegio.
- Valida roles en operaciones del servidor y de la base de datos.
- No confíes en roles, precios o permisos enviados desde el navegador.
- Protege credenciales y secretos.
- Nunca expongas claves administrativas en el frontend.
- Restringe archivos y evidencias a usuarios autorizados.
- Valida tipos, cantidades, precios y estados.
- Protege contra operaciones duplicadas.
- Implementa bitácoras de auditoría.
- Almacena contraseñas únicamente mediante el sistema seguro de autenticación.
- Prepara mecanismos de copia de seguridad y restauración.
- No incluyas información personal confidencial en registros técnicos innecesarios.
- Separa ambientes de desarrollo y producción.
- Verifica las políticas de privacidad y tratamiento de datos antes del lanzamiento.

Las acciones críticas deberán registrar al menos usuario, operación, fecha, hora, entidad afectada, almacén o contexto operativo y cambios realizados.

### 20. Automatizaciones

Implementa tareas programadas que funcionen independientemente de que un usuario tenga abierta la plataforma.

Las tareas principales son:
- Verificación de mínimos al producirse cambios en inventario.
- Revisión quincenal de consumo y niveles objetivo.
- Generación diaria de recomendaciones de seguimiento de clientes.
- Detección de entregas con más de 48 horas sin confirmar.
- Generación mensual configurable de reportes.
- Detección de faltantes en órdenes de compra.
- Actualización de proyecciones cuando existan nuevos datos.

Registra el resultado de cada ejecución, incluyendo errores.

Las recomendaciones no deberán modificar automáticamente parámetros financieros, mínimos o compras sin autorización.

### 21. Pruebas y criterios de aceptación

Implementa pruebas unitarias, de integración y de extremo a extremo para validar al menos los siguientes escenarios:

1. Un administrador crea una cuenta de vendedor y le asigna clientes.
2. El vendedor no puede consultar clientes ajenos mediante la interfaz ni solicitando datos directamente.
3. El vendedor no puede acceder a márgenes de utilidad o costos.
4. El administrador puede actuar también como vendedor.
5. Una recepción crea correctamente lote y existencias.
6. El sistema detecta recepciones parciales.
7. Dos usuarios no pueden reservar simultáneamente más existencias de las disponibles.
8. Un pedido confirmado reduce disponibilidad, pero no la existencia física.
9. Un pedido cancelado antes del despacho libera la reserva.
10. Un pedido cancelado sin despacho no incrementa ventas.
11. El despacho reduce inventario físico y registra la venta una sola vez.
12. Los pedidos parciales no duplican importes ni movimientos.
13. Los traspasos no duplican mercancía.
14. Las alertas de mínimos permanecen hasta resolverse.
15. Los productos de temporada no generan reposición automática basada en mínimos.
16. Una orden de compra requiere aprobación administrativa.
17. El sistema calcula propuestas independientes por almacén.
18. Se dispara una advertencia después de 48 horas sin entrega confirmada.
19. Las recomendaciones comerciales se generan únicamente con datos válidos.
20. Los vendedores pueden registrar seguimiento a sus clientes.
21. Los administradores pueden consultar las bitácoras.
22. Las exportaciones XLSX contienen datos reales y respetan permisos.
23. Los pagos parciales actualizan correctamente el saldo.
24. Una devolución mantiene trazabilidad respecto del pedido original.
25. La aplicación puede instalarse como PWA.
26. Los códigos de barras identifican correctamente los lotes.
27. Las operaciones fallidas no dejan inventarios o saldos inconsistentes.
28. Una solicitud repetida no produce cobros, reservas o movimientos duplicados.

No consideres terminada una funcionalidad si solamente existe su pantalla.

### 22. Estrategia de implementación

Construye el sistema por fases, pero no publiques la primera versión operativa hasta completar e integrar todos los módulos.

**Fase 0 — Base técnica**

Crear repositorio, estructura de carpetas, configuración, conexión a Supabase, migraciones, autenticación, roles, permisos y navegación inicial.

Entregable: una aplicación conectada a la base de datos con acceso seguro según roles.

**Fase 1 — Catálogo y organización**

Implementar proveedores, productos, ingredientes, variantes, SKU, almacenes, usuarios y clientes.

Entregable: formularios CRUD funcionales, validaciones y permisos.

**Fase 2 — Inventario y trazabilidad**

Implementar recepciones, lotes, existencias, reservas, traspasos, códigos de barras, mínimos y auditoría de movimientos.

Entregable: inventario real, consistente y utilizable.

**Fase 3 — Pedidos y entregas**

Implementar captura comercial, precios, descuentos, folios, preparación, despachos, entregas, cancelaciones, faltantes y devoluciones.

Entregable: flujo completo desde registro del pedido hasta entrega y resolución de incidencias.

**Fase 4 — Compras y finanzas**

Implementar órdenes de compra, sugerencias, autorizaciones, recepción parcial, ventas, pagos, cuentas por cobrar y reglas configurables de comisiones.

Entregable: control comercial y financiero conectado al inventario.

**Fase 5 — Analítica y automatizaciones**

Implementar proyecciones de demanda, seguimiento de clientes, alertas, recomendaciones de compra, paneles y reportes XLSX.

Entregable: sistema de análisis y automatización con información real.

**Fase 6 — PWA y puesta en producción**

Completar experiencia móvil, instalación PWA, escaneo, accesibilidad, pruebas integrales, medidas de seguridad, respaldos, documentación y despliegue.

Entregable: aplicación lista para pruebas de aceptación y lanzamiento.

Cada fase deberá incluir pruebas y documentación. Las funcionalidades de una fase podrán reutilizar los módulos ya construidos sin duplicar lógica.

### 23. Información pendiente y valores iniciales

No inventes los siguientes datos:
- Nombre definitivo de la empresa.
- Identidad gráfica y logotipo.
- Número exacto de clientes.
- Cantidad exacta de empleados por almacén.
- Precios de compra y venta.
- Rangos de descuento por volumen.
- Ajustes de precio por método de pago.
- Porcentajes y criterios de comisiones.
- Límites y plazos de crédito.
- Mínimos y niveles objetivo de cada SKU.
- Umbrales de antigüedad de lotes.
- Metas comerciales.
- Catálogo comercial completo.

Todos deberán configurarse desde administración.

Utiliza como propuestas iniciales, sujetas a confirmación:
- Moneda MXN.
- Fechas en formato local mexicano.
- Reportes mensuales.
- Revisión de inventario cada 14 días.
- Alertas de seguimiento 3 días antes de la compra estimada.
- Alerta de entrega a las 48 horas.
- Ventana de análisis histórica configurable, inicialmente de 30 a 60 días.
- Estimaciones comerciales marcadas como poco confiables cuando existan menos de 3 compras válidas.
- Comisiones deshabilitadas para liquidación hasta configurar sus reglas.

No completes datos ausentes con valores comerciales ficticios en producción.

### 24. Entregables técnicos y forma de trabajo

Antes de generar código, presenta:
1. Arquitectura general.
2. Estructura del repositorio.
3. Modelo entidad-relación.
4. Matriz de permisos.
5. Plan de implementación y dependencias.
6. Decisiones técnicas y riesgos.

Después construye el proyecto y entrega progresivamente:
- Código fuente.
- Migraciones SQL.
- Políticas RLS.
- Funciones de base de datos.
- Componentes y pantallas.
- Pruebas automatizadas.
- Variables de entorno de ejemplo sin secretos.
- Instrucciones de instalación.
- Instrucciones de despliegue.
- Documentación administrativa.
- Registro de problemas pendientes.

Utiliza datos de demostración solamente en un entorno de pruebas claramente separado de producción.

Al terminar cada fase, indica qué funcionalidades están implementadas, qué pruebas se ejecutaron realmente, cuáles fueron sus resultados y qué tareas continúan pendientes.

No afirmes que una función está implementada sin que exista código operativo y una forma de verificarla.

**Instrucción final:**

Comienza realizando el diseño de arquitectura, modelo de datos y plan de implementación. Después implementa la Fase 0 con código ejecutable, migraciones y pruebas. Mantén este documento como referencia maestra durante todo el desarrollo y continúa conforme a las fases, respetando las dependencias técnicas.

El objetivo no es obtener una maqueta, sino una plataforma comercial integral, fiable, segura, escalable y adecuada para el funcionamiento real de la distribuidora.