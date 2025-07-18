//
//  Settings.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//
import SwiftUI

struct Settings: View {
    @EnvironmentObject var tableroViewModel: TableroViewModel
    @EnvironmentObject var localizationManager: LocalizationManager

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Language".localized(for: localizationManager.language))) {
                    Picker("Language".localized(for: localizationManager.language), selection: $localizationManager.language) {
                        Text("English").tag("en")
                        Text("Español").tag("es")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Settings".localized(for: localizationManager.language))
        }
        .onAppear {
            tableroViewModel.stopTimer()
        }
    }
}

#Preview{
    Settings()
        .environmentObject(TableroViewModel())
        .environmentObject(LocalizationManager())
}
