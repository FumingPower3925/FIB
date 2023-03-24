# 1. Introducción

## 1.1 La Ciberseguridad

**¿Qué es la ciberseguridad?**

La ciberseguridad son todo el conjunto de acciones y decisiones qeu puedes tomar para proteger los **activos de una organización** y a los **usuarios del ciberentorno**.

## 1.2 Objetivos

1. **Los Datos:**
   
   - **Confidencialidad**: Solo pueden acceder a los datos los que tienen los privilegios necesarios
   
   - **Integridad**: Hay que asegurar que solo los que tienen estos privilegios puedan alterar, eliminar o añadir datos.
   
   - **Disponibilidad**: Los datos deben ser accesibles y disponibles a los usuarios.

2. **Los recursos:**
   
   - **Daños** o **desconfiguración** de los recursos corporativos.
   
   - **Autenticación**: solo los autorizados pueden acceder a los recursos y datos.

3. **La reputación**

## 1.3 Amenazas

- Suplantación de identidad

- Servidores (realizar acciones ilícitas)

- Finanzas (Información, venta)

- Extorsión o chantaje

- Nombres de usuario y contraseña

- Recolección de direcciones de correo electrónico

- Bienes virtuales (venta)

- Botnet

- ...

## 1.4 Los pilares de la seguridad

### 1.4.1 Primer Pilar: Organización

Existen normativas como la GDPR, la CSA... Que definen conceptos útiles para gestionar la ciberseguridad.

**Políticas de seguridad**

- Aprovadas y promovidas por la dirección (normalmente por el CISO)

- Valoración del riesgo

$$
Riesgo=Probabilidad\ ·\ Impacto
$$

- Disponer de protocolos:
  
  - Protocolos de prevención
  
  - Protocolos de actuación
  
  - Protocolos de recuperación

### 1.4.2 Segundo Pilar: Personas

- A menudo el eslabón más débil, así que se debe fortalecer

### 1.4.3 Tercer Pilar: Tecnologias de la información

- El entorno de trabajo debe proporcionar unas condiciones adecuadasa de seguridad

- A menudo la seguridad va en contra de la usabilidad

# 2. Criptografía

## 2.1 Motivación

**¿Qué puede proteger la criptografía?**

- Directamente
  
  - **Confidencialidad:** solo origen y destino deben poder entender el mensaje.
  
  - **Autentificación:** origen y destino seben poder confirmar la identidad del otro.
  
  - **Integridad** del mensaje: origen y destino quieren poder asegurar que el mensaje se recibe sin alterar y que naide más lo haya podido recibir.

- Indirectamente
  
  - **Acceso y disponibilidad:** los servicios y las aplicaciones deben ser accesibles y disponibles para los usuarios.

## 2.2 Definición de criptografia

- Significado literal: "Escritura oculta"

> Se ocupa de las técnicas de cifrado o codificado destinadas a alterar la representación língüística de un mensaje con el fin de ahcerlo ininteligible a receptores no autorizados.

## 2.3 Criptosistemas históricos

**Transposición**

- Consiste en rotar los caracteres del mensaje cada "k" paquetes una posicion.

$$
M=CRYPTOGRAPHY\\
E_3(M)=YCROPTAGRYPH
$$

**Substitución**:

- Substituir una letra por la letra "k" posiciones a la derecha en el abecedario

$$
M=CRYPTOGRAPHY\\
E_3(M)=FUBSWRJUDSKB
$$

## 2.4 Tipos y características

**Shannon best practices**

- Idea de **"confusión y difusión"** definida por Shannon como **condición necesaria** para un **cifrado seguro y práctico**.

> **Confusión:**
> 
> 1. Hacer que la **relación entre clave y mensaje cifrado** sea la más **compleja** posible.
> 
> 2. Hacer realmente **difícil encontrar la clave** aunque se tuviera a disposición un gran número de mensajes no cifrados y mensajes cifrados con una misma clave.
> 
> 3. **Si cambiara un solo bit de la clave el mensaje cifrado debería cambiar completamente**.

> **Difusión:**
> 
> 1. Hacer que el mensaje cifrado dependa del no cifrado de una manera muy compleja (esconder relación entre estos).
> 
> 2. Es decir, si se cambiara aunque solo un bit del bloque no cifrado, el bloque cifrado debería cambiar completamente.

**Criptografía Pubilica vs Privada**

| Criptografía Publica                  | Criptografía Privada                         |
|:-------------------------------------:|:--------------------------------------------:|
| Simétrica                             | Asimétrica                                   |
| Dos claves, una pública y una privada | Origen y destino usan la misma clave secreta |
| Mucho mas seguro pero mas lento       | Menos seguro pero mucho mas rapido           |

### 2.4.1 Criptografía Privada

- Actualmente se usan métodos basados en cifrado de **bloques** y cifrado de **flujo**

- **Requiere intercambio de la clave entre dos extremos a través de un sistema seguro** (Hoy en dia existen sistemas de intercambio sobre sistema **no** seguro)

#### 2.4.1.1 Cifrado en Bloques

Se define un grupo de bits, llamado bloque, que tiene una transformación invariante que solo depende de la clave.

**Estándares más conocidos**

- One Time Pad (OTP)

> Clave secreta aleatoria de la misma longitud que el bloque.
> 
> Imposible de descifrar sin conocer la clave.

- Data Encryption Standard (DES)

> Los bloques son de 64 bits.
> 
> La clave es de 56 bits (+8 de paridad)
> 
> El descifrado usa el mismo algoritmo a la inversa (simplifica implementación)

[Imagen 1]

> Consiste en 16 rondas idénticas:
> 
> 1. Se divide el bloque en dos semibloques de 32 bits (S1, S2).
> 
> 2. S1 se duplica (S1.1, S1.2)
> 
> 3. A S1.1 se aplica la función **Feistel** con una subclave y el resultado se combina (XOR) con S2.
> 
> 4. S1.2 va directamente a la siguiente ronda.
> 
> 5. En la siguiente ronda se intercambian los procesos entre S1 y S2 y se usa otra subclave.

[Imagen 2]

> La función **Feistel** consisten de 4 etapas
> 
> 1. **Expansión:** el semibloque de 32 bits se expande a 48 duplicando algunos bits
> 
> 2. **Mezcla:** operación COR con una subclave de 48 bits.
> 
> 3. **Sustitución:** se dividen los 48 bits en 8 sub-bloques (8 S-cajas) de 6 bits. A cada sub-bloque , se aplica una transformación no lineal especificada por una tabla de búsqueda que transforma los 6 bits iniciales en 4 bits de salida.
> 
> 4. **Permutación:** los 32 bits de salida de las 8 S-cajas se reordenan según una permutación fija.
> 
> La **etapa 3 y 4** son las que proporcionan "**confusión y difusión**"

> **Problema(s)**:
> 
> - Rompible en pocos minutos hoy en dia con fuerza bruta.

- 3DES

> Simplemente DES aplicado 3 veces con distintas claves.

> **Problema(s):**
> 
> - Extremadamente lento (AES puede llegar a ser 6 veces mas rápido)

- Advanced Encryption Standard (AES)

> Relativamente fácil de implementar y usa poca memoria.
> 
> Bloques de 128 bits.
> 
> Claves de 128, 192 o 256 bits.

> Algoritmo:
> 
> 1. Se organizan los 128 bits en una matriz 4x4 bytes.
> 
> 2. Cada byte se combina siguiendo una operación.
> 
> 3. Se hacen 10, 12 o 14 rondas (128, 192 y 256 bits respectivamente):
>    
>    1. **SubBytes**: En cada ronda se hace una substitución de cada byte por otro según una tabla conocida S.
>    
>    [Imagen 3]
>    
>    2. **ShiftRows:** Las últimas tres líneas de bytes de la matriz se desplazan un cierto número de posiciones.
>    
>    [Imagen 4]
>    
>    3. **MixColumns:** Se combinan los 4 bytes de cada columna usando transformación lineal conocida c(x).
>    
>    [Imagen 5]
>    
>    4. **AddRoundKey:** Se combina cada byte de la matriz con la clave modificada según la ronda.
>    
>    [Imagen 6]
> 
> 4. Se hace una última etapa donde se aplican una última vez los pasos:
>    
>    - SubBytes
>    
>    - ShiftRows
>    
>    - AddRoundKey

#### 2.4.1.2 Cifrado de flujo

Técnicas de cifrado que realizan el **cifrado incrementalmente**, convirtiendo el mensaje en claro en mensaje cifrado bit a bit.

**Estándares mas conocidos**

- RC4 (Usado en WEP)

- GSM (3G)
  
  - A5/1
  
  - A5/2
    
    - Intencionalemente débil, hackeado al cabo de un mes de su publicación.
    
    - Prohibida la implementación en móviles desde 7/2007

- Snow 3G (Usado en 4G)

- Snow V (Usado en 5G)

**Problemas**

- Distribución de la clave
  
  - Los usuarios deben intercamviarse la clav antes de empezar la comunicación.
  
  - Hay que usar un método seguro para conseguirlo.

- Gestión de la clave
  
  - Si hay n usuarios. cada pàreja deben intercambiarse una clave, con lo que se van a necesitar n·(n-1)/2 claves.

- Firma digital
  
  - No es posible tener una firma propia digital ya que cada clave es compartida entre dos usuarios.

### 2.4.2 Criptografía pública

- Cada extremos posee dos claves, una publica y una privada.
  
  - Las claves publicas deben estar disponibles para todos
  
  - Las claves privadas las matienen secretas los usuarios
  
  - Las dos claves se generan a través de un algoritmo de generación de claves

- Los algortimos de cifrado y descifrado son públicos

- De esta forma **no se necesita** el intercambio de claves para encriptar y desencriptar los mensajes

**Funcionamiento**

1. Origen encuentra la clave publica de destino y encripta el mensaje con esa clave

2. Destino recibe el mensaje encriptado con su clave publica de origen y lo desencripta usando su clave privada.

> Nota: Hoy en dia el cifrado asimétrico se usa unicamente para enviar la clave del cifrado simétrico, ya que éste segundo es mucho mas rápido.

**Ejemplos**

PGP, GnuPG, TLS y SSH

## 2.5 Firma digital

- Una firma digital sirve para poder verificar quien ha firmado un documento.

- Se usa criptografia asimetrica de forma inversa, la firma se realiza con clave privada y el resto de gente puede verificarlo con la clave publico.

## 2.6 Algunos principios matemáticos

- Se necesita una **trapdoor function**

> Una operación matemática que sea muy fácil de calcular pero que la inversa sea inviable.

**Tipos de trapdoor function**

- Logarítmica/exponenciación discreta

- Curvas elípticas

### 2.6.1 Logarítmica/exponenciación discreta

- Se define un **grupo cíclico finito** G, de **orden n**

- Se conoce como logaritmo discreto de y en base g (con y,g pertenecientes a G):

$$
g^x=y 
$$

> Se conoce la solucion para x

- La operacion inversa (**logaritmo discreto**) es irresoluble en un tiempo razonable y no da un resultado único. (Complejidad exponencial)

### 2.6.2 Curvas elípticas

- La idea es usar una curva elíptica de la forma:

$$
y^2=x^3+ax+b
$$

[Imagen 7]

- Crear un grupo finito x,y que satisfagan esta curva

- Y un grupo de operaciones que tengan las mismas características de logaritmo/exponente discreto

- Juntos crean lo que se llama un grupo abeliano

**Propiedades y operaciones de las curvas**

- Una de las propiedades es que cualquier línea no vertical, intercepta la curva en tres puntos diferentes.

- Otra es que es simétrica.

- Operacion dot:

[Imagen 8]

[Imagen 9]

- A partir de un punto público A y repitioendo esta operación dot, se llega a un punto final F, y sabiendo estos dos puntos es muy dificil saber cuantos dot se han hecho.

- La cable publica sera A, F sera el mensaje y $S_k$ sera la calve privada.

- En la realidad solo se usan valores enteros y se tiene un numero primo como maximo.

> ###### Problema:
> 
> Pese a ofrecer mas seguridad frente a los ordenadores classicos ofrece mucha menos en frente a los ordenadores cuanticos.

## 2.7 Algoritmos más conocidos

- Diffie-Hellman
  
  - Exponenciación binaria

- RSA
  
  - Números coprimos
  
  - Multiplicador modular inverso

- ElGamal

- RSA para Firma Digital

- Función Hash

### 2.7.1 Diffie-Hellman

- Usado para:
  
  - Generación de clave privada en la criptografia simétrica (Compartir clave privada)
  
  - Parte del mecanismo de cifrado asimétrico de algunos algoritmos

- Ejemplo:

[Imagen 10]

**Ataques:**

> Ataque passivo:
> 
> - Obtener a o b a partir de los otros valores calculando el logaritmo discreto y provando todas las soluciones.
> 
> - Problema intratable siempre que:
>   
>   - n sea un numero primo > 200 dígitos
>   
>   - Que no cumplan ciertas características debilitantes

> Ataque activo:
> 
> - No proporciona autentificación, se supone que los dos extremos han pasado anteriormente por una etapa de certificación.
> 
> - Si no se usa, es posible hacer un ataque de tipo MitM

**Exponenciación binaria**

- Se usa para computar números exponenciales sin tratar números excesivamente grandes

[Imagen 11]

### 2.7.2 RSA

- Primer y más utilizado algoritmo de este tipo y es válido tanto para cifrar como para firmar digitalmente

- El funcionamento se basa en el producto de números primos grandes elegidos al azar y mantenidos en secreto.

- Funcionamiento:

> 1. Se eligen dos números primos muy grandes p y q
> 
> 2. Se computa $n = p\ · q$, donde n será la base del modulo
> 
> 3. Se computa la función de Euler: $\phi (n)=(p-1)·(q-1)$
> 
> 4. Se elige un entero e menor y comprimo de $\phi(n)$
> 
> 5. Se determina d como el multiplicador modular inverso de $e\mod \phi(n)$
> 
> 6. La clave publica es $(n,e)$
> 
> 7. La clave privada es $(n,d)$
>    
>    - p, q y $\phi(n)$ también deben mantenerse privados

- Cifrado/descifrado

> 1. A tiene clave publica $(n,e)$ y privada $(n,d)$
> 
> 2. B quiere enviar un mensaje m a A
> 
> 3. B usa la clave publica de A y crea un mensaje encriptado $c=m^e\mod n$
> 
> 4. A desencripta el mensaje usando su clave privada $m=c^d\mod n$

**Ataques:**

> - Mensajes m=0, m=1 o m=n-1 siempre producen cifrados iguales
> 
> - Si se usan exponentes pequeños el resultado del cifrado puede ser menor que n, de manera que no hay componente cíclica
> 
> - Si se sabe que los mensajes son de texto se puede lanzar un ataque con un diccionario.

**Solución:**

> - Se usan esquemas de padding como RSA-OAEP+
> 
> - Estos esquemas modifican el texto añadiendo "relleno" para que no se cumplan las condiciones anteriores.

- Otro possible ataque seria factorizar n en p y q, pero se trata de un problema inviable para claves suficientemente robustas.

### 2.7.3 ElGamal

- Se basa en Diffie-Hellman

- Libre de uso

**Generación de claves**

1. Se elige un grupo cíclico finito G de orden n

2. Un elemento $\alpha$ de este grupo 

3. Un Usuario A
   
   1. Elige un número aleatorio a
   
   2. Calcula $\alpha ^a \in G $
   
   3. $\alpha, G, \alpha ^a \in G$ son todos valors públicos
- Clave pública ($\alpha, G, \alpha ^a \in G$)

- Clave privada ($\alpha, G, a$)

**Encriptación**

- B quiere enviar un mensaje $m\in G$ a A, entonces debe:
1. Recibir la clave publica de A

2. Elegir un número aleatorio b y calcular $\alpha ^b \in G$

> Se recomienda que b sea de un único uso

3. Calcular el mensaje cifrado $c=m·(\alpha ^a)^b\in G$

4. Enviar a A el mensaje $(\alpha ^b, c)$

**Desencriptación**

- A recibe el mensaje cifrado
1. Calcula $x=(\alpha ^b)^a \in G$

2. Calcula el mensaje en claro $m=c·x^{-1}\in G$

**Ataques:**

> Igual que RSA, Elgamal sufre de los mismos problemas con determinados mensajes (necesita padding).

### 2.7.4 Firma Digital

- Si U quiere firmar un mensaje M, simplemente aplica el algoritmo E con su clave privada de forma que el mensaje firmado es $S=E_{SKu}(M)$

- Para verificar que el que ha firmado es realmente U, cualquier usuario puede aplicar el algoritmo de desencriptación usando la clave publica de U sobre el mensaje cifrado y comparar el resultado con el mensaje no cifrado, es decir verificar que $D_{PKu}(S)=M$

- Lo que se cifra es el Hash del documento, no todo el documento.

**Funcionamiento en Firmante**

- A tiene la clave publica $PK_a=(n,e)$ y privada $SK_a=(n,d)$

- A calcula la función Hash H(m) del documento m

- A cifra el hash usando la clave privada $s=(H(m))^d\mod n$

- A envía el documento original m con la firma s añadida

**Verificación de la firma**

- B coge el documento firmado m + s

- B separa m de s

- B calcula la función Hash del documento m

- B descifra la firma con la clave pública de A y encuentra el hash

- B verifica que el hash que ha creado el es el mismo que el encriptado

**Datos**

- RSA no es el único algoritmo de cifrado usado en firma digital

> Digital Signature Algorithm (DSA), variante de ElGamal
> 
> Elliptic Curve Digital Signature Algorithm (ECDSA)
> 
> Edwards-curve Digital Signature Algorithm (EdDSA)

- Una firma digital no solo permite autenticar una firma:

- **Integirdad**:

> Garantiza la integridad del documento firmado
> 
> Si se modifica el documento después de la firma, el proceso verificaría que no es el mismo documento

- **No repudio:**

> El firmante no puede repudiar el documento firmado
> 
> Alguien que ha firmado un documento no puede a posteriori negar que lo haya firmado

### 2.7.5 Función Hash

Una función hash es una **función computable mediante un algoritmo** que tiene como entrada **un conjunto de elementos** y proporciona una **string de salida de longitud fija**

- Una función hash criptográfica debe tener una características particulares:
  
  - Debe ser determinista, es decir una misma entrada debe dar siempre el mismo hash
  
  - El hash debe ser fácil de computar
  
  - Debe ser inviable generar un mensaje que produzca un valor hash determinado
  
  - Debe ser inviable generar colisiones
  
  - Un pequeño cambio en un mensaje debe cambiar drasticamente el hash.

**Ataques:**

> La vulnerabilidad más común es que haya la posibilidad de encontrar una colisión en tiempos razonables.
> 
> La otra posibilidad es calcular el inverso

**En criptografía: algoritmos más comunes**:

- Message Digest Algorithm 5 (MD5)

> Tamaño: Hash de 128 bits
> 
> Vulnerabilidades: Se encuentra colisión en segundos
> 
> Uso: Principalmente como checksum

- Secure Hashing Algorithm (SHA-1, SHA-2 y SHA-3)
  
  - SHA-1
    
    - Tamaño: Hash de 160 bits
    
    - Vulnerabilidades: Colisiones
    
    - Uso: Se recomendó no usar a partir de 2010
  
  - SHA-2
    
    - Tamaño: 6 longitudes (224, 256, 384, 512, 512/224, 512/256)
    
    - Vulnerabilidad: Aunque tiene alguna, la complejidad sigue siendo inviable
    
    - Uso: En protocolos TLS, SSL, SSH, IPSec y bitcoin (entre otros)
  
  - SHA-3
    
    - Tamaño: Arbitrario, los mas comunes son los usados en SHA-2
    
    - Vulnerabilidades: Aún ninguna
    
    - Uso: Hoy en dia se siguen usando SHA-3 y 2

- RACE Integrity Primitives Evaluation Message Digest (RIPEMD)
  
  - Tamaño: 4 longitudes (128, 160, 256, 320)
  
  - Vulerabilidades: Ninguna, es considerado robusto
  
  - Uso: Poco, ya que es mas lento que SHA y salió mas tarde

- BLAKE2
  
  - Tamaño: 4 longitudes (224, 256, 384, 512)
  
  - Vulnerabilidades: Ninguna, mas rapido y tan seguro como SHA-3
  
  - Existe una nuva version BLAKE3 que incluye algunas mejoras

# 3. Infraestructura PKI

## 3.1 Conceptos Básicos

La criptografía publica permite el intercambio de mensajes **secretos** y **auténticos**, pero **no nos assegura** estarlos enviando con la clave correcta.

**Primera Propuesta** (Diffie-Hellman)

Uso de un único repositorio seguro que almacene todas las claves públicas

> **Problemas**
> 
> - Cuello de botella
> 
> - Requisitos de seguridad extremos
> 
> - Necesidad de backup que requiere la transmisión de nuevos datos constantemente

**Segunda Propuesta** (Kohnfelder)

Creación de un **conjunto de registros** de datos firmados (**certificados**) que permitan un **sistema de distribución** de claves publicas **de confianza**.

> **Que es un certificado digital, que contiene y quien lo certifica?**
> 
> Un certificado digital es una estructura de datos que contiene:
> 
> - La identidad del propietario
> 
> - La clave publica de éste
> 
> - La firma digital de una entidad de confianza que certifica que la clave pública es de este propietario que luego tendrá en su poder la clave privada correspondiente
> 
> La certificación que la identidad del propietario y la clave publica es correcta recae en una autoridad de confianza.

## 3.2 Componentes de una PKI

**Public Key Infrastructure (PKI)**: Es el conjunto de computadoras, software, individuos, políticas y procedimientos necesarios para crear y administrar los certificados digitales basados en criptografía de clave pública.

[Imagen 12]

**Certification Authority (CA)**

- Son las Trusted Third Party (TTP)

- Emiten los certificados digitales

- Opcionalmente pueden generar las claves públicas/privadas

- Deben mantener sus propias claves públicas/privadas muy protegidas

**Registration Authority (RA)**

- Una RA se encarga de verificar la relación entre la clave publica y la identidad del propietario

- Se trata de un componente opcional en un PKI, puede encargarse el propio CA

**Validation Authority (VA)**

- Una VA se encarga de verificar la validez de los certificados digitales

- Puede ser el propio CA o una entidad externa

- Proporciona información en tiempo real sobre el estado de un certificado

- Se usan protocolos como OCSP y SCVP para conocer el estado actual

**Time Stamping Authority (TSA)**

- Una TSA se encarga de firmar un mensaje para marcar en que momento se generó

- Son muy relevantes cuando:
  
  - Se verifica un documento firmado digitalmente
  
  - Fecha límite de entrega de documentos
  
  - Auditorias

**Repositorios**

- Son estructuras de datos para almacenar toda la información sobre una PKI

- Los dos repositorios mas importantes son:
  
  - El repositorio de certificados
  
  - El repositorio de la lista de certificaciones en revocación

- Las "directories" son las estructuras de repositorio más comunes utilizadas en PKIs

## 3.3 Modelos de confianza

**Modelo Distribuido**

- Modelo más simple

- funciona en una comunidad de **pocos usuarios**

- Un usuario **crea y firma** certificados para otros usuarios

- Los usuarios tienen confianza entre ellos

- NO necestian TTP

- Pretty Good Privacy (PGP) usa este modelo

[Imagen 13]

**Modelo Plano**

- El modelo simple solo tiene una CA que actúa como TTP

- Los usuarios validan la identidad de los suscriptores utilizando el certificado de CA

- El certificado de CA está autofirmado

[Imagen 14]

**Modelo Jerárquico**

- Los certificados de los usuarios se firman mediante un TTP

- Este TTP está identificado por medio de otro certificado emitido por otra CA con un nivel jerárquico superior

- Y así sucesivamente hasta el CA raíz

- El CA raíz tiene un certificado autofirmado

- Para validar un certificado, se sigue el árbol desde abajo hasta el CA raíz

[Imagen 15]

**Modelos Híbridos**

> **Modelo de lista de confianza jerárquica**
> 
> - Es el modelo mas común
> 
> - A.k.a. modelo de centro de usuario
> 
> - Cada aplicación tiene una lista de CA de confianza
> 
> - Muy flexible
> 
> - No hay diferencia entre PKI buenas y no tan buenas

[Imagen 16]

> **Modelo de certificación cruzada jerárquica**
> 
> - Las CA raíz emiten certificados entre ellos
> 
> - Estos certificados certifican una CA utilizando la firma de otra CA
> 
> - Las CA raíz son locales, no globales
> 
> - La verificación del certificado puede requerir una búsqueda costosa
> 
> - Como en el modelo jerárquico un usuario confía en una sola CA
> 
> **Problema:** El número de certificados cruzados crece enormemente con el número de CA

[Imagen 17]

> **Modelo de certificación de puente**
> 
> - Reduce la cantidad de certificados necesarios (++escalabilidad)
> 
> - Un CA puente es una entidad externa que actúa de puente entre dos PKI
> 
> - Uso de certificados cruzados

[Imagen 18]

## 3.4 Certificados X.509

- Define un marco de autenticación

- También se le conoce como **PKIX**

- Proporciona un estándar para la certificación de clave pública

- Aspectos principales del formato:
  
  - Modelo jerárquico (cruzado y puente)
  
  - Incluye aspectos de la PKI, formato de los certificados y de los CRLs

- Una CA emite un certificado asociado a una clave pública a un **Nombre Distinguido**

- Un DN es un conjunto de atributos con un cierto valor (Permite a las organizaciones elegir cuales son los atributos más adecuados para identificar una entidad)

- También permite elegir un Nombre Alternativo, como un correo electronico, DNS...

**CRL**

- Una CRL es una estructura de datos firmada por una CA

- Contiene los datos esenciales para determinar el estado del certificado

## 3.5 Public-Key Cryptography Standards (PKCS)

- Hay 15 (PKCS#1, PKCS#2 .... PKCS#15) aunque actualmente se usan 10

**PKCS#7**

- Define la sintaxis de los mensajes cifrados y/o firmados
  
  - Permite que un usuario firme un mensaje ya firmado

- Hoy en día se utiliza para
  
  - Firmar y/o cifrar mensajes bajo una PKI
  
  - La difusión de certificados
  
  - El inicio de sesión única

- Elementos:
  
  - **Data**: Información sin firmar
  
  - **SignedData**: Información firmada digitalmente
  
  - **EnvelopedData**: Información para un grupo de destinos
    
    - Se crea un sobre digital **para cada destino**
    
    - Se genera una clave privada y se cifra la información (cifrado simétrico)
    
    - Se cifra la clave privada con la clave pública de cada destino
  
  - **SignedAndEnvelopedData**: Información doblemente cifrada
    
    - Se firma la información con la clave privada (cifrado asimétrico)
    
    - Se genera una clave privada y se cifra la información (cifrado simétrico)
    
    - Se cifra la clave privada con la clave pública de cada destino
    
    - El destino con la clave privada del cifrado simétrico podrá descifrar la información
    
    - Y con la clave pública del origen verificar quien ha firmado
  
  - **EncryptedData**: Información cifrada para ningún destinatario concreto
  
  - **DigestedData**: Se calcula un resumen de la información (normalmente hash)
    
    - Se junta la información y su resumen
    
    - Esta unión se puede luego usar como input de otros tipos

**PKCS#10**

- Define el formato de una solicitud de certificado

- DN del usuario

- Información sobre la clave publica

- Información adicional sobre el usuario

**PKCS#12**

- Describe el formato para la transferencia de inforamción personal, que puede incluir claves privadas, certificados, etc.

- Tiene cuatro modos diferentes dependiendo de si el usuario quiere privacidad o integridad:
  
  - **Public key privacy:** la información personal se empaqueta y se cifra en el repositorio de origen con la clave pública del repositorio destino
  
  - **Password privacy**: la información personal está empaquetada y encriptada con nombre de usuario y contraseña
  
  - **Public key integrity**: la integridad se otroga mediante una firma con la clave privada del repositorio de origen. El destino verifica usando la clave publica del origen.
  
  - **Password integrity**: la integridad se garantiza utilizando un código de autentificación del mensaje (MAC) derivado de una contraseña de integridad del origen. Solo lo puede verificar quien tiene la información cifrada y la contraseña.

- Se recomienda el uso de los modos con clave publica
  
  - Una contraseña puede no ser suficiente
  
  - No obstante los métodos con contraseña son los únicos posibles si no se tiene el certificado del destino.
