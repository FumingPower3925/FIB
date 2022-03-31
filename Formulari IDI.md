# Formulari IDI Parcial

## 1. Transformaciones geométricas

#### Translaciones

> TG = Translate(tx, ty, tz);

    **tx** posición eje x (int);    **ty** posición eje y (int);    **tz** posición eje z (int);

#### Rotaciones

> TG = Rotate(anguloRot, (eje_rot));

    **anguloRot** ángulo de rotación (float);    **eje_rot** eje al que aplicar la rotación (vec3);

#### Escalado

> TG = Scale(sx, sy, sz);

    **sx** escalar eje x (int);    **sy** escalar eje y (int);    **sz** escalar eje z (int);

## 2. Cámara

#### LookAt

> VM = lookat(OBS, VRP, up);

    **OBS** punto cámara (vec3);    **VRP** punto objetivo (vec3);    **up** vector orientación (vec3);

#### Cámara perspectiva

> PM = perspective(FOV, raw, zN, zF);

    **FOV** grado apertura cámara $FOV=2·α=2·arcsin(a/b)$

    **raw** relación de aspecto $ra = a / h$

    **zNear** distancia entre OBS y la escena (punto mas cercano a OBS)

    **zFar** distancia entre OBS y el final de la escena (punto más lejano a OBS)

#### Cámara ortogonal

> PM = ortho(l, r, b, t, zN, zF);

    **l** left x coord (int);    **r** right x coord (int);    **b** bottom y coord (int);    **t** top y coord (int);

    **zNear** distancia entre OBS y la escena (punto mas cercano a OBS)

    **zFar** distancia entre OBS y el final de la escena (punto más lejano a OBS)

#### Redimensionado de ventana

##### Perspectiva

    **rav > 1** aumentar aw;    **rav < 1** $raw = aw/hw$    $hw=2·Znear·tan(α)$

##### Ortogonal

    **rav > 1:**

        **·** $I = -rav · R$;    $r=rav·R$;    $b=-R$ ;    $t = R$;

    **rav < 1:**

        **·** $I=-R$;    $r=R$;    $b=-R/rav$;    $t=R/rav$;

#### Zoom

> ¡Siempre manteniendo el rav!

##### Óptica perspectiva

        - Modificiar: **FOV**, **zNear**, **zFar**, **OBS** y **VRP**

##### Óptica ortogonal

        - Modificar: **Window**

#### Cámara en 3a persona

1. Encontrar max y min caja contenedora.

2. Definir centro de la caja (**VRP**)

3. Calcular el **radio** de la escena

4. Definir **distancia** entre OBS y VRP ($d=2·R$)

5. Definir **OBS** con $OBS=VRP+d*v$ 

6. Definir el parámetro **up**

7. Definir **tipo de óptica**

8. Definir **zNear** y **zFar** (0 < zNear <= d-R) y (zFar >= d+R)

9. Definir $raw=1$

10. Definir **parámetros de la óptica**:
    
    1. Si **perspectiva**
    
    2. Si **ortogonal**

## 3. Colores

  ![](C:\Users\Albert\AppData\Roaming\marktext\images\2022-03-31-00-55-59-image.png)![](C:\Users\Albert\AppData\Roaming\marktext\images\2022-03-31-00-56-20-image.png) 

                                    RGB                                                                CMY

**RGB -> CMY**

$C=1-R$;    $M=1-G$;    $Y=1-B$;

**CMY -> RGB**

$R=1-C$;    $G=1-M$;    $B=1-Y$;

**HSV -> RGB**

$0<=H<=360$;    $0<=S<=1$;    $0<=V<=1$;

$C=V·S$;    $X=C·(1-|(H/60) mod 2 -1|)$;    $m=V-C$;

![](C:\Users\Albert\AppData\Roaming\marktext\images\2022-03-31-01-15-01-image.png)

$(R, G, B)=((R'+m)·255, (G'+m)·255, (B'+m)·255)$

**RGB -> HSV**

$𝑅' = 𝑅/255;    𝐺' = 𝐺/255;    𝐵' = 𝐵/255;$

$Cmax = max(R', G', B');    Cmin=min(R',G',B');    ∆=Cmax-Cmin$;

![](C:\Users\Albert\AppData\Roaming\marktext\images\2022-03-31-01-53-02-image.png)


