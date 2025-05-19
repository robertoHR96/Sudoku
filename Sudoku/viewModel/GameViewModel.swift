//
//  GameViewModel.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//


import SwiftUI

// ViewModel compartido
class GameViewModel: ObservableObject {
    @Published var initGame: Bool = false
}