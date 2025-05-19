//
//  TableModel.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//

struct TableModel {
    var board: [[CeldaModel]] = Array(repeating: Array(repeating: CeldaModel(), count: 9), count: 9)
    var historial: [History]
    
    var selectedRow: Int? = 0
    var selectedColumn: Int? = 0
    
    init() {
        board = Array(repeating: Array(repeating: CeldaModel(), count: 9), count: 9)
        historial = Array(repeating: History(fila: -1, columna: -1), count: 0)
    }
    
    mutating func selectCell(row: Int, column: Int) {
        selectedRow = row
        selectedColumn = column
        print("llamar a selectCell")
    }
    
    mutating func modCell(valor: Int) {
            guard let row = selectedRow, let col = selectedColumn else {
                print("⚠️ No hay celda seleccionada.")
                return
            }

            guard row >= 0 && row < 9 && col >= 0 && col < 9 else {
                print("⚠️ Índices fuera de rango.")
                return
            }

            board[row][col].valor = valor
        print("Valor insertado en (\(row), \(col)): \(board[row][col].valor)")
        }

    func checkBoard() -> Bool {
        // Aquí haces la lógica para comprobar si el tablero es válido o completo
        // De momento solo como ejemplo:
        print("lllamar a comprobar tablero model")
        return false
    }
}
