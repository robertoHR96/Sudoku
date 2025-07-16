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
}

/// Vista para continuar la partida si ya está iniciada.
struct ContinuarPartida: View {
    @EnvironmentObject var tableroViewModel: TableroViewModel
    
    var body: some View {
        // Solo mostrar si el tablero está iniciado
        if tableroViewModel.getInitTablero() {
            VStack {
                Text("Sigue con tu partida !!")
                    .font(.system(size: 30))
                    .bold()
                
                NavigationLink(destination: GameView()
                    .environmentObject(tableroViewModel)
                    .onAppear {
                        tableroViewModel.startTimer()  // Inicia el timer al entrar al juego
                    }
                ) {
                    Text("Continuar partida")
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
    
    var body: some View {
        VStack {
            Text("Nueva Partida")
                .font(.system(size: 30))
                .bold()
            
            // Botones para seleccionar dificultad
            ForEach(["facil", "medio", "dificil"], id: \.self) { nivel in
                NavigationLink(destination: GameView()
                    .environmentObject(tableroViewModel)
                    .onAppear {
                        tableroViewModel.modDificultad(dificultad: nivel)
                        tableroViewModel.initTableroDesdeGenerador()
                        tableroViewModel.startTimer()
                    }
                ) {
                    Text(nivel.capitalizedFirstLetter())
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
