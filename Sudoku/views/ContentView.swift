//
//  ContentView.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//

import SwiftUI
import SwiftData

/// Vista principal que contiene la navegación en pestañas para el juego y ajustes.
struct ContentView: View {
    /// ViewModel principal del tablero, gestionando estado y lógica del Sudoku.
    @StateObject var tableroViewModel = TableroViewModel()
    @EnvironmentObject var localizationManager: LocalizationManager
    
    var body: some View {
        TabView {
            // Pestaña principal del juego
            Game()
                .tabItem {
                    Image(systemName: "house")   // Icono de casa para la pestaña "Game"
                    Text("Game".localized(for: localizationManager.language))                 // Etiqueta de la pestaña
                }
                .environmentObject(tableroViewModel) // Proporciona acceso al ViewModel
            
            // Pestaña de configuración / ajustes
            Settings()
                .tabItem {
                    Image(systemName: "gear")    // Icono de engranaje para la pestaña "Ajustes"
                    Text("Settings".localized(for: localizationManager.language))              // Etiqueta de la pestaña
                }
                .environmentObject(tableroViewModel) // También recibe el ViewModel
        }
        // Color de acento personalizado para los elementos seleccionados del TabView
        .accentColor(Color(hex: "#0094D9"))
        
        // Observa cuando la app pasa a segundo plano o pierde foco para detener el timer
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            tableroViewModel.stopTimer()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LocalizationManager())
}
