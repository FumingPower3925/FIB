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

2. En perspectiva: modificar la distància de l'OBS al VRP (modificant zNear i zFar adequadament)

3. En perspectiva: modificar el OBS i VRP i aproparlos al objecte 

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

- **The law of proximinity**: Tendencia a agrupar per proximitat

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

# 6. Realisme i iliminació

## 6.1. Depth Buffer

- Que fa?

> Elimina les parts no visibles dels objectes, aquelles que no siguin visibles per estar cobertes per un altre objecte que es troba devant seu segons la perspectiva de la camara.

- Que necessita?

> Per a funcionar i implementar-lo només es necessari enmagatzemar en un buffer de profunditat a quina profunditat es troben cada un dels pixels.

- A tenir en compte

> NO requereix tenir activat el back-face culling

## 6.2. Back-face Culling

- Que fa?

> Elimina les cares que no es veuen

- Que necessita?

> Que les cares estiguin orientades amb la normal

- A tenir en compte

> Nomes treu les cares que segur que no es veuen

## 6.3. Iluminació

- Ambient

> Com be indica el seu nom, es una llum que no es representada en un focus en escena sino que tots els objectes en reben la mateixa iluminació per tots costats.

- Difus

> El model difus es el que "dona color" als objectes, es representa com un punt al espai que irradia la mateixa llum en ottes direccions.

- Especular

> També es representa amb focus de llums puntuals, i el observador només ho podra veure si es troba en la trajectoria de la reflexio especular.

## 6.4. Qualitat

### 6.4.1. Suavitzat d'arestes

Les normals es poden calcular per cada cara o per cada vertex. Si es calcula:

- Per cada cara:
  
  S'obté mes velocitat i es necessiten menys recursos, pero les arestes queden molt marcades, baixa la quailitat.

- Per cada aresta:

        S'obté mes suavitat donanli un component de mes "qualitat" al resultat, a costa         però de un cost de comput mes elevat.

### 6.4.2. Calcul del color

El color es pot calcular per cada vertex o per a cada fragment. Si es calcula:

- Per cada vertex:

        Es un calcul molt menys costos, pero implica una qualitat inferior en el resultat

- Per cada fragment:
  
  Es un calcul molt costos, pero dona un resultat molt bo

# 7. Interacció

**Incertesa**

$$
\log_{2}{M}=-\log_{2}{P}=x\ bits
$$

> **M:** es el numero de probabilitats equiprobables
> 
> **P:** $P={1}/{M}$, per tant es la probabilitat

**Hick-Hyman Law**

Correspon al temps en prendre una decisió

$$
RT=a+b\ ·H_T

$$

> a i b: Constants
> 
> **$H_T$:** Es la informació transmesa, que es pot calcular com:
> 
> - $H_T=\log_2(n+1)$
> 
> > **n:** es el numero d'alternatives

## 7.1 Fitts' Law

**Original Formulation**

Estableix una relació lineal entre el moviment i la dificultat de la tasca

$$
MT=a+b\ ·ID
$$

> a: Temps d'inici i fi en segons
> 
> b: Velocitat inherent al dispositiu
> 
> *$ID$:* Es el index de dificultat, que es pot calcular com:
> 
> - $ID=\log_2\Big(\frac{2A}{W}\Big)$
> 
> > A: Es la amplitud del moviment
> > 
> > W: Es la amplitud del target

**Welford**

$$
ID=\log_2\Big(\frac{D+0.5W}{W}\Big)
$$

> D: Es la distancia del moviment

**MacKenzie's**

$$
ID=\log_2\Big(\frac{D}{W}+1\Big)
$$

Es una de les mes acceptades avui en dia

## 7.2 Other Laws

**Crossing Law**

Es pot mesurar entre dos objectius

$$
T=a+b\ ·\log_2\Big(\frac{D}{W}+1\Big)
$$

> T: Es el temps promitg al passar entre dos objectius
> 
> D: Es la distancia entre els dos objectius
> 
> W: Es la amplada de cada objectiu
> 
> a i b: Son constants

**Steering Law General Path**

La navegació a través d'un **cami general** pot ser expresada com:

$$
T_s=a+b\ ·ID_s
$$

> $ID_s:$ Es calcula amb una integral, en el examen te la han de donar
> 
> a i b: Son constants

**Steering Law Straight Path**

$$
T_P=a+b\ ·ID_P \\
ID_P=\frac{D}{W}
$$

Es pot també aplicar a camins circulars d'amplada constant

## 7.3 Lleis Aplicades

- Mantenir els objectes relacionats aprop i els oposats lluny

- Els Pop-up menus, tenen com avantatge reduir la distancia de recorregut (fitts)

- Els Pop-up menus son dificils d'implementar, només utilitzats per experts

- Els Pie-menus, son aplicacións molt especifiques i necesiten **força espai**

- Els Pie-menus NO han de tenir oclusions, en movil els half-pie son millors per això

- Els Pie-menus son dificls de disenyar 

**Accelerating Target Acquisition**

- Incrementar el tamany dels tarjets propers al punter

- Bubble Targets, podem incrementar la regió selecionable al voltant del target
  
  - Tenen com a problema que poden dificultar seleccionar targets propers

- Bubble cursos, podem incrementar la regio del cursor per incloure elements
  
  - Dynamic bubble cursor, podem fer-ho tenint en compte la velocitat del punter

- Stikcy Targets, podem atreure el punter quan estigui aprop del target

# 8. Dispositius amb els que interactuar

## 8.1 Pointing devices

- Direct control devices: tàctil.
  
  > Estratègia land-on: click quan apretem.
  > 
  > Estratègia lift-off: es clica quan deixem anar.

- Indirect-control devices: cursor.

## 8.2 Teclats

- QWERTY: tecles que es teclegen juntes es col·loquen a més distància (en anglès).

- AZERTY: francès.

- Dvorak: vocals juntes i en anglès (nivell baix d'acceptació).

# 10. Introducció a VR i AR

## 10.1 Realitat virtual

Simulació interactiva en què la informació sensorial es percep substituïda i augmentada.

- **Visualització interactiva**: reprodueix un món virtual que només existeix com a model digital a dins de l'ordinador.

- **Interacció implícita**: el sistema decideix què és el que l'usuari vol a partir dels seus moviments naturals.

- **Immersió**: desconnectar el sentits del món real i connectar-los al món virtual.
  
  > **Fusió**: capacitat del cervell humà de combinar dues imatges amb disparitat retinal (el que veu un ull) en una sola imatge amb profunditat (*stereopsis*, la imatge que veiem amb els dos).

Sistemes de realitat virtual:

- Immersius

- Semi-immersius

Sistemes de configuració:

- **Pantalla dinàmica**: les pantalles segueixen els moviments del cap, per lo que estan fixes respecte als ulls.

- **Pantalla estàtica**: configuració que segueixen els sistemes basats en projecció.
  
  > En la projectMatrix es fa servir la funció frustrum(left, right, bottom, top, near, far).
  > 
  > En la viewMatrix es fa servir un lookAt(vec3 eye, vec3 center, vec3 up).

Interacció:

- Interacció 3d
  
  > Interacció HC (Human-Computer) en que les tasks de l'usuari es fan en un context espacial.
  > 
  > Utilització de dispositius d'entrada 2D o 3D amb mapejos directes a 3D.

- Experiència d'usuari en 3D: interfaç d'usuari que implica interacció en 3D.

- Tècniques d'interacció en 3D: tècnica dissenyada per solucionar tasks, implica l'ús de hw i sw.

- Selecció 3D: seleccionar una tasca en un ambient immersiu.

Interacció VR i selecció 3D:

- Hand extension techniques: mapeja la posició de la mà de l'usuari.

- Ray-based techniques: fa servir la posició de la mà i un altre element per indicar la orientació.

**Presència**: és la paradoja que es forma al saber que el que estàs pensant, sentint i comportant-te com una situació fos real sabent que no ho és.

## 10.2 Realitat augmentada

Combinació d'una escena real i una escena virtual que augmenta la informació de l'escena. Tenim accés a dues escenes de manera simultània.

L'objectiu és millorar el rendiment de l'usuari i la seva percepció del món.

| Realitat augmentada                                          | Realitat virtual                                     |
| ------------------------------------------------------------ | ---------------------------------------------------- |
| Sistema que augmenta l'escena del món real.                  | Entorn totalment immersiu.                           |
| L'usuari manté la sensació de presència en el món real.      | El sentit de la vista està sota control del sistema. |
| Necessita d'un mecanisme per combinar el món virtual i real. |                                                      |

Importància del registre dels objectes:

- Els objectes virtuals generats per ordinador han de ser registrats amb precisió amb el món real amb totes les dimensions.

- Els errors impediran que l'usuari vegi les imatges reals i virtuals fusionades.

- El correcte registre s'ha de mantenir mentre l'usuari es mogui per l'entorn real.

- Les discrepàncies o canvis en el registre provoquen la distracció i poden ser físicament molestos.

3 maneres de presentar visualment la realitat augmentada:

- Video see-through: es sobreposen una imatge real i virtual en un vídeo.

- Optical see-through: l'usuari veu el món real directament i es sobreposen certes imatges (ulleres de google).

- Projecció RA: les imatges són projectades directament sobre els objectes físics.

# 11. Bad graphs

## 11.1 Principis de bones representacions gràfiques

Les línies d'una taula o graf han de ser visibles, però no obstructives. Lo millor és fer servir un color gris claret (tot i que no sempre són necessàries).

Els eixos han d'estar anomenats amb el nom de la variable i el graf ha detenir títol.

Hem de fer servir el tipus adequat de graf segons el que vols representar:

> **NO** facis servir **MAI** el diagrama de quesitos.

- **Trend graphs**: mostrar una tendència d'una variable en un període de temps.
  
  > Graf de línies > graf de barres.

- **Relative size graphs**: és el millor per comprar una cosa amb una altra. Les barres han de tenir la mateixa amplitud i començar al 0.

- **Composition graphs**: les barres que van del 0 al 100% estan segmentades en proporció a l'ús que en fa la variable per a aquella categoria.

## 11.2 Errors comuns en grafs malament fets

- **Wrong type of graph**

- **"Ducks"**: ús innecessari de símbols.

- **Missing text**: no anomenar els eixos i no posar títol al graf.

- **Inconsistent scale**: cada separació d'un eix ja de ser uniforme.

- **Misplaced zero point**: el zero dels eixos ha d'estar col·locat a la part inferior del dibuix del graf, on la major part de la gent assumeix que està el zero.

- **Poor chart effects**: els efectes 3D no aporten informació i distorsionen la percepció del graf.

- **Confusion of area and length**: fer una imatge el doble de gran vol dir multiplicar l'àrea per 4.

- **No adjustment for inflation**: quan es parla de diners hem de tenir en compte l'inflació en aquella data.

- **Too much precision**: fer servir magnituds correctes, en comptes d'escriure 13.356.683 escriurem 13 milions.
