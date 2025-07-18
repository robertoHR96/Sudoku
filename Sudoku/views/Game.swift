//
//  Game.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//

import SwiftUI

/// Vista principal para la sección del juego.
/// Muestra opciones para continuar una partida o empezar una nueva.
struct Game: View {
    @EnvironmentObject var tableroViewModel: TableroViewModel
    @EnvironmentObject var localizationManager: LocalizationManager
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 42) {
                ContinuarPartida()  // Opción para continuar una partida existente
                NuevaPartida()      // Opción para iniciar una nueva partida
            }
            .padding()
        }
    }
}

#Preview {
    Game()
        .environmentObject(TableroViewModel())
        .environmentObject(LocalizationManager())
}

/// Vista para continuar la partida si ya está iniciada.
struct ContinuarPartida: View {
    @EnvironmentObject var tableroViewModel: TableroViewModel
    @EnvironmentObject var localizationManager: LocalizationManager
    
    var body: some View {
        // Solo mostrar si el tablero está iniciado
        if tableroViewModel.getInitTablero() {
            VStack {
                Text("Continue your game !!".localized(for: localizationManager.language))
                    .font(.system(size: 30))
                    .bold()
                
                NavigationLink(destination: GameView()
                    .environmentObject(tableroViewModel)
                    .onAppear {
                        tableroViewModel.startTimer()  // Inicia el timer al entrar al juego
                    }
                ) {
                    Text("Continue game".localized(for: localizationManager.language))
                        .bold()
                        .font(.system(size: 20))
                        .frame(width: 250, height: 20)
                        .padding()
                        .background(Color(hex: "#0094D9"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

/// Vista para crear una nueva partida, con selección de dificultad.
struct NuevaPartida: View {
    @EnvironmentObject var tableroViewModel: TableroViewModel
    @EnvironmentObject var localizationManager: LocalizationManager
    
    var body: some View {
        VStack {
            Text("New Game".localized(for: localizationManager.language))
                .font(.system(size: 30))
                .bold()
            
            // Botones para seleccionar dificultad
            ForEach(["Easy".localized(for: localizationManager.language), "Medium".localized(for: localizationManager.language), "Hard".localized(for: localizationManager.language)], id: \.self) { nivel in
                NavigationLink(destination: GameView()
                    .environmentObject(tableroViewModel)
                    .onAppear {
                        tableroViewModel.modDificultad(dificultad: nivel)
                        tableroViewModel.initTableroDesdeGenerador()
                        tableroViewModel.startTimer()
                    }
                ) {
                    Text(nivel.capitalizedFirstLetter().localized(for: localizationManager.language))
                        .bold()
                        .font(.system(size: 20))
                        .frame(width: 250, height: 20)
                        .padding()
                        .background(Color(hex: "#0094D9"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}
