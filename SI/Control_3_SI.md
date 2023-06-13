# 6. Seguridad en los sistemas operativos

## 6.1 Ataques a los SO: Malware

### 6.1.1 Primeros Pasos

- **Darwin**:

> Primer programa que sin quererlo sento las bases del malware

- **Creeper**:

> Primer ejemplo de "virus" en Internet. Simplemente se replicaba sin dañar.

- **Reaper**:

> Primer anti-virus. Fue creado para moverse en Internet y eliminar Creepers.

### 6.1.2 Impacto

El principal coste que suponen los virus es económico por los siguientes motivos:

- Tiempo de inactividad debido a la infección

- Coste necesario para limpiar la infección

- Coste para tomar medidas preventivas

### 6.1.2 Tipos

- Virus

> Fragmento de código que copia su contenido enun programa más grande modificando ese programa y dependiendo de él. 
> 
> Se ejecuta cuando su programa host comienza a ejecutarse, luego se reproduce infectando otros programas.

- Gusano

> Es un programa independiente que se reproduce copiándoze de un dispositivo a otro, generalmente a través de una red.
> 
> A diferencia de un virus, un gusano mantiene su independecia.

- Troyano

> Se presenta al usuario como un programa aparentemente legítimo e inofensivo, pero que, al ejecutarlo le brinda a un atacante algún tipo de acceso remoto al equipo infectado.
> 
> Ejemplo: Ramsomware.

- Rootkit

> Código malicioso que permite un acceso de privilegio continuo a un ordenador pero que mantiene su presencia activamente oculta al control de los administradores al corromper el funcionamento normal del sistema operativo.
> 
> Se puede haber instalado a través de un troyano, a través de una vulnerabilidad o usando algún método de phishing.

- Backdoor

> Punto de entrada secreto e indocumentado dentro de un programa, utilizado para conceder accesos sin necesidad de identificación y autentificación.
> 
> Muchos desarrolladores crean backdoor a propósito para poder dar soporte técnico a los usuarios.

- Spyware

> Es un código malicioso que recopila información de un dispositivo y después transmite esta información a una entidad externa sin el conocimiento o el consentimiento del propietario del computador.

- Botnet

> Código que efectúa automáticamente tareas repetitivas a través de Internet.
> 
> Se puede usar para fines legítimos y prácticos: Rastreadores web, comparado..
> 
> Pero tambíen para fines ilegítimos: DDoS
> 
> O poco éticos: hinchar artificialmente el número de seguidores en redes.

### 6.1.3 Virus

#### 6.1.3.1 Host habituales de un virus

- Boot sectors: Para ejecutarse antes del OS.

- Ficheros ejecutables: Cualquier fichero que necesite ser ejecutado.

- Documentos con macros: Las macros son códigos ejecutables en documentos.

#### 6.1.3.2 Componentes de un Virus

- Replication

> - Un virus infecta un programa host
> 
> - Su sobrevivencia luego depende de su habilidad de replicarse y infectar otros hosts
> 
> - La infección suele ser "inteligente": No hay reinfeccion y puede haver mutaciones de un host a otro (polymorphic virus) y pueden encriptarse

- Payload

> - Parte del códifo no dedicado a la reproducción
> 
> - Se ejecuta en una fecha/hora determinada (time bomb) o bajo determiandas condiciones (logic bomb).

### 6.1.4 Gusanos

#### 6.1.4.1 Primer Gusano Problematico: Morris

Infecto unos 60000 dispositivos y creo sin querer los primeros ataques de DDoS.

**Vulnerabilidades que aprovecho:**

- Fingerd:

> Vulnerabilidad **Buffer Overflow** de la libreria gets() de c
> 
> Le permitia ejecutarse en la maquina usando una shell.

- Sendmail:

> Vulnerabilidad **Backdoor** debido a la cantidad de bugs.
> 
> Le permitia enviarse a otros dispositivos.

- Remote shell, remote execution

> Uno permite abrir una shell en un ordenador remoto usando el login del usuario.
> 
> El otro permite la ejecución de comando de este usuario remotamente.

- Passwords

> Los passwords se vulneraban ya que los usuarios usaban contrasseñas poco seguras y no se usaba salt.

#### 6.1.4.2 Wanna Cry

Aprovecho una vulnerabilidad de SMB.

## 6.2 Defensa de los SO

**Buffer Overflow**

- Address Space Layout Randomization (ASLR)

> Dispone de forma aleatoria las posiciones del espacio de direcciones de las áreas de datos de un proceso, incluyendo la base del ejecutable y las posiciones de la pila, el heap y las librerías
> 
> Hace mas dificil saltar a un espacio de la memoria para ejecutar un determinado código

- Data Execution Prevention (DEP)

> Mara áreas de memoria como ejecutables y otras como no ejecutables.
> 
> De esta forma se puede prevenir que se ejecute más código.

**Antivirus**

- La **primera generación** de antivirus usaban un método signature-based

> Se escaenan todos los ficheros en busca de determinadas "firmas"

- Necesitan que se actualizen constantemente estas firmas

**Problemas**: El virus puede haber causado daños antes de tener la actualización lista y el virus puede mutar de forma que su firma puede mutar también, haciendo casi imposible su detección por firma.

- La **segunda generacuión** de antivirus introdujo el método de escaneo heurístico

> Se escanea el comportamiento de los programas bsucando funcionamento anómalo como por ejemplo mecanismo de reproducción

- Ya no depende de firmas bien definidas y se peuden detectar nuevos virus

**Problemas**: Sigue siendo una solución a posteriori y su respuesta puede ser demasiado lenta.

- La **tercera generación** de antivirus introdujo el método de escaneo heurístico en maquinas virtuales (Sandbox)

> Los programas se ejecutan en una maquina virtual antes que en el pc real. Allí se analiza su comportamiento y se aisla el possible daño.

**Problemas**: Es computacionalmente inteso y los virus más modernos están encriptados.

**Solución:** El antivirus busca entonces patros de introducciones típicas de un algoritmo de descifrado.

**Matriz de acceso**

La matriz de acceso se usa para relacionar dominios con objectos y definir los provilegios.

Una casilla (i,j) define el conjunto de operaciones que un proceso ejecutado en el dominio i puede hacer con el objeto j.

Se pueden definir **access-rights especiales**:

- Copy - derecho de copiar la operación "op" de un objeto a otro

- Control - Un dominio puede modificar los derechos de otro dominio

- Transfer - Conmutar un dominio con otro

Se pueden definir los dominios también como objectos:

- Un dominuio puede (o no) modificarse

- Un dominio puede modificar otro

- Un dominio puede transferirse a otro

Se comprimen usando Access list y Capability list:

- Access list contiene las operacioens de un fichero por cada dominio

- Capability listy contiene las operaciones de un dominio para cada fichero

# 7. Análisis forense

## 7.1 Los primeros CERT

A raiz de los primeros ataques se fueron creando por todo el mundo CERT's.

CERT: Computer Emergency Response Team

## 7.2 Aspectos legales

- Se suele realizar un alálisis forense para:
  
  - Determinar activiades que se presumen delictivas o ilegítimas
  
  - Obtener pruebas simplemente a título informativo para conocimiento exclusivo del cliente

- Es importante conocer la legislación para evitar el rechazo de pruebas en un juicio por haber infingido la ley
  
  - Una prueba es el instrumento que tienen las partes para acreditar los hechos en los que se basan sus pretensiones.
  
  - El momento de presentación de las mismas depende de la jurisdicción.

## 7.3 Forensic Readiness

**Motivación**

- Investigación forense de una evidencia digital
  
  - Respuesta a un incidente de seguridad o crimen relacionado con ordenadores

- Sería interesante tener la capacidad de:
  
  - Leer/analizar datos constatemente para determinar si hay un ataque...
  
  - Saber preservar las evidencias digitales antes, durante y despues de la ocurrencia del incidente

**Definición**

- El uso de las evidencias digitales como defensa requiere:
  
  - Monitorización de sistemas y usuarios
  
  - Medios para asegurar los datos con estándares de admisibilidad

**Inicio de un proceso**

- Procedimientos civiles, mercantiles o laborales
  
  - Demanda

- Procedimientos penales
  
  - Denuncia:
    
    - No tenemos porque ser víctimas
    
    - Se realiza de forma oral o escrita, ante la policía o el juzgado
  
  - Querella:
    
    - Siempre somos la parte perjudicada
    
    - Se denuncia a una persona concreta
    
    - Se realiza por escrito en un juzgado
    
    - Se deben aportar pruebas que demuestren el hecho denunciado
    
    - Se necesita un abogado y un procurador

**Buenas prácticas**

- Documentación exhaustiva
  
  - Preservación de las evidencias

- Formación continua
  
  - Realización de cursos sobre análisis forense
  
  - Estudio de nuevas técnicas y herramientas
  
  - Recursos web y revistas téncincas y herramientas
  
  - Europeanb Network of Forensic Science Institutes

- Conducta profesional
  
  - Integridad
  
  - Confidencialidad
  
  - Ética
  
  - Moral

### 7.4 Metodología: 6 fases

1. **Identificación** del escenario
   
   - Evaluación del caso

2. **Preservación**
   
   - Documentación y búsqueda de las evidencias: La metodología de recolección y preservación de las evidencias implica documentar exhaustivamente.

3. **Asquisición** o recuperación de datos
   
   - "Una evidencia sim metodología no es una prueba"
   1. Localizar la evidencia
   
   2. Asegurar el escenario
   
   3. Descubrir datos relevantes
   
   4. Preparar el orden de volatilidad
      
      - Ordenar la información según su disponibildiad en el tiempo
   
   5. Recoger la evidencia
      
      - Recuperación de información borrada u oculta
      
      - Duplicado de la evidencia
   
   6. Preparar la cadena de custodia

4. **Examinación**
   
   - Agregación y obtención de información relevante, ficheros eliminados...
   
   - Filtrar la información:
     
     - Palabras clave
     
     - Información temporal
   
   - Obtener los datos relevantes:
     
     - De la información obtenida, sacar la parte importante para la investigación
     
     - Por ejemplo, extrar el buzón de un usuario de una base de datos

5. **Análisis** en un entorno de laboratorio
   
   - Análisis en un entorno de laboratorio:
     
     - Se utiliza una copia de la evidencia
     
     - Utilización de herramientas forenses
   
   - Analizar el conocimiento extraído de los datos ya procesados
     
     - Respetando la legalidad
     
     - Investigando únicamente aquello por lo que estamos autorizados

6. **Presentación**
   
   - Elaboración de un informe y presentación del mismo
   
   - Expresar en un documento los hechos:
     
     - Contrastados
     
     - Relacionados con la investigación
   
   - No incluir datos subjetivos
     
     - Si se expresa una hipótesis, comentarla claramente
   
   - El informe debe incluir el trabajo realizado y los resultados obtenidos
     
     - Se incluirá el qué, cuándo, cómo y dónde
     
     - No se incluyó el porqué
     
     - Los hallazgos deben ser reproducibles

## 7.5 Adquisición de evidencias

**Tareas de un investigador**:

- Identificar el crimen

- Obtener la evidencia del mismo

- Mantener la cadena de custodia de esta
  
  - Cada evidencia precisa de un documento de cadena de custodia:
    
    - Evidencia inequívocamente identificada
    
    - Información sobre quién custodia la evidencia
    
    - Información sobre cada cambio de custodia
  
  - El documento de cadena de custodia debe estar siempre en el mismo lugar que la evidencia
  
  - Este documento asegura la integridad de la evidencia como prueba ante procesos judiciales

- Realizar un análisis forense de la misma

- Presentar la evidencia
  
  - Se preserva de forma inversa al orden de volatilidad
  
  - Documentar el hardware/software utilizados
  
  - Abrir el ordenador para tener acceso físico a los discos
  
  - Identificar los dispositivos de almacenamiento que es necesario adquirir
  
  - Documentar los dispositivos de almacenamiento internos y la configuración hardware del equipo.
  
  - Comprobar si está encriptado antes de apagar el equipo
  
  - Desconectar para prevenir la destrucción o alteración de los datos
  
  - Realizar la adquisición utilizando el equipo del examinador
  
  - Es aconsejable el uso de dispositivos de protección de escritura para evitar modificar el disco original
  
  - El disco destino debe estar "limpio" en términos forenses
  
  - Es recomendable grantizar la integridad de la evidencia original antes de adquirirla
  
  - Adquirir la evidencia utilizando software o hardware testeado y verificar la adquisición
  
  - Cifrar las imágenes forenses para garantizar la confidencialdiad y establecer la cadena de custodia correcta para la imagen
  
  - Investigar siempre sobre las copias
    
    - Es una copia "bit a bit" de un disco completo o de una partición del mismo
    
    - No se copian ficheros, se copian bloques del disco

- Testificar

**Offline vs Live**

- Adquisición de tipo "offline"
  
  - Evita cambios debido al uso normal del equipo
  
  - Utilizar un dispositivo hardware / software para bloquear las escrituras antes de crear la imagen

- Adquisición de tipo "Live"
  
  - Cuando no se puede apagar el equipo, por ejemplo:
    
    - El equipo utiliza encriptación de disco y no se tiene acceso a las claves
    
    - Se debe mantener el servicio por motivos de negocio
    
    - No se quiere apagar el equipo para no modificar el comportamiento de un proceso malicioso
    
    - No se quieren perder datos volatiles

**Requisitos de las herramientas**

- Algunas de las características que debería cumplir una herramienta o entorno forense son:
  
  - Preserrvación de evidencias
  
  - Reducción y selección de datos rápida
  
  - Reconstrucción de volúmenes y sistemas de archivos
  
  - Análisis multimedia
  
  - Análisis de artefactos Linux/Windows
  
  - Análisis de memoria
  
  - Análisis de documentos

### 7.5.1 Artefactos Windows

**Directorio del sistema**

Habitualmente el dico del sistema suele tener asignada la letra c: variable %HOMEDRIVE%

**Directorio del perfil del usuario**

Variable %USERPROFILE%

**User shell Folders**

Directorios especiales para cada usuario:

- Escritorio

- Documentos

- Local AppData

**Directorios interesantes**

- Archivos recientes (Recent)

- Directorio temporal (Temp)

- Directorios utilizados por los browsers

- Papelera

**Accesos directos (LNK)**

- File Shortcuts o Shell Links

- Permiten conocer los detalles del archivo orginal

**Ficheros Prefetch**

- El sistema de monitorización de la cache de Windows escribe a disco ciertas características de las aplicaciones ejecutadas

**Cola de impresión**

- Las tareas de impresión se guardan en el directorio PRINTERS

- Dos archivos temporales para cada tarea: Shadow, Spool

- Modos de impresión: RAW, EMF

- SPLViewer

**Volume Shadow Copy (VSC)**

- Se realizan copias de tipo instantánea

- Se pueden analizar

**Registro de eventos**

Los registros de eventos son archivos locales en los que se registran los diferentes eventos que se producen en el sistema operativo

- EventLog: Formato .evt binario

- Windows EventLog: Formato .evtx binario/XML

**Registro de Windows**

Se trata de una base de datos enla que las aplicaciones y componentes del sistema almacenan y recuperan datos de configuración.

**Fichero SAM**

SAM es una base de datos con los hash de las contraseñas y los usuarios

No se puede acceder al fichero SAM en un sistema en caliente es necesario hacerlo offline

**NTFS ADS**

NTFS permite almacenar información adicional para cada fichero

### 7.5.2 Artefactos Linux

- /etc

- /var/log

- /home/$USER

....

Si has llegado ha este punto de la carrera mas te vale saber de p a pa esto xD
