//
//  SudokuGenerator.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 20/5/25.
//

import Foundation

/// Clase encargada de generar tableros de Sudoku válidos y únicos, y de convertirlos en un formato compatible con el modelo de la app (`CeldaModel`).
class SudokuGenerator {
    
    /// Tablero temporal usado para generar y manipular los valores del Sudoku (9x9).
    private var tempBoard: [[Int]] = Array(repeating: Array(repeating: 0, count: 9), count: 9)
    
    /// Número de celdas que se deben borrar del tablero generado para formar el puzzle.
    private var numeroBorrar: Int = 0
    
    /// Genera un nuevo tablero de Sudoku en forma de `[[CeldaModel]]`, con una cantidad específica de celdas eliminadas.
    /// - Parameter newNumeroBorrar: Número de celdas que deben quedar vacías en el tablero (nivel de dificultad).
    /// - Returns: Tablero de Sudoku en formato `[[CeldaModel]]`, con algunas celdas vacías y otro completo (resuelto).
    func generateCeldaModelBoard(newNumeroBorrar: Int) -> (completo: [[CeldaModel]], puzzle: [[CeldaModel]]) {
        _ = fillBoard() // Genera tablero completo
        let copiaTableroCompleto = tempBoard // Guarda copia antes de borrar
        let tableroCompleto = convertToCeldaModelBoard(from: tempBoard)
        
        numeroBorrar = newNumeroBorrar
        deleteCeldas() // Borra celdas del tablero original
        
        let tableroPuzzle = convertToCeldaModelBoard(from: tempBoard)
        
        return (completo: tableroCompleto, puzzle: tableroPuzzle)
    }
    
    /// Convierte el tablero de enteros (`[[Int]]`) en un tablero de `[[CeldaModel]]`, usado por la app.
    /// Las celdas no vacías se marcan como fijas (`estado = true`), y las vacías como editables (`estado = false`).
    /// - Parameter from board siendo la matriz de enteros que se convertira en una matriz de celdas
    /// - Returns: Tablero listo para mostrar en la interfaz.
    private func convertToCeldaModelBoard(from board: [[Int]]) -> [[CeldaModel]] {
        return board.map { row in
            row.map { value in
                CeldaModel(valor: value, estado: value != 0)
            }
        }
    }
    
    
    /// Elimina `numeroBorrar` celdas del tablero temporal (`tempBoard`), garantizando que el tablero resultante tenga una única solución.
    func deleteCeldas() {
        for _ in 0..<numeroBorrar {
            var seguir = false
            while !seguir {
                let fila = Int.random(in: 0...8)
                let columna = Int.random(in: 0...8)
                let valorOriginal = tempBoard[fila][columna]
                
                // Intenta borrar la celda
                tempBoard[fila][columna] = 0
                
                let sudokuSolver = SudokuSolver(board: tempBoard)
                if sudokuSolver.countSolutions() == 1 {
                    // Si sigue teniendo una única solución, acepta el borrado
                    seguir = true
                } else {
                    // Si tiene múltiples soluciones, se restaura el valor
                    tempBoard[fila][columna] = valorOriginal
                }
            }
        }
    }
    
    /// Rellena completamente el tablero con una solución válida usando backtracking.
    /// - Returns: `true` si se logró completar el tablero con una solución válida.
    private func fillBoard() -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                if tempBoard[row][col] == 0 {
                    let numbers = Array(1...9).shuffled()
                    for num in numbers {
                        if isValid(row: row, col: col, num: num) {
                            tempBoard[row][col] = num
                            if fillBoard() {
                                return true
                            }
                            tempBoard[row][col] = 0 // backtracking
                        }
                    }
                    return false // No hay número válido para esta celda
                }
            }
        }
        return true // Tablero completamente lleno
    }
    
    /// Verifica si un número puede colocarse en una posición específica del tablero temporal.
    /// - Parameters:
    ///   - row: Fila del tablero.
    ///   - col: Columna del tablero.
    ///   - num: Número que se quiere colocar.
    /// - Returns: `true` si es válido según las reglas del Sudoku.
    private func isValid(row: Int, col: Int, num: Int) -> Bool {
        // Verifica fila y columna
        for i in 0..<9 {
            if tempBoard[row][i] == num || tempBoard[i][col] == num {
                return false
            }
        }
        
        // Verifica subcuadro 3x3
        let startRow = (row / 3) * 3
        let startCol = (col / 3) * 3
        for i in 0..<3 {
            for j in 0..<3 {
                if tempBoard[startRow + i][startCol + j] == num {
                    return false
                }
            }
        }
        
        return true
    }
}
