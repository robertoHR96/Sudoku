//
//  Game.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//

import SwiftUI
struct Game: View {
    @StateObject var gameViewModel = GameViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if gameViewModel.initGame {
                    GameView()
                        .environmentObject(gameViewModel)
                } else {
                    NoGameView()
                        .environmentObject(gameViewModel)
                }
            }
            .navigationTitle("Sudoku") // Aquí se pone el título
        }
    }
}

#Preview{
    Game()
}
