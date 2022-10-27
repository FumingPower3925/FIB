# Examen Final IDI

> Resumen o manual de como sacar mas de un 7,61 estudiando el último dia porque en el parcial y el examen de lab no hiciste nada y quieres aprovar :D

## Introducción

- **Un VAO por modelo**

- Para obtener cordenadas del observador: $VM·TG·I$

- Los ejes en OpenGL son los siguientes<img title="" src="http://computacion.cs.cinvestav.mx/~ocuate/RealidadVirtual/Imagenes/ejes.png" alt="" width="179" data-align="left">

## Pasos Visualización OpenGL

1. **Procesado de vértices (Programable)**:
   
   Recibe las cordenadas **TG** (SCM) y las pasa por **VM** (SCA), **PM** (SCO) y finalmente **las envia a Clipping**.

2. **Clipping + Perspective división (Fijo)**:
   
   Se **eliminan los triángulos** que se encuentren enteros fuera del rango de visión.
![firefox_wqlABH0mxl](https://user-images.githubusercontent.com/59342135/198405077-8615fe89-ae18-4ebe-a501-f8f1c965f789.png)

3. **Device transform (Fijo)**:
   
   Se tienen en cuenta el **viewport y la relación de aspecto** (ra).

4. **Back-face culling (Fijo, se puede activar y desactivar)**:
   
   Si se activa, **elimina los triangulos "escondidos" por la perspectiva**.

5. **Rasterización (Fijo)**:
   
   Recibe triángulos y los pinta con puntos, segmentos o polígonos.

6. **Procesado de fragmentos (Programable)**:
   
   Se realiza en el Fragment Shader, se aplican los colores, texturas, iluminaciones...

7. **Z-Buffer/Depth-buffer (Fijo, se puede activar y desactivar)**:
   
   Si se activa, **elimina los triangulos** que quedan **tapados detrás de otros objetos**.

## Transformaciones geométricas

##### Translaciones

$TG=Translate(t_x, t_y, t_z)$

##### Rotaciones

$TG = Rotate(anguloRot, (eje\_rot))$

> $eje\_rot$: $X: (±1,0,0)\ ||\ Y:(0,±1,0)\ ||\ Z:(0, 0, ±1)$

##### Escalado

$TG=Scale(s_x, s_y, s_z)$

> Antes de escalar un objeto llevar-lo al centro de cordenadas.

##### Caja mínima contenedora

$Radi\ Escena=\sqrt{\bigg(\cfrac{x_{max}-x_{min}}{2}\bigg)^2+\bigg(\cfrac{y_{max}-y_{min}}{2}\bigg)^2+\bigg(\cfrac{z_{max}-z_{min}}{2}\bigg)^2}$

$Centro\ caja =\bigg(\cfrac{x_{max}+x_{min}}{2},\ \cfrac{y_{max}+y_{min}}{2},\ \cfrac{z_{max}+z_{min}}{2}\bigg)$ 

$Base\ caja =\bigg(\cfrac{x_{max}+x_{min}}{2},\ y_{min},\ \cfrac{z_{max}+z_{min}}{2}\bigg)$

## Posicionamiento Cámara

##### Mediante lookAt

$VM=lookat(OBS, VRP, up)$

> $OBS$: Cordenadas del observador.
> 
> $VRP$: Cordenadas punto ojetivo.
> 
> $up$: Vector vertical que marca donde esta la parte de "arriba" de la camara.

##### Mediante ángulos de Euler

$$
VM=Translate(0,0,-2·radi)\\
VM=VM·Rotate(\varphi, (0,0,1))\\
VM=VM·Rotate(\theta, (1,0,0))\\
VM=VM·Rotate(\psi, (0,1,0))\\
VM=VM·Translate(-VRP)
$$

## Tipos de Cámaras

##### Cámara perspectiva

$PM=perspective(FOV,ra,zN,zF)$

> $FOV$: Grado apertura de la cámara $FOV=2·arcsin(R/d)$
> 
> $ra$: Realación de aspecto
> 
> $zN$: Distancia entre OBS y el punto mas cercano.
> 
> zF: Distancia entre OBS y el punto mas lejano

##### Cámara ortogonal

$PM=ortho(l,r,b,t,zN,zF)$

> l: Left
> 
> r: Right
> 
> b: Bottom
> 
> t: Top

## Zoom

- Óptica perspectiva:
  
  - Modificar **FOV**, **OBS**y **VRP**.

- Óptica ortogonal:
  
  - Modificar window.

## Colores

##### RGB a CMY

- Red + Blue = Magenta

- Blue + Green = Cian

- Green + Red = Yellow
  
  $Cian=1-Red;\ Magenta=1-Green;\ Yellow=1-Blue;$

##### CMY a RGB

- Cian + Yellow = Green

- Yellow + Magenta = Red

- Magenta + Cian = Blue
  
  $Red=1-Cian;\ Green=1-Magenta;\ Blue=1-Yellow;$

##### HSV a RGB

$C=V·S$

$X=C·(1-|(H/60)\mod2 -1|$

$m=V-C$

|                   | R'  | G'  | B'  |
|:-----------------:|:---:|:---:|:---:|
| $0\leq H < 60$    | C   | X   | 0   |
| $60\leq H < 120$  | X   | C   | 0   |
| $120\leq H < 180$ | 0   | C   | X   |
| $180\leq H < 240$ | 0   | X   | C   |
| $240\leq H < 300$ | X   | 0   | C   |
| $300\leq H < 360$ | C   | 0   | C   |

$(R,G,B)=((R'+m)·255,\ (G'+m)·255,\ (B'+m)·255)$

##### RGB a HSV

- Si $(R, G, B) > 1$:
  
  - $R'=R/255;\ G'=G/255;\ B'=B/255$

$C_{max}=max(R',G',B')$

$C_{min}=min(R',G',B')$

$\Delta=C_{max}-C_{min}$

|     | $\Delta = 0$ | $C_{max}=R'$                                | $C_{max}=G'$                             | $C_{max}=B'$                             |
|:---:|:------------:| ------------------------------------------- | ---------------------------------------- | ---------------------------------------- |
| H   | 0            | $60·\bigg(\cfrac{G'-B'}{\Delta}\mod6\bigg)$ | $60·\bigg(\cfrac{B'-R'}{\Delta}+2\bigg)$ | $60·\bigg(\cfrac{R'-G'}{\Delta}+4\bigg)$ |

## Iluminación

##### Ambiente

- NO Focos

- Mismo color todo el objeto, sensación de objeto plano

##### Difuso (Lambert)

- Focos de luz puntuales

- El color varia dependiendo de la visión y la posicion del punto de luz

##### Especular (Phong)

- Focos de luz puntuales

- Solo se ven si se encuentra en la dirección de reflexion especular (Angulo I + 90º)

##### Suavizado de aristas

- Declarar las normales en el vertice de cada cara, dando mas definición.

## Introducción Diseño de interfaces y usabilidad

##### Definiciones

- HCL: Tienen por objetivo evaluar y comprender las teconologías interactivas. 
  Sus tareas:
  
  - **Eficacia**: Completar total y correctamente la tarea.
  
  - **Eficiencia**: relacion entre resultados y recursos invertidos.
  
  - **Satisfacción**: Confort y adaptación del usuario.

- UX: Creación de una experiencia significativa a través del dispositivo.

- Interaction Design: Consiste en dar forma a las cosas digitales para el uso de pers.

- GUI (Grafical User Interface)

##### Principios de Diseño

Conceptos Base:

- **Interfaces efectivas**: Dar al usuario la sensación de control y ocultar el trabajo interno del sistema.

- **Aplicaciones efectivas**: Realiza el máximo de trabajo requeriendo un mínimo de información por parte de los usuarios.

Principios:

- **Aesthetics**:
  
  - La moda no debe estar por encima de la usabilidad
  
  - El usuario sabe los controles standard. Los No-standard requieren esfuerzo por parte del usuario.
  
  - El texto debe ser legible, tener un alto contraste con el fondo.

- **Anticipation**:
  
  - Poner a disposición del usuario toda la información y las herramientas necesarias para cada proceso.
  
  - Anticipar las necesidades del usuario.
  
  - Información visible

- **Autonomy**:
  
  - Dejar que el usuario tenga cierto grado de personalización y toma de decisiones.
  
  - Mantener al usuario informado de estados, progresos...
  
  - Dar feedback de cada acción.

- **Color**:
  
  - Tener en cuenta a las personas que no distinguen ciertos colores
  
  - Los colores tienen diferentes significados para las distintas culturas

- **Consistency**:
  
  - **Niveles de consistencia**:
    
    - **Consistencia de plataforma**
    
    - **Conjunto de productos**
    
    - **In-app**
    
    - **Estrucutras visibles**: Controlar la apariencia y mantener un posicionamineto similar.
    
    - **Estructuras invisibles**: Se han de evitar o informar de su exstencia.
  
  - **Inconsistencia inducida**: Hacer los objetos diferentes si actúan diferente y notificar cambios funcionales.
  
  - **Continuidad inducida**: Si el usuario sabe que algo actúa de cierta manera NO cambiarlo.
  
  - **Expectativas del usuario**: Implementar funcionalidades cómo el usuario espera, no forzarlo a aprenderlas.

- **Default Values**:
  
  - Tener campos por defecto que sirvan de guía para el usuario.
  
  - Permitir actualizar campos, borrar o deshacerlos.
  
  - No todos los campos requieren un valor por defecto.

- **Discoverability**:
  
  - Controles visibles.
  
  - Comunicar gráficamente las funciones por gestos.
  
  - Guiar al usuario en forma de tutorial.

- **Efficiency**:
  
  - Priorizar la productividad del usuario.
  
  - Mantenerlo ocupado.
  
  - Informar, de manera útil, de los mensajes de error.

- **Explorable interfaces**:
  
  - Libertad y seguridad para explorar.
  
  - Permitir volver atrás y deshacer cambios.
  
  - Pedir confirmación de cambios irreversibles.

- **Fitts's Law**:
  
  - Objetos grandes son más importantes.
  
  - Objetos pequeños son menos importantes.

- **Informing users**:
  
  - Informar a los usuarios de los tiempos de espera.
  
  - Reconocer clics de botones con un proces visual de 50 ms.

- **More principles for usability**:
  
  - Asegurarse de que el usuario no pierda su trabajo.
  
  - Escoger metáforas extrapolables del mundo real al virtual.

##### Principios de diseño universal

- **Aesthetic-Usability Effect**: Dedicar esfuerzos a mejorar nuetros diseños. Un diseño estético de sensación de más facilidad de uso.

- **Fix a visual hierarchy**: Usar la escala modular garantiza buenas proporciones.

- **Correct alignment**: Los elementos deben estar alineados, esto creo una sensación de unión y cohesión.

- **Define a grid**

- **Nesting**: Es una cola visual de la jerarquïa de la información mostrada.

- **Chunking**: Agrupa un elemento en elementos más pequeños.

- **Color**: usar una paleta de maximo 5 colores, los colores saturados llaman la atencion pero los no saturados son mas profesionales.

- **LATCH principle**: La información se organiza en función de: localización, alfabéticamente, tiempo, categoría, jerárquicamente.

- **Garbage-in garbage-out**: Comprobar los inputs hechos por los usuarios para asegurar que los datos introducidos están en un formato correcto y restringir los tipos de entrada de datos.

- **Iconic representation**: Imágenes que tratan de representar objetos o acciones:
  
  - **Similarity**: El icono es visualmente similar a la acción/objeto que representa.
  
  - **Example**: Los elementos pueden ser relacionados con la imagen.
  
  - **Symbolic**: Alto nivel de abstracción.
  
  - **Arbritary**: No tienen relación con el elemento o acción.

##### Leyes de percepción (Gestalt Laws)

- **Prägnanz Law**: Tendencia a percibir formas simples.

- **Law of closure**: Tendencia a completar figuras regulares.

- **Law of proximity**: Tendencia a agrupar por proximidad.

- **The law of symmetry**: Tendencia a agrupar elementos simétricos.

- **The law of continuity**: Tendencia a seguir patrones.

- **The law of common fate**: tendencias a agrupar elementos moviéndose en la misma dirección.

- Mas leyes de percepción:
  
  - **Orientation Sensitivity**: Líneas de dirección vertiacles y horizontales se distinguen bien, las oblicuas no tanto.
  
  - **Pictorial superiority effect**: A largo plazo, se recuerda más información percibida en imágenes.
  
  - **Rule of thirds**: Divide la imagen en 9 partes diferentes, distribuir los elementos siguiendo esas lineas.
  
  - **Signal to noise ratio**: Maximizar la señal y minimizar el ruido.

##### Diseños con color

- Color Blindness:
  
  - Deuteranotopia: Menos luz verde
  
  - Protanopia: Menos luz roja.
  
  - Tritanopia: Sensibilidad reducida a la luz azul.
  
  - Achromatopisa: No puede ver ningún color.

- Normas color
  
  - Evitar colores muy saturados
  
  - Si queremos que objetos del mismo color parezcan del mismo color, usar un color de fondo constante.

##### Interacción

- **Hick-Hyman Law**: Tiempo para tomar una decisión:
  
      $RT=a+bH_T$
  
  > a y b son constantes $H_T$ es la información transmitida
  
      $H_T=\log_2(n+1)$
  
  > Donde n es número de alternativas

- **Fitts' Law**: Relacion entre movimento (MT) y dificultad de la tarea
  
  $MT=a+b·ID$
  
  > ID es el indice de dificultad
  
  $ID=\log_2\bigg(\cfrac{2A}{W}\bigg)$
  
  > Donde A es la amplitud del movimiento y W la amplitud del target
  
  - Welford:
    
    $MT=a+b·ID$
    
    $ID=\log_2\bigg(\cfrac{D+0.5W}{W}\bigg)$
  
  - **MackKenzie's**:
    
    $MT=a+b·ID$
    
    $ID=\log_2\bigg(\cfrac{D}{W}+1\bigg)$

- **Crossing Law**: Movimiento descrito al cruzar con el cursor por la pantalla. Sigue la misma caracterización que la ley de Fitts Mackenzie's.

- **Steering Law**: Movimiento que realizas al desplazarte por un menu desplegable.

- **Fitts' Law in UI Design Applications**:
  
  - Mantener los objetos relacionados cercanos y los opuestos lejanos
  
  - Los menus pop-up reducen la distancia a recorrer.
  
  - Perception: Agrupar cosas puede mejorar con la distancia.

- **Accelerating Target Acquisition**
  
  - Expanding Targets:
    
    - Incrementar tamaños de los objetos ceracnos al cursor
    
    - Bubble Targets: Incrementar la región seleccionable alrededor del target
    
    - Dynamic Bubble Cursor: La área de selección aumenta según la velocidad
  
  - Target Moving
    
    - Mover Target hacia el usuario
    
    - Generar pop-ups al lado del usuario
    
    - Sticky targets: Atraer el puntero al target cuando está cerca

##### Dispositivos con los que interactuar

- Teclados PC:
  
  - QWERTY: Hecho para escribir en ingles
  
  - AZERTY: Optimizado para escribir en francés
  
  - Dvorak: Teclado optimizado para ingles. Nivel de aceptacion bajo.

- Teclados Movi:
  
  - **Minuum**: Agrupa las 3 filas de teclas en 1 requiere predictor/corrector y ocupa poca pantalla.
  
  - Diagram-based layout: Optimiza las distancias.
  
  - Single finger gesture: Se arrastra el dedo a través de las teclas, necesita un predictor.
  
  - **KALQ**: Divide el teclado en dos partes para cuando usas el teclado en horizontal.

##### Test de usabilidad

Objetivos test de usabilidad:

- **Determinar problemas de usabilidad**: Descubrir, priorizar y resolver problemas de usabilidad y hacer **preubas iterativas**.

- **Medir el rendimiento de tareas**: El desarrollo de los objetivos de la usabilidad y hacer pruebas iterativas para determinar si el producto ha alcanzado los objetivos.

Técnicas para pruebas:

- Pruebas formales de usabilidad, requieren un entorno controlado: dentro o fuera de una habitación para controlar la luminosidad. y otras condiciones.

Flujo de trabajo de las pruebas de usabilidad:

- Preparación: Preparar los objetivos/medidas, la finalidad, etc.

- Implementación: Realizar las core tasks y las peripheral tasks a los participantes.

- Presentación del informe: Análisis y evaluavión de datos, problemas/medidas y recomendaciones.

> Es mejor hacer pruebas a una sola persona antes que a 50.

Prueba de usabilidad **Guerrilla**

- Llevar a alguien a una cafetería o espacio púbilico y hacer que use la pagina durante unos minutos.

- Observar al usuario, hacer preguntas abiertas.

- Analizar los datos considerando la audiencia.

**Remote testing**

- Ventajas: Es barato y fácil, sueles ser más rápido y usuarios de todo el mundo.

- Desventajas: No podemos observar el lenguaje corporal. dificil interactuar, motivación de los participantes dudosa.

**Evaluación herística**

De 3 a 5 expertos en usabilidad que evalúan la UI que usan principios predefinidos y realzan los problemas de usabilidad antes que los usuarios.

- Ventajas: rapido y rentable, sobretodo para las priemras fases.

##### Medidas de la planificación de las pruebas de usabilidad

- Para descubrir un problema:
  
  - Centrarse en la priorización de los problemas.
  
  - Numero de iteraciones previamente planificado.
  
  - Numero de participantes pequeño pero multiples iteraciones.

- Para las pruebas de medición:
  
  - Categorías:
    
    - Indicadores de logro de metas
    
    - Indicadores de ritmo de trabajo
    
    - Indicadores de operatividad
  
  - Medidas globales fundamentales:
    
    - Tasas de finalización de tareas con éxito
    
    - Tiempos medios de realización de tareas
    
    - Indices de satisfacción media de los participantes.

- Tras la elección de medidas, el objetivo de la usabilidad se puede determinar.
  
  - Suele ser mejor establecer objetivos que ahgan referencia a una medida que a un percentil.
  
  - Los objetivos percentiles requieren muestras de gran tamaño.

##### Principios de buenas representaciones gráficas

Tipos basicos de graficos:

- Gráficos de tendencia: Sirven para destacar la tendencia de una serie temporal.

- Fráficos de tamaño relativo: Usar gráficos de barras paralelas y de la misma anchura.

- Gráficos de composición: Usarlos para representar porcentajes en vez del grafico circular. Permite que el lector pueda estimar con precision el porcentaje.

Errores comunes:

- Tipo de gráfico incorrecto.

- Falta de texto (etiquetas, lineas y titulo).

- Escala inconsistente

- Punto cero mal colocado

- Efectos de gráficos deficientes o *ducks* (sombreados, efectos 3d...)

- Confusión de área y longitud (todos han de tener la misma anchura)

- No se ajsuta a la inflacion: Si se trata de dinero

- Demasiada precisión en los numeros

- Imagenes ofensivas hacia ciertos colectivos
