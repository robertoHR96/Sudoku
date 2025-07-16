
# Sudoku

Este es un proyecto de una aplicación de Sudoku para iOS, desarrollada con SwiftUI.

## Características

*   **Jugar Sudoku:** Inicia y juega partidas de Sudoku.
*   **Niveles de Dificultad:** Elige entre los niveles de dificultad: fácil, medio y difícil.
*   **Continuar Partida:** Guarda y continúa una partida en curso.
*   **Temporizador:** Mide el tiempo que tardas en completar un Sudoku.
*   **Historial:** Deshaz tus movimientos.
*   **Interfaz Intuitiva:** Una interfaz de usuario limpia y fácil de usar.

## Tecnologías

*   **SwiftUI:** Para la interfaz de usuario.
*   **SwiftData:** Para la persistencia de datos.
*   **Xcode:** Como entorno de desarrollo.

## Instalación y Ejecución

1.  Clona el repositorio:
    ```bash
    git clone https://github.com/roberto-hermoso/Sudoku.git
    ```
2.  Abre el proyecto en Xcode:
    ```bash
    cd Sudoku
    open Sudoku.xcodeproj
    ```
3.  Selecciona un simulador de iOS y ejecuta la aplicación.

## Estructura del Proyecto

```
/Users/roberto/Documents/GitHub/Sudoku/
├───.git/...
├───Sudoku/
│   ├───Extensions.swift
│   ├───Item.swift
│   ├───SudokuApp.swift
│   ├───assets/
│   │   ├───SudokuGenerator.swift
│   │   └───SudokuSolver.swift
│   ├───Assets.xcassets/
│   │   ├───Contents.json
│   │   ├───AccentColor.colorset/
│   │   │   └───Contents.json
│   │   └───AppIcon.appiconset/
│   │       ├───1024.png
│   │       ├───114.png
│   │       ├───120.png
│   │       ├───180.png
│   │       ├───29.png
│   │       ├───40.png
│   │       ├───57.png
│   │       ├───58.png
│   │       ├───60.png
│   │       ├───80.png
│   │       ├───87.png
│   │       └───Contents.json
│   ├───model/
│   │   ├───CeldaModel.swift
│   │   ├───History.swift
│   │   ├───PartidaModel.swift
│   │   └───TableModel.swift
│   ├───viewModel/
│   │   ├───PartidasViewModel.swift
│   │   └───TableroViewModel.swift
│   └───views/
│       ├───ContentView.swift
│       ├───Game.swift
│       ├───GameView.swift
│       └───Settings.swift
└───Sudoku.xcodeproj/
    ├───project.pbxproj
    ├───project.xcworkspace/
    │   ├───contents.xcworkspacedata
    │   ├───xcshareddata/
    │   │   └───swiftpm/
    │   │       └───configuration/
    │   └───xcuserdata/
    │       └───roberto.xcuserdatad/
    │           └───IDEFindNavigatorScopes.plist
    └───xcuserdata/
        └───roberto.xcuserdatad/
            ├───xcdebugger/
            │   └───Breakpoints_v2.xcbkptlist
            └───xcschemes/
                └───xcschememanagement.plist
```
