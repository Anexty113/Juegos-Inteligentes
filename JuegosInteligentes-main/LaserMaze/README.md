# Laser Maze

![Contenido del juego Laser Maze](https://img.lakeshorelearning.com/is/image/OCProduction/ga104?wid=800&fmt=jpeg&qlt=85,1&pscan=auto&op_sharpen=0&resMode=sharp2&op_usm=1,0.65,6,0)

## Contenido del juego Laser Maze

- **Niveles:** Mazo de cartas que representan cómo deben organizarse las fichas en el tablero, además de indicarle al jugador la fichas con las que dispone para resolver el nivel.

- **Fichas:**

  - **Emisor (Rojo):** Dispara el láser
  - **Espejo Simple (Azul):** Refleja láser a 90° dependiendo de dónde recibe la luz:
    - **Posición del espejo (/):** arriba → izquierda o izquierda → arriba || abajo → derecha o derecha → abajo
    - **Posición del espejo (`\`):** arriba → derecha o derecha → arriba || abajo → izquierda o izquierda → abajo
  - **Espejo traslúcido (Verde):** divide el láser en dos, 1 se refleja a 90° dependiendo de dónde recibe la luz y permite al 2 continuar:
    - **Posición del espejo (↗):** (arriba → izquierda o izquierda → arriba || abajo → derecha o derecha → abajo) Y el láser continúa su camino original.
    - **Posición del espejo (↖):** arriba → derecha o derecha → arriba || abajo → izquierda o izquierda → abajo Y el láser continúa su camino original.
  - **Espejo Target:** Hace la misma función del espejo simple, pero en unos de sus lados tiene un target que debe ser iluminado si el nivel lo requiere (Este no se utilizará en el juego que estamos haciendo, en cambio utilizaremos una meta simple, o sea, sin espejos)
  - **Target:** Punto final que debe iluminar el láser para completar el juego, en una partida pueden haber varios targets.
  - **Check Point (Amarillo):** No afecta la dirección del láser, el láser debe pasar por dotos los check points para completar el juego.
  - **Obstáculo (Negro):** Impide que se pueda poner una ficha en esa casilla pero el láser sí puede pasar por encima de él sin ser afectado.

- **Tablero:** Mátriz 5x5 en la que ocurre el juego.

## Representación de los estados en código

- Fichas:
  - Emisor: L
  - Esoejo Simple: / (arriba → izquierda, izquierda → arriba, abajo → derecha, derecha → abajo), \ (arriba → derecha, derecha → arriba, abajo → izquierda, izquierda → abajo)
  - Espejo traslúcido: ↗,↖
  - CheckPoint: ↔(el láser debe pasar de izquierda a derecha o de derecha a izquierda),↕(el láser debe pasar de arriba hasta abajo o de abajo hasa arriba)
  - Obstáculo: #
  - Target o meta: m (Si no está iluminada) M (Si está iluminada)
  - Espacio vacío: .
  - Haz de luz: —,| (dependiendo de la dirección), + (si se cruzan), extra: ⇗,⇖

## Ejemplo de partida

- Sin resolver

• &nbsp; &nbsp; • &nbsp; &nbsp; • &nbsp; &nbsp; • &nbsp; &nbsp; •<br>
m &nbsp; • &nbsp; &nbsp; # &nbsp; ↖ &nbsp; &nbsp; •<br>
m &nbsp; • &nbsp; &nbsp; / &nbsp; &nbsp; • &nbsp; &nbsp; •<br>
• &nbsp; &nbsp; L &nbsp; &nbsp; • &nbsp; &nbsp; ↕. &nbsp; •<br>
• &nbsp; &nbsp; • &nbsp; &nbsp; • &nbsp; &nbsp; m &nbsp; •

Debes usar [/,/,↗]

Pulsa D para disparar el láser

- Si pulso D en el estado actual:

• &nbsp; &nbsp; | &nbsp; &nbsp; • &nbsp; &nbsp; • &nbsp; &nbsp; •<br>
m &nbsp; | &nbsp; &nbsp; # &nbsp; ↖ &nbsp; &nbsp; •<br>
m &nbsp; | &nbsp; &nbsp; / &nbsp; &nbsp; • &nbsp; &nbsp; •<br>
• &nbsp; &nbsp; L &nbsp; &nbsp; • &nbsp; &nbsp; ↕. &nbsp; •<br>
• &nbsp; &nbsp; • &nbsp; &nbsp; • &nbsp; &nbsp; m &nbsp; •

Debes usar [/,/,↗]

Pulsa D para parar el láser

## Vamos a resolver este problema paso a paso

- Ponemos un espejo (/) en 0,1:

• &nbsp; &nbsp; / &nbsp; &nbsp; — &nbsp; &nbsp; — &nbsp; &nbsp; —<br>
m &nbsp; | &nbsp; &nbsp; # &nbsp; ↖ &nbsp; &nbsp; •<br>
m &nbsp; | &nbsp; &nbsp; / &nbsp; &nbsp; • &nbsp; &nbsp; •<br>
• &nbsp; &nbsp; L &nbsp; &nbsp; • &nbsp; &nbsp; ↕. &nbsp; •<br>
• &nbsp; &nbsp; • &nbsp; &nbsp; • &nbsp; &nbsp; m &nbsp; •

Debes usar [/,↗]

Pulsa D para parar el láser

- Ponemos un espejo traslúcido (↗) en 0,2 y lo rotamos (↖):

• &nbsp; &nbsp; / &nbsp; &nbsp; ↖ &nbsp; &nbsp; — &nbsp; &nbsp; —<br>
m &nbsp; | &nbsp; &nbsp; # &nbsp; ↖ &nbsp; &nbsp; •<br>
M &nbsp; + &nbsp; &nbsp; / &nbsp; &nbsp; • &nbsp; &nbsp; •<br>
• &nbsp; &nbsp; L &nbsp; &nbsp; • &nbsp; &nbsp; ↕. &nbsp; •<br>
• &nbsp; &nbsp; • &nbsp; &nbsp; • &nbsp; &nbsp; m &nbsp; •

Debes usar [/]

- Ponemos un espejo (/) en 0,2 y lo rotamos (\):

• &nbsp; &nbsp; / &nbsp; &nbsp; ↖ &nbsp; &nbsp; \ &nbsp; &nbsp; •<br>
m &nbsp; | &nbsp; &nbsp; # &nbsp; ↖ &nbsp; &nbsp; —<br>
M &nbsp; + &nbsp; &nbsp; / &nbsp; &nbsp; | &nbsp; &nbsp; •<br>
• &nbsp; &nbsp; L &nbsp; &nbsp; • &nbsp; &nbsp; ↕. &nbsp; •<br>
• &nbsp; &nbsp; • &nbsp; &nbsp; • &nbsp; &nbsp; M &nbsp; •

Debes usar []

- Rotamos (↖) que está en 1,3 a (↗):

• &nbsp; &nbsp; / &nbsp; &nbsp; ↖ &nbsp; &nbsp; \ &nbsp; &nbsp; •<br>
M &nbsp; + &nbsp; &nbsp; # &nbsp; ↗ &nbsp; &nbsp; •<br>
M &nbsp; + &nbsp; &nbsp; / &nbsp; &nbsp; | &nbsp; &nbsp; •<br>
• &nbsp; &nbsp; L &nbsp; &nbsp; • &nbsp; &nbsp; ↕. &nbsp; •<br>
• &nbsp; &nbsp; • &nbsp; &nbsp; • &nbsp; &nbsp; M &nbsp; •

Debes usar []

Así quedaría resuelto
