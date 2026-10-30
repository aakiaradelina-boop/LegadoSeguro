
## **Anexo C. Requerimientos funcionales y no funcionales** 

### **C.1. Consideración metodológica** 

Los requerimientos incluidos en este avance son **preliminares** . Se formularon a partir de las necesidades identificadas durante el análisis inicial, pero deberán ser validados y, cuando corresponda, modificados después de entrevistar a usuarios potenciales y consultar a un profesional legal. La numeración es correlativa y se mantiene independiente de versiones anteriores para facilitar la trazabilidad. 

### **M1. Autenticación, Roles y Verificación de Identidad** 

#### **<u>Requerimientos funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RF-01|El usuario deberá poder crear una cuenta para utilizar la plataforma.|
|RF-02|El usuario deberá poder iniciar y cerrar sesión de manera segura.|
|RF-03|El usuario deberá poder recuperar el acceso a su cuenta cuando olvide su contraseña.|
|RF-04|El propietario deberá poder verificar su identidad durante el registro, de acuerdo con el<br>mecanismo que se valide con los usuarios.|
|RF-05|El heredero deberá poder acreditar su identidad antes de confirmar una solicitud de liberación,<br>según el mecanismo definido para el proyecto.|
|RF-06|El propietario deberá poder designar y administrar las personas autorizadas para participar<br>en su proceso de legado.|



#### **<u>Requerimientos no funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RNF-01|Las credenciales de los usuarios deberán almacenarse de manera segura y no deberán<br>conservarse en texto plano.|
|RNF-02|El acceso a las funciones deberá limitarse según el tipo de usuario.|
|RNF-03|La información utilizada para verificar identidad deberá tratarse de acuerdo con las<br>condiciones de protección de datos aplicables.|



### **M2. Gestión de Activos Digitales** 

#### **<u>Requerimientos funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RF-07|El propietario deberá poder registrar los activos digitales que desea organizar.|
|RF-08|El propietario deberá poder consultar, modificar y retirar los activos que haya registrado.|
|RF-09|El propietario deberá poder indicar el tipo y nivel de sensibilidad de cada activo.|
|RF-10|El propietario deberá poder asociar un activo con una o más personas beneficiarias, de<br>acuerdo con las reglas definidas.|



#### **<u>Requerimientos no funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RNF-04|La información sensible que necesite ser recuperada deberá contar con medidas de<br>protección adecuadas.|
|RNF-05|Las operaciones habituales deberán ofrecer tiempos de respuesta adecuados para el uso<br>normal de la plataforma.|



### **M3. Gestión de Herederos y Validador Externo** 

#### **<u>Requerimientos funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RF-11|El propietario deberá poder registrar y designar personas beneficiarias.|
|RF-12|El propietario deberá poder modificar o retirar una designación mientras el proceso no haya<br>sido completado.|
|RF-13|El propietario deberá poder asociar beneficiarios con determinados activos.|
|RF-14|El propietario deberá poder designar un validador externo cuando considere necesario contar<br>con una revisión adicional.|



#### **<u>Requerimientos no funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RNF-06|El sistema deberá proteger los datos personales de los beneficiarios.|
|RNF-07|Las personas registradas como beneficiarias deberán recibir información clara sobre el uso<br>de sus datos y las acciones que se les soliciten.|



### **M4. Reglas de Liberación y Monitoreo de Inactividad** 

#### **<u>Requerimientos funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RF-15|El propietario deberá poder establecer las condiciones bajo las cuales desea iniciar un<br>proceso de liberación.|
|RF-16|El propietario deberá poder establecer un período de espera antes de completar el proceso.|
|RF-17|La plataforma deberá verificar periódicamente si el propietario mantiene actividad.|
|RF-18|Si se detecta una situación que cumpla las condiciones establecidas, la plataforma deberá<br>solicitar al propietario una confirmación antes de continuar.|
|RF-19|El propietario deberá poder cancelar el proceso mientras todavía sea posible hacerlo según<br>las reglas establecidas.|



#### **<u>Requerimientos no funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RNF-08|Las verificaciones periódicas deberán ejecutarse de forma programada sin requerir una<br>acción manual del usuario.|
|RNF-09|Una falla temporal de un servicio externo no deberá provocar la pérdida de la información<br>registrada.|



### **M5. Proceso de Liberación (Orquestación BPM)** 

#### **<u>Requerimientos funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RF-20|La plataforma deberá iniciar el proceso de liberación cuando se cumplan las condiciones<br>previamente establecidas.|
|RF-21|Los beneficiarios deberán poder confirmar su participación en el proceso mediante un<br>mecanismo seguro.|
|RF-22|La plataforma deberá respetar el período de espera establecido antes de completar la<br>liberación.|
|RF-23|El proceso deberá detenerse cuando exista una objeción que requiera revisión.|
|RF-24|Para los activos financieros, el proceso deberá requerir la confirmación de todos los<br>beneficiarios asociados antes de generar la orientación legal correspondiente.|
|RF-25|Un beneficiario deberá poder reportar el fallecimiento del propietario, sujeto al proceso de<br>revisión definido.|
|RF-26|La plataforma deberá diferenciar el tratamiento de los activos según su categoría y las reglas<br>definidas.|



#### **<u>Requerimientos no funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RNF-10|Las etapas críticas del proceso deberán quedar registradas para permitir su seguimiento.|
|RNF-11|El proceso deberá mantener un estado identificable para conocer en qué etapa se encuentra<br>cada solicitud.|



### **M6. Orientación Legal** 

#### **<u>Requerimientos funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RF-27|Cuando corresponda a un activo financiero, la plataforma deberá generar información de<br>orientación para el procedimiento externo.|
|RF-28|La orientación deberá indicar la documentación y entidad que correspondan según la<br>información disponible y validada.|
|RF-29|La plataforma deberá diferenciar claramente la orientación proporcionada de un trámite legal<br>realizado por la propia plataforma.|



#### **<u>Requerimientos no funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RNF-12|El contenido de orientación deberá poder actualizarse cuando cambien los procedimientos o<br>referencias normativas.|
|RNF-13|La información legal presentada deberá identificarse como orientación y no como sustituto de<br>asesoría jurídica profesional.|



### **M7. Notificaciones** 

#### **<u>Requerimientos funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RF-30|La plataforma deberá informar al propietario cuando se requiera una acción relacionada con<br>el proceso de liberación.|
|RF-31|La plataforma deberá informar a los beneficiarios cuando exista una solicitud que requiera su<br>participación.|
|RF-32|La plataforma deberá comunicar los cambios importantes de estado del proceso.|



#### **<u>Requerimientos no funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RNF-14|Las credenciales de los servicios de mensajería deberán mantenerse protegidas.|
|RNF-15|La indisponibilidad temporal de un canal de comunicación deberá gestionarse sin perder el<br>registro de la notificación pendiente.|



### **M8. Auditoría y Reportes** 

#### **<u>Requerimientos funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RF-33|La plataforma deberá registrar las acciones relevantes realizadas durante un proceso de<br>liberación.|
|RF-34|El administrador deberá poder consultar información sobre procesos activos y finalizados.|
|RF-35|La plataforma deberá permitir generar reportes de la información administrativa autorizada.|
|RF-36|El beneficiario deberá poder obtener un resumen del proceso cuando corresponda.|



#### **<u>Requerimientos no funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RNF-16|Los registros de auditoría deberán estar protegidos contra modificaciones no autorizadas.|
|RNF-17|Los eventos relevantes deberán conservar información suficiente para identificar qué acción<br>ocurrió y cuándo ocurrió.|



### **M9. Suscripciones y Pagos** 

#### **<u>Requerimientos funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RF-37|El usuario deberá poder consultar el plan disponible para su cuenta.|
|RF-38|El usuario deberá poder seleccionar el plan que corresponda dentro de la propuesta del<br>servicio.|
|RF-39|La plataforma deberá permitir realizar el pago mediante una pasarela habilitada para el<br>proyecto, en el ambiente de prueba correspondiente.|
|RF-40|El usuario deberá poder consultar el estado de su suscripción.|



#### **<u>Requerimientos no funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RNF-18|Los datos sensibles de las tarjetas no deberán almacenarse en la infraestructura propia.|
|RNF-19|Las credenciales utilizadas para la pasarela de pagos deberán mantenerse protegidas.|



### **M10. Administración y Gestión de Disputas** 

#### **<u>Requerimientos funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RF-41|El administrador deberá poder revisar las objeciones relacionadas con un proceso.|
|RF-42|El administrador deberá poder revisar los reportes de fallecimiento recibidos.|
|RF-43|El administrador deberá poder consultar información necesaria para atender incidencias del<br>proceso.|
|RF-44|El administrador deberá poder registrar el resultado de una revisión u objeción.|



#### **<u>Requerimientos no funcionales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RNF-20|Las funciones administrativas deberán estar disponibles únicamente para usuarios<br>autorizados.|
|RNF-21|Las acciones administrativas relevantes deberán quedar registradas en la auditoría.|



### **<u>C.2. Requerimientos no funcionales transversales</u>** 

|**ID**|**Requerimiento**|
|---|---|
|RNF-22|La solución deberá mantener una separación clara entre la interfaz, la lógica de negocio y el<br>acceso a datos.|
|RNF-23|El código deberá desarrollarse siguiendo principios SOLID y deberá contar con pruebas<br>unitarias en las funciones que corresponda.|
|RNF-24|La aplicación deberá poder ser construida y empaquetada mediante Maven.|
|RNF-25|El sistema deberá contar con registros de eventos que faciliten el diagnóstico y monitoreo.|
|RNF-26|La plataforma deberá aplicar medidas de protección de datos acordes con la normativa que<br>resulte aplicable y con las conclusiones de la validación legal.|



### **C.3. Trazabilidad inicial** 

La relación entre necesidades, módulos y requerimientos se revisará después de las entrevistas. Esta distribución constituye una primera guía: 

|**Necesidad identificada**|**Módulos relacionados**|
|---|---|
|Organizar el legado digital|M1, M2|
|Designar personas beneficiarias|M3|
|Definir cuándo y cómo iniciar la entrega|M4, M5|
|Informar a los participantes|M7|
|Mantener control del proceso|M8, M10|
|Tratar adecuadamente los activos financieros|M5, M6|
|Gestionar el modelo de servicio|M9|
|Proteger la información|M1, M2, M3, M8 y RNF transversales|



**Nota:** esta trazabilidad es preliminar. Las entrevistas con prospectos y la revisión legal podrán incorporar, eliminar o modificar necesidades y requerimientos. 

