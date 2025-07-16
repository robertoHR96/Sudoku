//
//  Settings.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//
import SwiftUI
struct Settings: View {
    @EnvironmentObject var tableroViewModel: TableroViewModel
    var body: some View {
        Text("Ajustes").onAppear {
            tableroViewModel.stopTimer()
        }
    }
}

#Preview{
    Settings()
        .environmentObject(TableroViewModel())
}
