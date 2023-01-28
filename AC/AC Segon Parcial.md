# AC Segon Parcial

##### Cache Basica

##### Propiedades

- **Localidad temporal**: Cuando **se accede repetidamente a las mismas instrucciones**. Esto sucede ya que los programas suelen tener muchos bucles.
  
  - Se puede sacar provecho: Si usamos un dato, guardarlo "cerca" del procesador

- **Localidad espacial**: Cuando **se accede a una instruccion seguramente se accedera a instrucciones cercanas**. Esto sucede ya que las instrucciones se ejecutan de forma secuencial.
  
  - Se puede sacar provecho: Si "traemos" un dato, traer datos contiguos.

##### Definiciones

- **Algoritmo de Emplazamiento**: Determina en qué lineas de MC puede colocarse un bloque.

- **Algoritmo de reemplazo**: Determina quë línea se ha de eliminar de la cache para dejar espacio a un nuevo bloque.

- **Políticas de escritura**: Determina cómo y cuando se hacen las escrituras.

##### Algoritmos de Emplazamiento

| Nombres                  |     |              |       |
| ------------------------ | --- | ------------ | ----- |
| Emplazamiento Driecto    | TAG | #linea MC    | #byte |
| Asociativo por Conjuntos | TAG | #conjunto MC | #byte |
| Completamente Asociativo | TAG | -            | #byte |

> **TAG**: Es el identificador de bloque para saber de que bloque se trata.
> 
> **\#linea MC**: Es el numero de linea de la memoria cache en la que esta.
> 
> **#conjunto MC**: Es el numero de conjunto de MC en el que se encuentra.
> 
> **#byte**: Es el numero de byte del bloque al que se dirije, si la MC es de 32 bytes, se necesitaran 5 bits en #byte para ordenarlos.

##### Algoritmos de Reemplazo

| Nombres                             |
| ----------------------------------- |
| Reemplazo Aleatorio                 |
| Reemplazo FIFO (First In First Out) |
| Reemplazo LRU (Least Recently Used) |
| Reemplazo PseudoLRU                 |

##### Politicas de Escritura

- Cuando se actualiza la memoria principal?
  
  - **WRITE THROUGH**: Escritura simultanea en MC y MP.
  
  - **COPY BACK**: Escritura diferida en MP. Se escriben cuando se saca de MC.

- Que hacer en caso de fallo de escritura?
  
  - **WRITE ALLOCATE**: Se trae el bloque de MP a MC y después realiza la escritura.
  
  - **WRITE NO ALLOCATE**: Escritura directamente en MP.

- Combos:
  
  - Write Through + Write NO Allocate
  
  - Copy Back + Write Allocate

##### Medida de Rendimiento

- Tasa de Aciertos: $h={\#aciertos}/{\#referencias}$

- Tasa de Fallos: $m={\#fallos}/{\#referencias}=1-h$

- Tiempo medio acceso (lectura): $Tma=tsa+m·tpf$

- Tiempo de ejecuacion: $Tejec=N·CPI·Tc$

- CPI: $CPI=CPIideal+CPImem$

- CPImem(lectura): $CPImem=nr·(Tma-tsa)=nr·m·tpf$

##### Memoria virtual  y memoria cache

- Al juntarse, de forma simultanea, se limita el tamaño de la cache a:
  
  - $\#vias\ ·\#conjuntos\ ·\ tamaño\ línea \leq tamaño\ página $

##### Raids y Discos

- Entrelazado:
  
  - Raid 0,1, 4, 5, 6 a nivel de **tira**.
  
  - Raid 2 a nivel de **bit**.
  
  - Raid 3 a nivel de **byte**.

- Redundancia:
  
  - Raid 0: No redundacia.
  
  - Raid 1: 50% redundacia.
  
  - Raid 2: Redundacia a través de Hamming
  
  - Raid 3, 4, 5: **1 Disco** de redundacia (repartido entre todos en el 5)
  
  - Raid 6: **2 Discos** de redundancia repartido entre todos.

- Fallos de disco maximos:
  
  | Raid   | Fallos de disco maximos antes de caida de sistema  |
  |:------:|:--------------------------------------------------:|
  | Raid 0 | 0                                                  |
  | Raid 1 | La mitad si son de mirrors distintos               |
  | Raid 2 | Podrian fallar tantos como discos de paridad hayan |
  | Raid 3 | 1                                                  |
  | Raid 4 | 1                                                  |
  | Raid 5 | 1                                                  |
  | Raid 6 | 2                                                  |

- Velocidad:
  
  | Raid   | Escritura                | Lectura                     |
  |:------:|:------------------------:|:---------------------------:|
  | Raid 0 | Todos los discos sumados | Todos los discos sumados    |
  | Raid 1 | Suma de todos / 2        | Todos los discos sumados    |
  | Raid 2 | -                        | -                           |
  | Raid 3 | -                        | -                           |
  | Raid 4 | Velocidad de 1 disco     | Todos los discos -1 sumados |
  | Raid 5 | Todos los discos sumados | Todos los discos -1 sumados |
  | Raid 6 | Todos los discos sumados | Todos los discos -2 sumados |

- Anual Failure Rate (AFR):
  
  $$
  AFR=\cfrac{\#discos\ ·\ 8760\ horas/disco}{10\ ·\#horas\ fallo}
  $$

- MTTF Raid 0:
  
  $$
  MTTFtotal=\cfrac{MTTFdisco}{N}
  $$

- MTTF Raid 3,4,5, 1 (N = 2):
  
  $$
  MTTF=\cfrac{MTTFdisc^2}{N·(N-1)·MTTR}
  $$

- **RAID XY es RAID X primero y después grupos de raid Y**.

##### Repaso De Formulas Primer Parcial Que Entran En Este Parcial

- $Eficiencia\ energetica=\cfrac{rendimiento}{watio}=\cfrac{1}{t·watio}=\cfrac{1}{energia\ consumida}$

- $MTTF=\cfrac{1}{Tasa\ de\ Fallos}$

- $MTBF=MTTF+MTTR$

- $Availability=\frac{MTTF}{MTTF+MTTR}$

- $Ganancia\ maxima=\cfrac{1}{1-F_m}$
  
  - Donde $F_m$ es la parte no optimizable o fija.
