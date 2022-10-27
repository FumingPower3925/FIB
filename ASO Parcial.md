# 1. Itroducció a la administració de SO

## 1.1. Tasques d'Administrador de Sistema

    - Comprovar la seguretat del sistema
    - Realitzar còpies de seguretat regularment
    - Resoldre els problemes puntuals
    - Ajudar als usuaris amb la seva feina diaria (relacionada amb el sistema)
    - Crear/Mantenir una bona documentació local
    - Instal·lar i gestionar software
    - Gestionar els usuaris
    - Afegir/Actualitzar/Mantenir el hardware
    - Monitorejar el sistema i comprovar que funciona correctament

## 1.2. Codi Ètic d'Administrador de Sistema

1. **Seriositat**: Mantenir separats els aspectes personals dels professionals.
2. **Integritat**: Ser capaç d'adonar-se'n de les seves limitacions i errors.
3. **Privacitat**: 
   - Mantenir la confidencialitat de les dades dels altres.
   - Accedir a la informació privilegiada només quan sigui absolutament necessari.
4. **Lleis i termes d'ús**: Mantenir-se al dia en termes de normes ètiques i compartir-ho
   - Codi criminal
   - LOPD
   - LSSI
5. **Comunicació**: Proporcionar, de forma habitual, informació rellevant als usuaris.
6. **Responsabilitat ètica**: Professionalitat, coherència, integritat, honradesa.

> No entra al Paricial

### 1.2.1. LOPD

- Determina com s'han de tractar les fitxers de dades i quines mesures cal aplicar.
- La companyia ha d'informar a la Agència de Protecció de Dades dels fitxers.
- Les mesures adoptades han d'estar explicitades en documents.
- Els contractes dels treballadors també han de complir la LOPD.

# 2. Instal·lació d'un Sistema Operatiu

## 2.1. Introducció: Objectiu

L'objectiu de tot administrador de sistemes es mantenir els equips el màxim temps possible en el estat Configurat.

>  No entra gaire

### 2.1.1. Estats d'un equip

- **Nou**: Nou equip.
- **Net**: Equip amb el SO instal·lat pero sense cap tasca de manteniment.
- **Configurat**: Equips configurats en funció dels requisits.
- **Desconegut**: Equips no configurats o vells.
- **Fora de servei**: Equips descartats degut a la seva antiguetat o a un fallo del hardware.

>  No entra gaire

### 2.1.2. Transicions d'un equip

- **Instal·lació**: Instal·lació d'un SO.
- **Inicialitzaió**: Canvis inicials per tenir el equip preparat per l'entorn de treball.
- **Actualització**: Insertar noves funcionalitats, aplicar parches de seguretat.
- **Entropia**: Degradació gradual dels equips fins a deixarlos en estat desconegut.
- **Arreglar**: Arreglar un equip per tornar al estat configurat.
- **Reinstal·lar**: Acualització massiva del SO forçada per un atac o error de configuració.
- **Retirada**: Retirada definitiva del equip.

## 2.2. Particionat de discs

### 2.2.1. Motivació del particionat de discs

1. Cada partició es troba completament aïllada de la resta proporcionant mes seguretat.
2. Les còpies de segueretat es poden gestionar a nivell de partició i ser diferents depenent de la necessitat d'aquella partició.

### 2.2.2. Master Boot Record (MBR)

- Sistema en desús.
- Fins a 4 particions primaries (o 3 primaries i una extesa).
- **Partició primaria**: es una partició que pot contenir un sistema de fitxers. Formada per:
  - Boot Sector + Area de dades
- **Partició extesa**: Partició que pot contenir unicament particions lògiques. Formada per:
  - Extended Boot Sector + X * (Partició lògica)
- **Partició lògica**: es ua partició que pot contenir un sistema de fitxers. Formada per:
  - Boot Sector + Area de dades

### 2.2.3. GUID Partition Table (GPT)

- Fins a 128 particions amb el tamany estàndard de GPT.
- Totes les particions passen a ser les mateixes, ja que, ara son identificades per el UUID.

## 2.3. Sistema de fitxers en UNIX

Els directoris que han de ser muntats obligatoriament es perque es requereixen durant el boot del sistema, abans d'haver muntat res.

- **/bin i /sbin**: Executables necessaris durant l'arranc del sistema. Ex: ls, cat...
- **/usr/bin i /usr/sbin**: Aplicacions del sistema operatiu. Ex: man, adduser...
- **/usr/local/bin i /usr/local/sbin o (/opt)**: Applicacions específiques, normalment privatives...
- **$HOME/bin**: Applicacions del usuari
- **/var**: Contingut dinamic: Mails, logs, pids, informació del usuari final...

### 2.3.1. Comandes Linux relacionades

| Nom         | Resum Comanda                                                            |
|:----------- | ------------------------------------------------------------------------ |
| `$ mkfs`    | Serveix per a **crear el sistema de fitxers** (MaKe FileSystem)          |
| `$ fsck`    | Serveix per **comprovar i arreglar** el Filesystem (FileSystem ChecK)    |
| `$ mkswap`  | Serveix per convertir una partició en partició **Swap** (MaKe SWAP)      |
| `$ fdisk`   | Serveix per **particionar i formatejar** el disc (Format DISK)           |
| `$ mount`   | Serveix per a **muntar** un disc en un directori (MOUNT)                 |
| `$ umount`  | Serveix per **desmuntar** un o mes discos                                |
| `$ tune2fs` | Serveix per a **tunejar** el Filesystem ext(2,3,4) (Tune to  Filesystem) |
| `$ chage`   | Serveix per **gestionar la caducitat** de les contrasenyes.              |

> Per la comanda `$ mount` es important coneixer els flags:
> 
> - `$ mount -a`: **Monta tots** els sistemes de fitxers que es trobin a **/etc/fstab**
> 
> - `$ mount -o ro`: **Monta** una partició com a **Read Only** (només lectura)
> 
> - `$ mount -o remount`: **Desmonta** i torna a **montar** una partició
> 
> Per la comanda `$ umount` es important coneixer el flag:
> 
> - `$ umount -a`: Desmonta tots els dispositius montats (i pugin desmontar)

## 2.4. Inicialització del sistema

### 2.4.1. Passos d'inicialització

1. **ROM**: Inicialitzacions hardware

2. **Kernel**:
   
   - Detecció de hardware
   
   - Configuracions de Kernel

3. **Initrd**: Configuracions de dispositius

4. **Init**: Configuracions d'espai d'usuari

### 2.4.2. System-V (En desús)

- **Basat en scripts**: Facilment modificable tot i que **mes lent**.

- **Sequencial**: No explotava les capacitas de paralelització de codi.

### 2.4.3. Systemd

- **Exclusiu**: Us exclusiu en Linux

- **Compilat**: No tant facil de modificar tot i que **mes ràpid**.

- **Paralelitzable**: Basat en dependencies i paralelitzable.

- **Alt control del serveis**: Els serveis disposen d'una rica selecció de possibles estats.

#### 2.4.3.1. Systemctl: Control de serveis

| Comanda                                  | Descripció                             |
| ---------------------------------------- | -------------------------------------- |
| `$ systemctl`                            | Llista tots els serveis i estats       |
| `$ systemctl [start\|stop\|restart] <s>` | [inicia\|atura\|reinicia] El servei    |
| `$ systemctl reload <s>`                 | Rellegeix la configuració sense parar  |
| `$ systemctl [enable\|disable] <s>`      | [activa\|desactiva] el servei en boot  |
| `$ systemctl status <s>`                 | Retorna el estat del servei            |
| `$ systemctl [mask\|umask] <s>`          | [masks\|unmasks] els serveis           |
| `$ systemctl daemon-reload`              | **Auto-recarga systemctl sense parar** |

> <s>: Es el nom del servei en questió

> Exemples: `$ systemctl reboot`, `$ systemctl poweroff`

# 3. Gestió d'usuaris

### 3.1. Bases de Dades del sistema

- **/etc/passwd**: Hi han **noms**, **shells** i **main group** dels usuaris. (No paswords)
  
  - **root**: **UID 0**, maxims privilegis
  
  - **Usuaris de sistema**: S'utilitzen per a correr serveis sense privilegis, **no disposen de shell ni password**. Exemples:
    
    - ftp, www-data...

- **/etc/group**: Un grup pot tenir molts usuaris, cada usuari te el seu grup principal. Serveixen per a gestionar els permisos de conjunts d'usuaris. Grups especials:
  
  - **sudo/wheel**: Grup amb permisos d'administrador
  
  - **nobody**: Utilitzat per a reduir els privilegis
  
  - **users**: Normalment tots els usuaris hi pertanyen
  
  - **disk**: Permet als usuaris gestionar els discs.

- **/etc/shadow**: Conté les passwords encrpitades dels usuaris i la data d'expiració.
  
  - Els usuaris sense cntrasenya en comptes d'un hash tenen un 0.

- **/etc/aliases**: Conté els alias d'email.

## 3.2. Comandes linux relacionades

### 3.2.1. Gestió d'usuaris

| Comanda              | Descripció                                                   |
| -------------------- | ------------------------------------------------------------ |
| `useradd <usuari>`   | Afegeix el usuari al sistema                                 |
| `userdel <usuari>`   | Esborra el usuari del sistema                                |
| `usermod <usuari>`   | Modifica tots els camps d'un usuari excepte el username      |
| `passwd [<usuari>]`  | Modifica el password del usuari, el teu si es deixa en blanc |
| `newusers <usuaris>` | Afegeix una llista d'usuaris, pot ser un fitxer              |
| `vipw`               | Obre amb l'editor 'vi' el arxiu /etc/passwd                  |

### 3.2.2. Gestió de grups

| Comanda            | Descripció                                         |
| ------------------ | -------------------------------------------------- |
| `groupadd <group>` | Crea el grup                                       |
| `groupdel <group>` | Esborra el grup del sistema                        |
| `groupmod <group>` | Modifica tots els camps d'un grup                  |
| `newgrp <group>`   | Canvia el grup principal del usuari que ho executa |
| `vigr`             | Obre amb l'editor vi el arxiu /etc/group           |

## 3.3. Desabilitar usuari

Serveix per impedir l'accés al sistema per part de l'usuari pero sense esborrarlo.

- **Invalidació de password**:
  
  - Insertar un caracter invalid en el passw, * o !
  
  - Permet recuperar el password del usuari si fes falta

- **Invalidació de la shell**:
  
  - Canviar la shell del usuari per /bin/false o /bin/nologin en el fitxer passwd
  
  - Informa al usuari que ha estat desabilitat
  
  - Informa al administrador si el usuari intenta accedir

## 3.4. Esborrar usuari

Només si estem segurs que la seva compta ja no sera necessaria:

1. Desabilitar el compte (Invalidació de password i/o de shell)

2. Comprovar si el usuari no esta treballant en el sistema (expulsarlo si ho esta)

3. Fer backup de les dades del usuari

4. Esborrar les dades del usuari

5. Esborrar l'usuari de les bases de dades del sistema:
   
   - /etc/shadow
   
   - /etc/passwd
   
   - /etc/group

6. Afegir redirecció de mail

## 3.5. Escalat de privilegis

| Comanda                     | Descripció                                      |
| --------------------------- | ----------------------------------------------- |
| `$ setuid <file/directori>` | Permet afegir el bit de suid al arxiu/directori |
| `$ setgid <file/directori>` | Permet afegir el bit de sgid al arxiu/directori |
| `$ su <username>`           | Permet canviar a root                           |
| `$ sudo <command>`          | Permet executar una comanda com a root          |

## 3.6. Permisos i proteccions

| Directori o Fitxer | User     | Group    | Other    | Owner    | Group     |
| ------------------ | -------- | -------- | -------- | -------- | --------- |
| (-\|d)             | rw(x\|s) | rw(x\|s) | rw(x\|t) | username | groupname |

> r: Permis d'escriptura
> 
> w: Permis de lectura
> 
> x: Permis d'execucció
> 
> "user" s: suid Permet la execució amb els permisos del owner
> 
> "group" s:: sgid
> 
> - Directori: Els arxius creats tindran el mateix grup que el owner del directori
> 
> - Arxiu: Permet la execució amb els permisos del grup del owner
> 
> t (Sticky Bit): Només el owner pot esborrar fitxers d'aquell directori

### 3.6.1. Comandes linux relacionades

| Comanda                           | Descripció                                  |
| --------------------------------- | ------------------------------------------- |
| `$ chown <usr> <file/directory>`  | Permet canviar el owner del arxiu/directori |
| `$ chgrp <grup> <file/directory>` | Permet canviar el grup del arxiu/directori  |
| `$ chmod [perm] <file/directory>` | Permet canviar els permisos                 |
| `$ umask [umask]`                 | Canviar/consultar la umask de permisos      |

> usr: Usuari que volem que tingui el arxiu/directori
> 
> grup: Grup que volem que tingui el arxiu/directori
> 
> perm: Pot ser introduit en forma (rwx) o en forma octal (0755)
> 
> Els permisos de la umask son els permisos per defecte de arxiu o directori

# 4. Gestió d'aplicacions

## 4.1. Instal·lació d'aplicacions

### 4.1.1. Instal·lació manual

1. Seleccionar directori destí de la instal·lació

2. Crear els subdirectoris de:
   
   - **Executable**: `$PREFIX/bin`
   
   - **Llibreries**: `$PREFIX/lib` i `$PREFIX/lib64`
   
   - **Fitxers de suport**: `$PREFIX/share`
   
   - **Fitxers de configuració**: `/etc`
   
   - **Fitxers de log**: `/var/log`
   
   - **Documentació**: `$PREFIX/share/doc`

3. Distribuïr els fitxers de la aplicació

4. Inicialitzar la configuració de la aplicació

### 4.1.2. Instal·lació automatica

- Automatitzar els passos anteriors

- Procediment d'instalació generic

- Proporciona les configuracions generiques

## 4.2. Desplegament de Software

> No es gaire important

### 4.2.1. Desde codi font

1. Descomprimir el paquet en un directori separat

2. Llegir la documentació (README, INSTALL)

3. Instalar les dependéncies

4. Ajustar el codi a les particularitats del sistema

5. Compilar

6. Instalar

7. Configuració base

### 4.2.2. Desde binaris  auto-instalables

- S'ajusten a la aplicació

- El sistema ha de soportar la applicació

- Ho implementa la mateixa companyia que fa el software

- Normalment son projectes privatius

### 4.2.3. Desde binaris precompilats

- Instalació adequada per a tota la distribució

- Creat per la mateixa distribució

- Capacitats limitades modificables

- Auto-instal·lació de prerequisits (els definits per el mantenidor del paquet)

## 4.3. Localització i execució de la aplicació

- Instalar al seu propi directori i incluir-lo al `$PATH`, problema:
  
  - **El path pot arribar a ser molt llarg per a treballar**

- Instalar tot al mateix directori, problema:
  
  - **Falta d'organització i possible col·lisió de noms**

- Combinació de les dues opcions:
  
  - Cada aplicació al seu propi directori i crear soft links en un directori comú.

## 4.4. Mantniment de versions

- Instalar les applicacions en **directoris diferents**

- Mantenir un soft-link a la versió mes utilitzada i canviar el nom del anterior

- Afegir les versions especifiques requerides al path del usuari en concret.

# 5. Monitorització del sistema

## 5.1. Top

| Camp      | Descripció                                                       |
| --------- | ---------------------------------------------------------------- |
| VIRT (kb) | Memòria virtual assignada a un procés                            |
| RES (kb)  | Memòria física no swapejada utilitzada per el procés             |
| SHR (kb)  | Memòria compartida utilitzada per el procés                      |
| **ni**    | Nice time, temps d'execució de processos que han sigut niced     |
| **us**    | User CPU time, temps que la cpu ha estat executant codi d'usuari |
| **sy**    | Temps que ha estat el sistema executant codi                     |
| **id**    | Temps que la CPU ha estat idle (Rescant-se la panxa)             |
| **wa**    | temps que la CPU ha estat esperant (Waiting) per I/O             |
| **hi**    | temps que la CPU ha estat servint interrupcions hardware         |
| **si**    | temps que la CPU ha estat servint interrupcions sofware          |
| **st**    | temps que la CPU ha estat "stolen" per una maquina virtual       |

## 5.2. Gestió de processos

### 5.2.1. Canvi de prioritat

| Comanda                | Descripció                                             |
| ---------------------- | ------------------------------------------------------ |
| `$ nice +10 <command>` | Aumentar la prioritat abans de començar la execució    |
| `$ renice +10 <pid>`   | Aumentar la prioritat quan un process ja esta arrancat |

> Només root pot canviar **aumentar** les prioritats

### 5.2.2. Enviar signals a un process

| Comanda                  | Descripció                                             |
| ------------------------ | ------------------------------------------------------ |
| `kill -KILL <pid>`       | Atura el process de forma inmediata                    |
| `kill -TERM <pid>`       | Demana amablement al procés que es mori                |
| `kill -INT <pid>`        | Interromp el procés                                    |
| `kill -STOP <pid>`       | Atura el procés                                        |
| `kill -CONT <pid>`       | Reactiva el procés                                     |
| `killall <signal> <nom>` | Envia el signal a **tots** els procesos amb aquell nom |

## 5.3. Monotorització d'usuaris

### 5.3.1. Control activitat d'usuaris

| Comanda           | Descripció                                                  |
| ----------------- | ----------------------------------------------------------- |
| `w [usuari]`      | Usuaris conectats  si s'introdueix usuari, llista conexions |
| `last [usuari]`   | Llista les ultimes conexions de tots o del usuari           |
| `finger [usuari]` | Llista totes les sesions que pertanyen a un usuari          |

### 5.3.2. Control de fitxers d'usuaris

| Comanda                      | Descripció                                        |
| ---------------------------- | ------------------------------------------------- |
| `fuser <filename>`           | Identifica els processos utilitzats per un fitxer |
| `lsof [filename\|direcrori]` | Llista els fitxers oberts                         |

## 5.4. Activitat de Disc

| Comanda                    | Descripció                                  |
| -------------------------- | ------------------------------------------- |
| `du [filename\|directori]` | Indica el espai utilitzat per directori     |
| `df [filename\|directori]` | Indica el espai lliure en cada partició     |
| `vmstat`                   | Informa del estat de la memoria virtual     |
| `iostat`                   | Informa de les operacions de i/o dels discs |

# 6. Manteniment sistema de fitxers

## 6.1 Tipus filesystems

| Nom          | Descripció                                                             |
|:------------:| ---------------------------------------------------------------------- |
| FAT (FAT16)  | **Discs petits (<4GB)** noms de 8+3 caracters                          |
| FAT32 (VFAT) | Discs mes grans, noms llargs, **no owner ni privilegis** incorporats   |
| **exFAT**    | Extensió de FAT32, discs de fins 512 TiB                               |
| **NTFS**     | **Integra ownership i privilegis**, s'ajusta a la seguretat de windows |
| ext2         | UNIX, soft i hard links, privilegis i noms de fitxer llargs            |
| ext3         | Afegeix **journaling**                                                 |
| reiserfs     | Fitxers i directoris com a base de dades, eficent amb axius petits     |
| **xfs**      | Journaling, inodes dinamics, ACLs, log d'activitat... Tipic en servers |
| jfs          | Journaling, inodes dinamics, acls i MAC, capacitats molt grans         |
| **ext4**     | Millores en Journaling, Extents, **Alocació retardada**                |
| **btrfs**    | Extents, **Online resizing, online balancing, online fs check**        |

> Journal: Un journal facilita la recuperació de sistema de fitxers en cas d'error, decrementa lleugerament el rendiment de les operacions a disk.
> 
> FAT32: Disposa d'un sistema d'ocultació d'arxius i permisos de nomes lectura

## 6.2. Verificació de discs

- Per recuperar la informació es pot recurrir al directori lost+found

- Per comprovar els sectors en mal estat s'utilitza **badblocks**

- **MAI** verificar un sistema de fitxers mentre esta montat (a no ser que ho incorpori)

### 6.2.1. Quota de discs

| Comanda        | Descripció                                                  |
| -------------- | ----------------------------------------------------------- |
| `$ quotacheck` | Comanda per a crear fitxers de quota                        |
| `$ quotaon`    | Comanda per activar mecanismes de quota                     |
| `$ quotaoff`   | Comanda per desabilitar mecanismes de quota                 |
| `$ edquota`    | Comanda per a modificar el fitxer de quota (canviar limits) |
| `$ quota -v`   | Visualitzar les quotes                                      |

> Grace period: El temps de gracia es un periode en el que els usuaris poden arrivar a disposar del maxim del hardware.

## 6.3. Gestió de volums lògics (LVM)

- Alt nivell d'abstacció del espai de disc

- Aggrega multiples particions/discs

- Permet resizing i moure discs/particions

## 6.4. Backups

### 6.4.1. Tipus backup

#### 6.4.1.1. Full Backup

- Sempre copia **TOTES** les dades

- Facil de restaurar

- Molt espai ocupat (x vegades el espai originol on x es el nombre de backups)

#### 6.4.1.2. Incremental Backup

##### Pros:

- Petits en espai ocupat

- Poden ser realitzats en qualsevol medi

##### Inconvenients:

- Mes lent de restaurar

- El primer backup es igual a un full backup

##### A tenir en compte:

- No crear sequencies de backup llarges

#### 6.4.1.3. Reverse Incremental Backup

##### Pros:

- Ràpid de restaurar

- Ocupa poc espai

##### Inconvenients:

- Nomes possible en dispositius d'acces aleatori (NO Cintes)

### 6.4.2. Suport físic

| Nom    | Descripció                                                                  |
| ------ | --------------------------------------------------------------------------- |
| Floppy | No facis una copia en floppis deu meu xd                                    |
| CD     | No facis una copia en CD's deu meu xd                                       |
| Disc   | Acces aleatori, mota disponibilitat de les dades i usabilitat, bastant cost |
| Tape   | Acces **sequencial**, poca disponibilitat de les dades, cost molt baix      |
