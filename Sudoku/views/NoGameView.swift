//
//  NoGameView.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//

import SwiftUI

struct NoGameView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    var body: some View {
        VStack{
            Text("No Game View")
            Button {
                gameViewModel.initGame = true
            } label : {
                Text("Nueva partida")
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
            }
        }
    }
}

#Preview {
    NoGameView()
        .environmentObject(GameViewModel())
}
