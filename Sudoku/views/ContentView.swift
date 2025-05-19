//
//  ContentView.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView{
            Game()
                .tabItem {
                    Image(systemName: "house")
                    Text("Game")
                }
            Settings()
                .tabItem{
                    Image(systemName: "gear")
                    Text("Ajustes")
                }
        }
    }
}

#Preview {
    ContentView()
}
