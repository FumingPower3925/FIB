# 4. Seguridad en la red

## 4.1 Firewall

**Definición**:

Un firewall es una parte de un sistema informático o red diseñada para bloquear el acceso no autorizado y permitir comunicaciones autorizadas. Hace uso de un conjunto de reglas y otros criterios para determinar si una conexion es legitima o no. 

Se necesita un firewall cuando:

- Cuando hay que conectar una red segura a una no segura
  
  - Red segura: Red privada, red corporativa...
  
  - Red no segura: Internet

**Lo que puede hacer**:

- Proporciona un único punto de defensa permitiendo asi un acceso controlado y auditado a los servicios prestados.

- Refuerza la seguridad del sistema ya que permite limitar la exposición a una red insegura y puede monitorear el tráfico entrante/saliente.

**Lo que NO puede hacer**:

- No puede proteger la red contra ataques malicioses desde dentro de la misma red segura.

- No puede proteger la red contra el tráfico que no la atraviesa.

- No puede proteger la red contra errores/malas configuraciones de los servicios autorizados.

- Cualquier dato de aplicación que lo atraviese tiene el potencial de causar problemas.

**Diferentes equipos de control de acceso**:

- Firewall a nivel de paquetes:
  
  - Inspecciona cada paquete que pasa a través de la red y lo acepta o rechaza según las reglas definidas por el administrador.

- Firewall a nivel de circuito:
  
  - Aplica mecanismos de seguridad que se aplica al establecer una conexión TCP/UDP
  
  - Una vez realizada, los paquetes pueden fluir sin más controles.

- Gateway de aplicaciones:
  
  - Aplica mecanismos de seguridad a aplicaciones esoecíficas, como servidores HTTP, correo...

- **Servidor proxy**:
  
  - Equipo intermediario entre origen y destino que puede tomnar determinadas decisiones basadas en la seguridad.

### 4.1.1 Topologías de firewall

**Dual-Homed**

- Topologia mas sencilla que hay.

- NO puede tener una DMZ

- Ventajas: El firewall solo necesita dos interfaces

- Ventajas: La configuración es muy simple

[Image 1]

**Two-Legged network with a full exposed DMZ**

- Permite tener una DMZ

- Ventajas: El firewall solo necesita dos interfaces

- Ventajas: La configuración es muy simple

- Desventaja: La red DMZ está completamente expuesta a Internet

[Image 2]

**Restricted DMZ via dialup Firewall**

- Uso de un segundo firewall de dos entradas.

- Permite tener una DMZ

- Ventajas: DMZ protegida

- Ventajas: Los firewalls siguen siendo de dos interfaces

- Desventajas: Necesitas dos firewalls

[Image 3]

**Three-legged firewall**

- Permite tener un unico firewall pero de tres entradas.

- Ventajas: Solo se necesita una IP pública

- Ventajas: La DMZ puede usar IP privadas

- Desventajas: Firewall de tres interfaces, mas complejo de configurar

[Image 4]

### 4.1.2 Reglas de Filtrado

**Qué son?**

Son el conjunto de reglas utilizadas para determinar si un paquete tiene que ser descartado o no usando como parametros:

- @IP origen y destino

- Puerto origen y destino

- Tipo de protocolo (IP, TCP, UDP, ICMP)

- Estado de la conexión (nueva, respuesta, relacionada)

**Configuración**:

- White-List
  
  - Las reglas son una lisita de condiciones permitidas y al final hay un prohibir todo.
  
  - Ventaja: Más seguro
  
  - Desventaja: Más restrictivo y menos confortable con el usuario

- Black-List
  
  - Las reglas son un lista de condiciones prohibidas y al final hay un permitir todo.
  
  - Ventaja: Más confortable para los usuarios
  
  - Ventaja: Más fácil de administrar
  
  - Desventaja: Menos seguro ya que no puede prevenir ataques desconocidos

#### 4.1.2.1 Iptables

> Las reglas se agrupan en cadenas (**chains**), cada cadena es una lista ordenada de reglas.

>  Las cadenas se agrupan en tablas (**tables**), cada tabla está asociada con un tipo diferente de procesamiento de paquetes.

[Image 5]

- **Filter**:
  
  - Denegar/permitir determinados paquetes

- **NAT**:
  
  - Modificar @IP/puertods de los paquetes

- **Mangle**:
  
  - Modificar algunos otros campos de los paquetes como:
  
  > **Tipo de Servicio**: Campo de la cabecera IP destinado a dar prioridad a los paquetes.
  > 
  > **Tiempo de vida** (TTL): Campo de la cabecera IP usado para que un paquete no pueda quedarse eternamente en una red.
  > 
  > **Mark**: Se pueden marcar determinados paquetes para que se traten luego de diferente manera.

- **Raw**
  
  - Se consulta antes de cualquier otra.

[Image 6]

> Nota: Las wildcards funcionan como las mascaras de subred
> 
> La regla por defecto es aceptar, si se quiere modificar:
> 
> - `iptables -P chain {ACCEPT|DROP}`

### 4.1.3 Filtrado a nivel de aplicación (Proxy)

**Definición**:

Un servidor proxy es un dispositivo que actúa de intermediario entre clientes que necesitan un servicio y los servidores que proporcionan este servicio.

**Razones**:

- Para mantener las máquinas anónimas

- Para acelerar el acceso a los recursos mediante el uso de caché

- Para aplicar la política de acceso a los servicios

- Para registrar / audiatar el uso

- Para escanear contenido transmitido en busca de malware antes de la entrega

- Para escanear el contenido saliente (protección de posibles fugas de datos)

- Para eludir las restricciones regionales

**Tipos de Proxy servers**:

- Caching proxy servers:
  
  - Conservan copias locales de los recursos solicitados con mas frecuencia.

- Web proxy servers:
  
  - Sirven como caché web
  
  - Normalmente tambien proporcionan algun tipo de lista negra y reformatean

- **Open Proxy**:
  
  - No tienen control de acceso
  
  - El servidor final no recibe la información sobre la dirección del usuario final

- **Close Proxy**:
  
  - Tienen control de acceso
  
  - Los usuarios autorizados deben iniciar sesión
  
  - El administrador puede monotorizar el uso y rastrear a los usuarios

- Intercepting (transparent) proxy servers:
  
  - Combinan un servidor proxy con un gateway o router
  
  - Se usan comunmente en las empresas para interceptar el trafico de sus empleados

- Reverse proxy servers:
  
  - Son servidores instalados en la vecindad de uno o más servidor web.
  
  - Todo el tráfico proveniente de Internet y con destino a estos servidores pasa por el reverse proxy
  
  - Razones apra instalar un reverse proxy:
    
    - Equilibrio de carga: las conexiones se distribuyen entre varios servidores
    
    - Seguridad: es una capa adicional de defensa y puede proteger contra algunos ataques específicos
    
    - Servicios adicionales: Compresión de datos, almacenamiento en caché...

## 4.2 Sistemas de detección de intrusos

**Definiciones**:

- Sistema de detección de intrusos (IDS):

> Herramienta especializada que sabe leer e interpetar el contenido de los archivos de registro (logs) de routers, firewalls, servidores...

- Funcionamiento de un IDS:

> Mantiene una base de datos de ataques conocidos.
> 
> Compara los patrones de actividad o tráfico que ven los logs con esta base de datos.
> 
> De esta forma, saben reconocer cuándo se produce una coincidencia cercana entre un ataque conocido y un comportamiento actual o reciente en la red.

**IDS vs antivirus**:

- Un IDS activa alarmas o toma varios tipos de acciones automáticas

- Por analogía un IDS have para una red lo que hace un antivirus para los archivos

**IDS vs Firewall**:

- ¿Puede servir un Firewall como IDS?
  
  - Se puede configurar un firewall para detectar ciertos tipos de intrusiones y activar una alerta, pero al no tener **inspección profunda de paquetes** y reconocimiento de patrones esto no es suficiente.

- Inspección profunda de paquetes (DPI)

> Es una forma de filtrado de paquetes de red que examina la parte de los datos y posibilemente también de las cabeceras de un paqute, se buscan incumplimientos de protocolo

### 4.2.1 Clasificación por funcionalidad

- Signature-based IDS
  
  - De manera similar al antivirus, los IDS basados en firmas detectan ataquets al comparar la actividad de la red con una base de datos
  
  - Si una regla coincide, se activa un alerta
  
  - Problema: Nuevos ataques no se pueden reconocer

- Anomaly-based IDS
  
  - Crean un modelo de comportamiento del sistema "normal"
  
  - Cuando se detecta una desviación del modelo se envia una alerta

### 4.2.2 Clasificación por arquitectura

**Network IDS**:

NIDS monitorea el tráfico de red a través de una interfaz de red en modo promiscuo.

> Los sensores que permiten este monitoreo pueden ser o bien:
> 
> - En Línea: El tráfico **debe** pasar por el sensor
> 
> - Pasivo: Monitorea una copia del tráfico de red real, no tiene que ser en RT

- **Funciones**:
  
  - **Recopilación de información**:
    
    - NIDS puede recopilar información de la red, su trafico y sus usuarios
  
  - **Registro:**
    
    - Creación de un log extenso usado para verificar la validez de las alertas
  
  - **Detección**:
    
    - Detección basada en firmas y detección basada en anomalías
  
  - **Prevención**:
    
    - Una vez que se activa una alerta, se pueden abortar otras conexiones similares

**Host IDS**:

HIDS monitorea las caracterisiticas, actividades y eventos que ocurren en un solo host

HIDS tiene **agentes** instalados que pueden ser por ejemplo honeypots

- **Honeypot**
  
  - Un honeypot e sun sistema trampa/señuelo que simula una vulerabilidad para que un atacantes la explote y proceda a ser detectado.

**Distributed IDS**:

DIDS es un conjunto de sensores que se distribuyen por el sistema e informan de cambios/eventos a una estación centralizada

## 4.3 Seguridad punto a punto

**Capa de aplicación**:

Los datos pueden ser encriptados antes de encapsularse, cada aplicación es libre de definir el método a usar

**Capa de transporte**:

Se puede añadir **TLS** a la conexión entre dos extremos.

TLS permite el uso de certificados para identificar los extremos

**Capa de red**:

Todos los datagramas independientemente de la aplicación y de la capa de transporte, deben encaminarse de forma segura en la red.

**Capa de enlace**:

Se puede aplicar una seguridad específica dependiente de la tecnología de nivel 2, por ejemplo autentificación antes de establecer una conexión.

**Internet Protocol Security**

Es un conjunto de protocolos cuya función es asegurar las comunicaciones sobre IP autenticando y/o cifrando cada paquete. Funciones principales:

- Asegurar el flujo de paquetes

- Garantizar la autenticación mutua

- Establecer parámetros criptogáficos

**VPN**

Una VPN es una red virtual construida sobre redes físicas

### 4.3.1 Virtual Private Network

Las VPNs pueden usar tanto cifrado simétrico como asimétrico

**Gateway-toGateway architecture**

Esta arquitecutra proporciona comunicaciones de red seguras entre dos sistemas mediante el establecimiento de una conexión VPN entre los dos routers de acceso.

**Host-to-Gateway architectue**

Este modelo se utiliza para proporcionar acceso remoto seguro desde una red externa a los servicios internos de un sistema/empresa

La conexion la establece el usuari cuando la necesita

**Host-to-Host architecture**

Generalmente se usa para necesidades especiales, como cuando un administrador de sistema necesite acceder remotamente a un solo servidor.

Este es el unico modelo que proporciona seguridad de extremo a extremo, pero esto tambien conyeva que lso firewalls/IDS no pueden hacer nada para filtrar/bloquear el trafico

# 5. Seguridad en las aplicaciones

## 5.1 Introducción

**Problemas**

- No existe un sistema 100% seugro:
  
  - Vulnerabildiades teóricas
  
  - Vulnerabilidades reales (exploits)

- Causas de una aplicación insegura:
  
  - Vulnerabilidades
  
  - Estructura organizativa
  
  - Desarrolladores
  
  - Requisitos legales
  
  - Incremento de la conectividad y complejidad

**Soluciones**

- Entender el alcance de la seguridad que requiere un proyecto

- Probar pronto y a menudo

- Pensar creativamente

- Utilizar las herramientas adecuadas

- Utilizar código fuente cuando esté disponible

- Documentar los resultados de las pruebas

- Asegurar que un programa de seguridad sea efectivo y rentable usando SDLC

[Image 7]

## 5.2 Errores más comunes (OWASP top10)

### 5.2.1 Broken Access Control

El control de acceso debe hacer cumplir la política de seguridad de modo que los usaurios no puedan actuar fuera de sus permisos previstos

**Vulnerabilidades mas comunes**

- Violación del principio de least privilege o deny by default

- Eludir las comprobaciones de control de acceso

- Permitir ver o editar la cuenta de otra persona

- Acceso a través de una API donde falta controles de acceso

- Elevación de privilegios

- Configuración incorrecta de Cross-Origin Resource Sharing (CORS)

**Prevención**

- Aplicar políticas de deny by default a todos los recursos que no son públicos

- Implementar mecanismos de control de acceso y reusarlo duarante todo el periodo de acceso a la aplicación

- Aplicar controles sobre las propiedades de cada dato, de manera que un usuario no pueda manipular datos de otros

- Aplciar rate-limit a los accesos/uso de APIs

- Deshabilitar la opción de listar el directorio del servidor web y asegurar que los metadatos y los archivos de backup no estén presentes

- Controlar los logs de fallos de acceso repetidos y hacer saltar alarmas

- En servidores stateful, los identificadores de sesiones deben invaldiarse una vez terminada la sesión

- En servidores stateless, los tokens pueden ser sujetos a vulnerabildiades
  
  - reducir la duración de lso tokens y usarlos solo en caso especifico

### 5.2.2 Cryptographic Failures

Cuando se protege de forma incorrecta información confidencial enun sistema o en un transisto entre ssitemas, como los datos financieros y/o médicos, tarjectas bancarias, secretos de negocio, etc.

**Vulnerabilidades mas comunes**

- Envío de tráfico en texto claro

- Uso de algoritmos de cifrado obsoletos o débiles, códigos antiguos o usados por defecto cuando fallan los principales

- Uso de claves por defecto, débiles, reusadas o sin modificar periódicamente

- No se ha validado correctamente el certificado o la cadena de confianza

- Uso de funciones de hash obsoletas como MD1 o Sha1

- Uso de métodos de padding obsoletos como PKCS#1 y v1.5

**Prevención**

- Clasificar los datos que procesa, almacena o transmite una aplicación según su grado de confidencialidad de acuerdo a la legislación actual

- Descartar toda aquella información confidencial que no es necesaria guardar

- Cifrar toda la información en transito usando protocolos seguros como TLS

- Usar los algoritmos, protocolos y gestores de claves estandarizados y más actualizados posibles

- Evitar mostrar paginas de error por defecto ya que estas pueden contener información confidencial sobre los sistemas

- Almacenar las contraseñas de forma segura
  
  - No guardarlas nunca en claro

- Evitar mostrar paginas de error por defecto ya que estas pueden contener información confidencial sobre los sistemas

- Hay que usar el Salt para evitar ataques pre-computados

### 5.2.3 Injection (And XSS)

Se produce cuando se pasa información no validada a un interprete como parte de un comando o consulta.

**Cross-Site Scripting (XSS)**

XSS permite a los atacantes ejecutar scripts en el navegador de la víctima que puen robar sesiones de usuario o redirigir al usuario a sitios maliciosos.

Ocurre cuando no se valida el contenido de los links

**Prevención**

- La opción preferida es usar una **API segura** ue evita el uso del intérprete por completo

- Utilizar la validación por white-list del lado del servidor

- Utilizar LIMIT y otros controles SQL sobre el número y tipos de consultas para evitar la divulgación masssiva en caso de inyección SQL

- Usar la sintaxis de escape específica para evitar el uso de caracteres especiales que validen una consulta

- Filtrar según la semántica de la aplciación

### 5.2.4 Insecure Design

Es una categoría amplia que representa diferentes debilidades, expresadas como diseño de control no presente o ineficaz.

Normalmente es causado por no haber creado perfiles de reisgo

**Prevención**

- Integrar verificaciones de plausabilidad en cada nivel de la aplicación

- Establecer y utilizar un SDLC con profesionales en Application Security para ayudar en el diseño

- Utilizar un modelo de amenazas para la autenticación crítica, el control de acceso, la lógica y el intercambio de claves

- Preparar tests de validación para cada bloque y para su integración y comprobar que son resistentes al modelo de amenazas

- Segregar y aislar los grupos de usuarios que comparten un acceso común

- Limitar el consumo de recursos por parte del usuario o servicio

### 5.2.5 Security Misconfiguration

Todo lo que concierne una configuración de seguridad débil, mal implementada o directamente faltante

**Vulnerabilidades mas comunes**

- Falta del nivel de seguridad adecuado en cualquier parte de las aplicaciones o permisos configurados incorrectamente

- Hay funciones habilitadas o instaladas que son innecesarias

- Cuentas, claves o contraseñas predeterminadas aún habilitadas

- El software está desactualizado o es vulnerable

- El servidor no envía cabeceras o directivas de seguridad, o no están configurados con valores seguros

- Las últimas funciones de seguridad en los sistemas actualizados están deshabilitadas o no configuradas de forma segura

- El gestor de errores revela a los usuarios informacion innecesaria

**XML External entities (XXE)**

Consiste en conseguir que una aplicación con un parser XML reciba o ejecute un código malicioso.

**Prevención**

- Configurar una tarea para revisar los niveles de seguridad y actualizar aplicaciones y instalar parches

- Revisar los permisos de almacenamiento en la nube 

- Mantener en producción una plataforma mínima sin atributos componentes, documentación ni ejemplos innecesarios. eliminando funciones y frameworks no utilizados

- Definir y configurar los entornos de desarrollo, control de calidad y producción de forma idéntica per con diferentes credenciales en cada entorno

- Definir un proceso automatizado para verificar la efectivadad de las configuraciones y los ajustes en todos los entornos

### 5.2.6 Vulnerable and Outdated Components

Todo lo que concierne al uso interno o externo de aplicaciones, protocolos, librerías, etc... que contienen vulnerabilidades y que no están actualizados

**Problemas mas comunes**

- Cuando no se conocen las versiones de todos los componentes que se utilizan

- Cuando el software es vulnerable, incompatible o no actualizado

- Cuando no se busca vulnerabildiades con regularidad

- Cuando no se asegura las configuraciones de los componentes

- Cuando no se prueba la compatibildiad con las librerías modificadas, actualizadas o parcheadas

- Cuando no se reparar o actualiza la plataforma de base, los framworks y las dependencias de manera oportuna

**Prevención**

- Eliminar las dependencias no utilizadas, funciones, componentes... innecesarios

- Realizar un inventario continuo de las versiones de los componentes y sus dependencias utilizando herramientas como OWASP Dependency Check

- Supervisar continuamente fuentes como la CVE o la NVD para las vulnerabildiades

- Obtener componentes de fuentes oficiales a través de enlaces seguros, usando paquetes firmados

- Monitorear las librerías y los components que no se mantienen o no crean parches de seguridad para versiones antiguas

### 5.2.7 Identification/Authentication Failures

Todo lo que concierne los problemas relacionados con el proceso de login, gestión de sesiones y credenciales

**Vulnerabilidades mas comunes**

- Usar contraseñas débiles

- Permitir contraseñas por defecto

- Permitir ataques automáticos y de fuerza bruta

- Usar métodos de recupero de contraseña poco seguros

- Autentifación simple sin control multipaso/multifactor

- Mantener la base de datos de las contraseñas con poca seguridad

- Mantenimento de las sesiones con ID únicos o expuestos

- Exponer el ID de las sesiones en el URL

**Prevención**

- Asegurar que las conexiones HTTP usen un canal seguro y cifrado

- Usar Cookie "Secure"

- Usar HTTPOnly como atributo

- Implementar un verificador de contraseñas débiles

- Implementar técnicas de autenticación multifactor para evitar

- Evitar el problema del "Session Fixation"

### 5.2.8 Software and Data Integrity Failures

Todo loque concierne los problemas de seguridad relacionados con hacer suposiciones cuando se realizan actualizaciones de software, de datos críticos y de canales de CI/CD sin verificar la integridad

**Problemas mas comunes**

- Cuando una aplicación se basa en complementos, modulos, etc... Que no son de confianza

- Cuando un canal de integración y desarrollo continuos es poco seguro y un atacantes puede obtener acceso no autorizado

- Cuando se realizan actualizaciones automáticas y esas se descargan sin una verificación de integridad suficiente

**Insecure Deserialitzation**

Se produce cuando al procesar y deserializar unos datos que ha enviado un atacantes, se consigue introducir un objecto que introduce o modifica el comportamiento de una aplicación

**Prevención**

- Utilizar firmas digitales o mecanismos similares para verificar que el software o los datos provengan de la fuente de confianza

- Asegurar que las liubrerías y dependencias usan repositorios de confianza

- Asegurar que haya un proceso de revisión de lso cambios de código y configuración para minimizar la posibilidad de que se introduzcan códigos maliciosos o que se abran brechas de seguridad

- Asegurar que el canal de CI/CD tenga segregación y control de acceso adecuados para grantizar la integridad del código

- No aceptar objectos serializados de fuentes no confiables usar verificación de integridad o firma digital para detectar alteraciones

## 5.3 Gestión de vulnerabilidades

Se necesitan procesos de inventariado de software altamente confiables y automatizables

**Common Vulnerability Score System (CVSS)**

Se trata de un sistema de puntuaje diseñado para proveer un método abierto y estándar que permite estimar el impacto derivado de vulnerabildiades

**National Vulnerability Database (NIST)**

El NIST dispone deuna base de datos con todas las vulnerabildiades que han aparecido desde 2002

**Aplicación**

Para poder usar toda esta información sobre vulnerabilidades a nuestra organización, es necesario primero tener un sistema de inventariado adecuado

**0-days**

Las vulnerabilidades 0-days son aquellas que se han descubierto sin que el fabricante del producto lo sepa

## 5.4 Auditorias

### 5.4.1 Revisión de código

- Es buena idea realizar análisis del código que escribimos

- Se puede analizar el código de manera
  
  - Estática
    
    - Permite comprobar que se siguen buenas práctcas de programación
    
    - Se le pueden escapar errores de diseño propios de lenguaje o la aplicación
  
  - Dinámica
    
    - Permite comprovar el comportamiento de la aplicación en un entorno real
    
    - Pueden aparecer errores no detectados en el análisis estático

### 5.4.2 Pruebas de intrusión

- Ventajas
  
  - Puede ser rápido y barato
  
  - Requieren un conocimiento relativamente menro que una revisión del código

- Inconvenientes
  
  - Demasiado tarde desde el punto de vista del SDLC
  
  - Pruebas sólo los impactos frontales

#### 5.4.2.1 Information gathering

A lahora de hacer una auditoría es importante obtener el máximo de información posible sobre los servidores o los servicios auditados.

No se trata sólo de informarnos, sino también de buscar "conocimientos indebidos" como pueden ser la estructura iunterna de la red, archivos que deberían estar ocultos..

Es decir **queremos encontrar información que no deberíamos encontrar**

#### 5.4.2.2 Escaneo

Una de las primeras cosas que necesitamos saber es qué servicios de la entidad que auditamos se encuentran "al descubierto"

Queremos realizar un escaneo para detectar cuáles IPs y puertos están abiertos

Una vez Descubierta toda la información posible, se pasa a analizar y descubrir las vulnerabildiades

#### 5.4.2.3 Explotación

Una vez detectadas las posibles vulnerabildiades se peuden explotar

El primer paso para explotar una vulnerabildiad es mirar si ya existe algún exploit conocido
