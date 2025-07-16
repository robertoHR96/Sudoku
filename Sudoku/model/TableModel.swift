//
//  TableModel.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//

import SwiftUI

/// Modelo de datos que representa el estado general del tablero de Sudoku.
struct TableModel {
    
    /// Matriz 9x9 de celdas (`CeldaModel`) que representa el tablero.
    var board: [[CeldaModel]] = Array(repeating: Array(repeating: CeldaModel(), count: 9), count: 9)
    var boardComplete: [[CeldaModel]] = Array(repeating: Array(repeating: CeldaModel(), count: 9), count: 9)

    /// Historial de movimientos realizados por el usuario (útil para implementar deshacer).
    var historial: [History] = Array(repeating: History(), count: 0)
    
    /// Fila actualmente seleccionada por el usuario (opcional).
    var selectedRow: Int? = 0
    
    /// Columna actualmente seleccionada por el usuario (opcional).
    var selectedColumn: Int? = 0
    
    /// Contador de tiempo transcurrido desde que se empezó la partida.
    var elapsedSeconds: Int = 0 // ⏱ Contador de tiempo
    
    /// Nivel de dificultad del tablero (por ejemplo: "facil", "medio", "dificil").
    var dificultad: String = "facil"
    
    /// Indica si la partida ya ha comenzado.
    var iniciado: Bool = false
    
    /// Inicializa el tablero marcando que la partida ha comenzado.
    mutating func initTablero() {
        iniciado = true
    }
    
    /// Selecciona una celda del tablero.
    /// - Parameters:
    ///   - row: Índice de la fila seleccionada.
    ///   - column: Índice de la columna seleccionada.
    mutating func selectCell(row: Int, column: Int) {
        selectedRow = row
        selectedColumn = column
    }
    
    /// Modifica el valor de la celda actualmente seleccionada.
    /// - Parameter valor: Número que se desea colocar en la celda.
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
    }

    /// Comprueba si un número es válido en una posición específica usando un tablero dado.
    /// Esta función se utiliza para validar sin modificar el `board` real.
    /// - Parameters:
    ///   - board: Tablero a validar.
    ///   - row: Fila a comprobar.
    ///   - col: Columna a comprobar.
    ///   - num: Número a validar.
    /// - Returns: `true` si el número se puede colocar en esa posición sin violar las reglas de Sudoku.
    func isValidWithBoard(_ board: [[CeldaModel]], _ row: Int, _ col: Int, _ num: Int) -> Bool {
        for i in 0..<9 {
            if board[row][i].valor == num || board[i][col].valor == num {
                return false
            }
        }
        let startRow = (row / 3) * 3
        let startCol = (col / 3) * 3
        for r in startRow..<startRow+3 {
            for c in startCol..<startCol+3 {
                if board[r][c].valor == num {
                    return false
                }
            }
        }
        return true
    }

    /// Verifica si el tablero está completamente y correctamente resuelto.
    /// - Returns: `true` si todas las celdas están llenas y cada número cumple con las reglas de Sudoku.
    func checkBoard() -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                let num = board[row][col].valor
                if num == 0 {
                    return false // Hay una celda vacía
                }

                // Simula la validación sin modificar el board real
                var tempBoard = board
                tempBoard[row][col].valor = 0
                if !isValidWithBoard(tempBoard, row, col, num) {
                    return false
                }
            }
        }
        return true
    }
}
