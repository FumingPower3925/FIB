# 1. Introducció

## 1.1. Models

#### Models Geomètics

Transformar les dades de la realitat a formes visualitzables en un computador.

#### Tipus

**Model de Fronteres**: Realitza una aproximació per cares planes (triangles).

## 1.2. VAOs i VBOs

- Els vertex dins del VBO s'indiquen en **sentit antihorari**.

- Hi ha un **únic VAO per model.**

- **Per cada VAO existeix almenys un VBO** (el de coordenades).

## 1.3. Passos visualització

1. Processat de vértex (Programable)
   
   - Aplica la TG, la VM i la PM al model.
   
   - SCM -> SCA -> SCO -> SCC

2. Clipping + Perspective división (Fixe)
   
   - S'eliminen els triangles que estiguin totalment fora de visió
   
   - SCC -> SCN

3. Device Transform (Fixe)
   
   - Es te en compte el viewport i la relació d'aspecte
   
   - SCN -> SCD

4. Back-face culling (Fixe, es pot activar i desactivar)
   
   - S'eliminen les parts amagades dels triangles (les cares interiors).

5. Rasterització (Fixe)
   
   - Rep els triangles i els pinta amb punts, segments o polígons

6. Processat de Fragments (Progamable)
   
   - Es realitza al Fragment Shader, on s'apliquen els colors i les textures...
   
   - SCD -> SCF

7. Z-Buffer (Fixe, es pot activar i desactivar)
   
   - Elimina les parts dels triangles que es trobin "per sota" d'altres.

## 1.4. Sistemes de coordenades

1. Sistema Coordenades Model (**SCM**):
   
   - I
   
   - Coordenades inicials del model

2. Sistema Coordenades Aplicació (**SCA**):
   
   - TG * I
   
   - SCM posicionades en escena

3. Sistema Coordenades Observador (**SCO**):
   
   - VM * TG * I
   
   - SCA transformada segons les coordenades del observador

4. Sistema Coordenades Clipping (**SCC**):
   
   - PM * VM * TG * I
   
   - SCO transformades segons l'optica de la camara

5. Sistema Coordenades Normalitzades (**SCN**):
   
   - V = V / w
   
   - Obtingudes del resultat del perspective division

6. Sistema Coordenades Dispositiu (**SCD**):
   
   - SCN transformades tenint en compte el viewport

7. Sistema Coordenades Fragment (**SCF**):
   
   - Obtingut després de la rasterització

# 2. Transformacions Geométriques

## 2.1. Tipus de Transformacions

#### Translacions

OpenGL: mat4 TG = glm::translate(mat4(TG), vec3(tx, ty, tz))

Pseudocodi: TG = Translate(tx,ty,tz)

#### Rotacions

OpenGL: mat4 TG = glm::rotate(mat4(TG), (float) angle, vec3(eix))

Pseudocodi: TG = Rotate(angle, (eix))

#### Escalat

OpenGL: mat4 TG = glm::scale(mat4(TG), vec3(sx, sy, sz))

Pseudocodi: TG = Scale(sx,sy,sz)

> Per escalar a una alçada en concret Sy = tamany/(ymax-ymin)
> 
> Per escalar sense deformar sx=sy=sz

## 2.2. Caixa mínima contenedora

$centreCaixa=({(xmax+xmin)}/{2},\ {(ymax+ymin)}/{2},\ {(zmax+zmin)}/{2})$

$baseCaixa=({(xmax+xmin)}/{2},\ ymin,\ {(zmax+zmin)}/{2})$

# 3. Camara

## 3.1. Posicionat de camara

### 3.1.1. Amb funció lookAt

OpenGL: mat4 VM = glm::lookat(vec3(OBS), vec3(VRP), vec3(up))

Pseudocodi: VM = lookat(OBS,VRP,up)

> **OBS**: Punt on es troba la camara o el observador
> 
> **VRP**: Punt al que apunta la camara
> 
> **up**: Vector que apunta el sentit cap al que es troba la **part superior** de camara

### 3.1.2. Amb angles d'Euler

![firefox_wqlABH0mxl](https://user-images.githubusercontent.com/59342135/198575688-311ad625-374c-406d-93bd-d4fed9eedddd.png)

## 3.2. Camara Perspectiva

OpenGL: mat4 PM= glm::perspective((float), (float) raw, (float) zNear, (float) zFar)

Pseudocodi: PM = perspective(FOV, raw, zNear, zFar)

> FOV = 2 * arcsin(a/h)
> 
> raw: relacio aspecte
> 
> zNear: Distancia entre el OBS i el inici de la escena
> 
> zFar: Distancia entre el OBS i el final de la escena

## 3.3. Camara ortogonal

OpenGL: mat4 PM= glm::ortho(l, r,  b, t, zNear, zFar)

Pseudocodi: PM = ortho(l, r, b, t, zNear, zFar)

## 3.4. Redimensió de la finestra

### 3.4.1. En perspectiva

- Si rav > 1: Igualar raw = rav, aumentant la amplada del window

- Si rav < 1: Igualar raw = rav, modificant la alçada del window i el FOV
  
  - $h_w=2*Znear*tan(α)$

### 3.4.2. En ortogonal

- si rav > 1: 
  
  - l = -rav * RadiEscena
  
  - r = rav * RadiEscena
  
  - b = -RadiEscena
  
  - t = RadiEscena

- si rav < 1: 
  
  - l = -RadiEscena
  
  - r = RadiEscena
  
  - b = -RadiEscena / rav
  
  - t = RadiEscena / rav

## 3.5. Zoom

Opcions a escollir per a fer zoom, de millor a pitjor.

1. Modificar el window de la camara:
   
   - En perspectiva: Modificar el FOV mantenint el ra
   
   - En ortogonal: Modificar el window mantenint el ra

2. Modificar la distància de l'OBS al VRP (modificant zNear i zFar adequadament)

3. Modificar el OBS i VRP i aproparlos al objecte 

## 3.6. Camara en tercera persona

**d = 2 * RadiEscena**

zNear = d-RadiEscena

zFar = d+RadiEscena

**raw = 1**

- En Perspectiva: FOV = arcsin(RadiEscena/d)

- En ortogonal: l == b == -RadiEscena i r == t == RadiEscena

# 4. Colors

![rgb](https://user-images.githubusercontent.com/59342135/198575718-a2cb4986-8348-4d37-a643-63c048f1b5f9.png)

**RGB a CMY**

(1 - R, 1 - G, 1 - B)

**CMY a RGB**

(1 - C, 1 - M, 1 - Y)

**HSV a RGB**

![HSV A RGB](https://user-images.githubusercontent.com/59342135/198575746-a7890e1a-9e56-4d2a-b531-40cb5f3d6f00.png)

**RGB a HSV**

![RGB A HSV](https://user-images.githubusercontent.com/59342135/198575767-b80723f6-ebd7-416f-aa97-689896727ae0.png)

# 5. Diseny d'interfícies

##### Objectius

- **Eficacia**: Completar totalment i correctament la tasca

- **Eficiencia**: Relació entre els recursos utilitzats i els resultats obtinguts

- **Satisfació**: El confort i la adaptació al sistema per part dels usuaris

## 5.1. Principis de diseny

- **Interfícies efectives**: Donar al usuari la sensació de control i amagar el treball intern del sistema

- **Aplicacions efectives**: Realitzar el màxim de treball requerint el mínim input per part del usuari

### 5.1.1. Llista Principis

- **Asthetics**:
  
  - La moda no ha d'estar mai per sobre de la usabilitat
  
  - L'usuari coneix els controls estandar, els no-estandar requereixen d'un esforç
  
  - El texte ha de ser llegible i tenir un alt contrast amb el fons

- **Anticipation**:
  
  - Posar a disposició del usuari tota la informació i les eines necesaries sempre
  
  - Anticipar les necesitats del usuari
  
  - Informació visible

- **Autonomy**:
  
  - Permetre que  l'usuari disposi de cert grau de personalització i d'elecció
  
  - Mantenir al usuari informat dels estats i progresos
  
  - Donar feedback de cada acció al usuari
  
  - Tasca > 1 segon -> Cursor ocupat
  
  - Tasca > 10 segons -> Barra de progrés

- **Color**:
  
  - Tenir en compte a les persones que no distingeixen certs colors.
  
  - Utilitzar alt contraste.
  
  - Els colors tenen diferents significats per a las diferents cultures.

- **Consistency**:
  
  - **Nivells de consistencia**:
    
    - **Consistencia de plataforma**: Directrius de diseny segons plataforma
    
    - **Conjunt de productes**: Mantenir l'aspecte per a tota la gama de productes
    
    - **In-app**: Mantenir l'estil de diseny dins de la propia app.
    
    - **Estructures visibles**: Controlar l'aparencia i mantenir posicions similars
    
    - **Estructures invisibles**: Evitar o informar de la existéncia
    
    - **Mai cambiar el significat d'una acció habitual**
  
  - **Inconsistencia induida**: Fer que els objectes diferents actuin de formes diferents i notificar de canvis funcionals.
  
  - **Continuitat induida**: Si el usuari sap que algo actua de certa manera NO canviar-lo.
  
  - **Expectatives del usuari**: Implementar funcionalitat com el usuari les espera

- **Default values**:
  
  - Tenir camps per defecte que serveixin de guía per l'usuari
  
  - Permetre actualitzar els camps, borrar-los o desfer-los
  
  - No tots els camps requereixen d'un valor per defecte

- **Discoverability**:
  
  - Controls visibles
  
  - Comunicar graficament les funcions per gestos
  
  - Guiar al usuari a forma de tutorial

- **Efficiency**:
  
  - Prioritzar la productivitat del usuari
  
  - Mentenir-lo ocupat
  
  - Informar de manera útil dels misatjes d'error

- **Explorable interfaces**:
  
  - Llibertat i seguretat per explorar
  
  - Permetre torar enrrere i desfer canvis
  
  - Demanar confirmació de canvis irreversibles

- **Fitt's law**:
  
  - Objectes grans son més inportants
  
  - Objectes petits son menys importants

- **Informing users**:
  
  - Informar al usuaris dels temps d'espera
  
  - Reconeixer els clics de botons amb un procés visual de 50 ms

- **More principles for usability**:
  
  - Asegurares que el usauri no perdi la seva feina
  
  - Escollir metáfores extrapolables del mon real al virtual

### 5.1.2. Llista Principis Universals

- **Asthetic-Usability Effect**: 
  
  - Dedicar esforços a millorar els nostres disenys
  
  - Un diseny estétic dona sensació de més facilitat d'us i fomenta el seu us

- **Fix a visual hierarchy**:
  
  - Utilitzar la escala modular per garantitzar unes proporcions armonioses

- **Correct alignment**:
  
  - Els elements han d'estar alineats
  
  - Crea una sensació de unió i cohesió

- **Nesting**:
  
  - Es una cua visual de la jerarquía de la informació mostrada

- **Chunking**:
  
  - Agrupa un element en elements mes petits

- **Color**:
  
  - Utiltizar una paleta de colors de maxim 5 colors.
  
  - Els colors saturats criden mes la atenció, els no saturats son mes profesionals

- **LATCH principle**: La informació s'organitza en funció de:
  
  - Localització, alfabéticament, temps, categoria i jerarquicament

- **Garbage-in garbage-out (GIGO)**:
  
  - Comprovar els inputs dels usuaris per que estiguin en un format correcte
  
  - Restringir els tipus d'entrada de dades

- **Representació d'icones**:
  
  - **Similaritat**: L'icone es visualtment similar a la acció/objecte que representa
  
  - **Exemple**: Els elements poden ser relacionats amb la imatge
  
  - **Symbolic**: Alt nivell d'abstracció (Password -> clau i candau)
  
  - **Arbitrary**: No tenen cap relació amb l'element o acció

## 5.2. Lleis de percepció

- **Prägnanz Law**: Tendencia a percebre formes simples

- **The law of closure**: Tendencia a completar figures regulars

- **The law of similarity**: Tendencia a agrupar elements

- **The law of prociminity**: Tendencia a agrupar per proximitat

- **The law of symmetry**: Tendencia a agrupar elements simétrics

- **The law of continuity**: Tendencia a seguir patrons

- **The law of common fate**: Agrupem elements movent-se en la mateixa direcció

- **Orientation Sensitivity**: Linies verticals, horitzontals distingim be, obliques no

- **Pictorial superiority effect**: Es recorda mes la informació percebuda en imatges

- **Rule of thirds**: Bona idea utiltizar els punts d'intersecció dels terços d'una imatge

- **Signal to noise ratio**: Maximitzar el que volem percebre i minimitzar la resta

## 5.3. Disenys amb color

S'ha de tenir en compte la gent amb incapacitat per distingir certs colors.

- Evitar colors molt saturats

- Colors de fons consistents

- Utiltizar colors amb contrast pels textos

- Utilitzar colors diferents només quan corresponguin a significats diferents

- Utilitzar colors suaus i naturals per la major part d'informació i reservar els colors foscos i brillants per resaltar la informació que requereix atenció

- Utilitzar paletes de colors

- Els components d'una taula de dades han de ser suficientment visibles pero no massa grans

- Evitar combinar el verda amb el vermell a la vegada

- Utlitzar colors oposats
