//
//  PartidasViewModel.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 22/5/25.
//

/*
import SwiftData
import Foundation

class PartidasViewModel: ObservableObject {
    @Published var partidas: [PartidaModel] = []
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchPartidas()
    }
    
    func fetchPartidas() {
        let fetchDescriptor = FetchDescriptor<PartidaModel>(sortBy: [SortDescriptor(\.fechaInicio, order: .forward)])
        do {
            partidas = try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Error fetching partidas: \(error)")
            partidas = []
        }
    }
    
    func createPartida(fechaInicio: Date = Date(), dificultad: Dificultad, tableModel:TableModel) {
        let nuevaPartida = PartidaModel(fechaInicio: fechaInicio, dificultad: dificultad, tableModel:tableModel)
        modelContext.insert(nuevaPartida)
        saveChanges()
    }
    
    func updatePartida(partida: PartidaModel, nuevaDificultad: Dificultad) {
        partida.dificultad = nuevaDificultad
        saveChanges()
    }
    
    func deletePartida(partida: PartidaModel) {
        modelContext.delete(partida)
        saveChanges()
    }
    
    private func saveChanges() {
        do {
            try modelContext.save()
            fetchPartidas()
        } catch {
            print("Error saving changes: \(error)")
        }
    }
}
 
 */
