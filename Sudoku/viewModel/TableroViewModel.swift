//
//  TableroViewModel.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//


import SwiftUI

class TableroViewModel: ObservableObject {
    @Published private(set) var model = TableModel()

    var board: [[CeldaModel]] {
        get {
            model.board
        }
        set {
            model.board = newValue
            objectWillChange.send()
        }
    }
    
    func initTableroDesdeGenerador() {
        let generator = SudokuGenerator()
        model.board = generator.generateCeldaModelBoard()
        objectWillChange.send()
    }
    
    private func addHistory(newFila: Int, newColumna: Int, valor: Int ){
        print("añadido al historia fil:\(newFila), col:\(newColumna), valor:\(valor)")
        model.historial.append(History(fila: newFila, columna: newColumna, valor: valor))
        objectWillChange.send()
    }
    func backHistory(){
        if(model.historial.count > 0){
            var fila = model.historial[model.historial.count - 1].fila
            var columna = model.historial[model.historial.count - 1].columna
            var valor = model.historial[model.historial.count - 1].valor
            print("delete historia fil:\(fila), col:\(columna), valor:\(valor)")
            model.historial.removeLast()
            model.board[fila][columna].valor = valor
            objectWillChange.send()
        }
    }

    func selectCell(row: Int, column: Int) {
        model.selectCell(row: row, column: column)
        objectWillChange.send() // Notifica manualmente
    }
    
    func onSelectCell(){
        model.selectCell(row: -1, column: -1)
    }

    func modCell(valor: Int){
        if let row = model.selectedRow, let col = model.selectedColumn, row >= 0 || col >= 0 {
            addHistory(newFila: row, newColumna: col, valor: model.board[row][col].valor)
            model.modCell(valor: valor)
            objectWillChange.send()
            comprobar()
        }
    }
    
    func mostrarTablero(){
        for i in 0..<9 {
            for e in 0..<9 {
                print(String(self.model.board[i][e].valor))
            }
        }
    }
    
    func comprobar() {
        let esValido = model.checkBoard()
        print("¿Tablero válido?: \(esValido)")
    }
}
