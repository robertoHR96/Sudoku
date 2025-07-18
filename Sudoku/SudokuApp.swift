//
//  SudokuApp.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//

import SwiftUI
import SwiftData

/// Punto de entrada principal de la aplicación Sudoku.
/// Configura el contenedor de datos compartido (ModelContainer) para SwiftData y la escena principal.
@main
struct SudokuApp: App {
    
    /// Contenedor compartido que maneja el modelo de datos persistente para la app.
    /// Configurado con el esquema que contiene la entidad `Item`.
    var sharedModelContainer: ModelContainer = {
        // Define el esquema con las entidades que se van a usar en la base de datos
        let schema = Schema([
            Item.self,
        ])
        
        // Configura el contenedor para que no sea solo en memoria (persistencia en disco)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            // Intenta crear el contenedor con la configuración definida
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            // Si falla la creación del contenedor, termina la app con un error
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
   
    @StateObject var localizationManager = LocalizationManager()
   
    /// Definición de la interfaz principal de la aplicación.
    /// Se muestra `ContentView` dentro de una ventana, y se pasa el contenedor de datos al entorno.
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(localizationManager)
        }
        // Asocia el contenedor de modelo al entorno para que las vistas puedan acceder a los datos
        .modelContainer(sharedModelContainer)
    }
}
