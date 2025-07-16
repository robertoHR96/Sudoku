# Sudoku

Este es un proyecto de una aplicación de Sudoku para iOS, desarrollada con SwiftUI. La aplicación permite a los usuarios jugar Sudokus, elegir diferentes niveles de dificultad, y guardar su progreso.

## Características

*   **Jugar Sudoku:** Inicia y juega partidas de Sudoku con una interfaz limpia e intuitiva.
*   **Niveles de Dificultad:** Elige entre tres niveles de dificultad: fácil, medio y difícil. Cada nivel ajusta el número de pistas iniciales.
*   **Continuar Partida:** La aplicación guarda automáticamente el estado de la partida en curso, permitiéndote continuar donde la dejaste.
*   **Temporizador:** Un temporizador integrado mide el tiempo que tardas en completar cada Sudoku, añadiendo un desafío extra.
*   **Historial de Movimientos:** ¿Te equivocaste? No hay problema. Puedes deshacer tus movimientos uno por uno.
*   **Validación de Celdas:** Las celdas con números incorrectos se marcan en rojo para ayudarte a identificar errores.
*   **Interfaz Intuitiva:** La interfaz de usuario está diseñada para ser fácil de usar, con controles claros y una presentación visual agradable.

## Tecnologías

*   **SwiftUI:** El framework de Apple para construir interfaces de usuario en todas las plataformas de Apple. SwiftUI se utiliza para crear todas las vistas de la aplicación.
*   **SwiftData:** Un framework de persistencia de datos que permite guardar y gestionar los datos de la aplicación de forma sencilla y eficiente.
*   **Xcode:** El entorno de desarrollo integrado (IDE) de Apple, utilizado para desarrollar, probar y depurar la aplicación.

## Instalación y Ejecución

Para ejecutar este proyecto en tu propio dispositivo o simulador, sigue estos pasos:

1.  **Clona el repositorio:**
    ```bash
    git clone https://github.com/roberto-hermoso/Sudoku.git
    ```
2.  **Abre el proyecto en Xcode:**
    ```bash
    cd Sudoku
    open Sudoku.xcodeproj
    ```
3.  **Ejecuta la aplicación:**
    *   Selecciona un simulador de iOS (por ejemplo, iPhone 15 Pro) desde el menú de destino en la barra de herramientas de Xcode.
    *   Haz clic en el botón de "Run" (el icono de triángulo) o presiona `Cmd + R` para compilar y ejecutar la aplicación en el simulador.

## Estructura del Proyecto

El proyecto está organizado en las siguientes carpetas y archivos principales:

```
/Users/roberto/Documents/GitHub/Sudoku/
├───Sudoku/
│   ├───Extensions.swift       # Extensiones de utilidades para el código.
│   ├───Item.swift             # Modelo de datos (posiblemente para SwiftData).
│   ├───SudokuApp.swift        # El punto de entrada principal de la aplicación.
│   ├───assets/                # Recursos como generadores o solucionadores de Sudoku.
│   │   ├───SudokuGenerator.swift
│   │   └───SudokuSolver.swift
│   ├───Assets.xcassets/       # Catálogo de activos para imágenes, colores, etc.
│   ├───model/                 # Modelos de datos que representan la lógica del negocio.
│   │   ├───CeldaModel.swift   # Modelo para una celda individual del tablero.
│   │   ├───History.swift      # Modelo para registrar un movimiento en el historial.
│   │   ├───PartidaModel.swift # Modelo para una partida de Sudoku.
│   │   └───TableModel.swift   # Modelo para el tablero de Sudoku completo.
│   ├───viewModel/             # ViewModels que conectan los modelos con las vistas.
│   │   ├───PartidasViewModel.swift # ViewModel para gestionar las partidas guardadas.
│   │   └───TableroViewModel.swift  # ViewModel para la lógica del tablero de juego.
│   └───views/                 # Vistas de SwiftUI que componen la interfaz de usuario.
│       ├───ContentView.swift  # La vista principal que contiene la navegación.
│       ├───Game.swift         # La vista para iniciar o continuar una partida.
│       ├───GameView.swift     # La vista principal del juego, incluyendo el tablero y los controles.
│       └───Settings.swift     # La vista de configuración de la aplicación.
└───Sudoku.xcodeproj/          # El archivo de proyecto de Xcode.
```

### Arquitectura

El proyecto sigue una arquitectura MVVM (Model-View-ViewModel), que separa la interfaz de usuario (View) de la lógica de negocio (Model) a través de un intermediario (ViewModel). Esto facilita la mantenibilidad y la prueba del código.

*   **Model:** Contiene los datos y la lógica de negocio de la aplicación. En este caso, `TableModel`, `CeldaModel`, `PartidaModel`, y `History` definen la estructura de un Sudoku.
*   **View:** La capa de presentación, escrita en SwiftUI. Las vistas observan los cambios en los ViewModels y se actualizan automáticamente.
*   **ViewModel:** Actúa como un puente entre el Modelo y la Vista. `TableroViewModel` gestiona el estado del tablero de juego, mientras que `PartidasViewModel` se encarga de las partidas guardadas.