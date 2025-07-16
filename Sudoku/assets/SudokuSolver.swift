//
//  SudokuSolver.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 20/5/25.
//

/// Clase encargada de validar y resolver tableros de Sudoku.
class SudokuSolver {
    
    /// Tablero de Sudoku representado como una matriz de enteros (9x9).
    /// Los valores deben estar entre 1 y 9. El valor `0` representa una celda vacía.
    var board: [[Int]]

    /// Inicializa el solver con un tablero dado.
    /// - Parameter board: Tablero de Sudoku (9x9).
    init(board: [[Int]]) {
        self.board = board
    }
    
    /// Verifica si el tablero actual está completamente y correctamente resuelto.
    /// - Returns: `true` si todas las celdas están llenas y cumplen las reglas del Sudoku.
    func isSolved() -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                let num = board[row][col]
                if num == 0 {
                    return false // Hay una celda vacía
                }
                // Se vacía temporalmente la celda para evitar conflictos consigo misma al validar
                board[row][col] = 0
                if !isValid(row, col, num) {
                    board[row][col] = num
                    return false // El número no es válido según las reglas
                }
                board[row][col] = num
            }
        }
        return true
    }

    /// Valida si un número puede colocarse en una posición específica del tablero.
    /// - Parameters:
    ///   - row: Fila del tablero.
    ///   - col: Columna del tablero.
    ///   - num: Número a validar.
    /// - Returns: `true` si el número puede colocarse respetando las reglas del Sudoku.
    func isValid(_ row: Int, _ col: Int, _ num: Int) -> Bool {
        // Validar fila y columna
        for i in 0..<9 {
            if board[row][i] == num || board[i][col] == num {
                return false
            }
        }
        // Validar subcuadro 3x3
        let startRow = (row / 3) * 3
        let startCol = (col / 3) * 3
        for r in startRow..<startRow+3 {
            for c in startCol..<startCol+3 {
                if board[r][c] == num {
                    return false
                }
            }
        }
        return true
    }

    /// Cuenta cuántas soluciones tiene el tablero actual.
    /// - Returns: Número de soluciones posibles. Devuelve 0, 1 o más.
    func countSolutions() -> Int {
        return backtrackCount()
    }

    /// Algoritmo de backtracking que cuenta las soluciones del tablero.
    /// Se detiene temprano si encuentra más de una solución.
    /// - Returns: Número de soluciones encontradas.
    private func backtrackCount() -> Int {
        for row in 0..<9 {
            for col in 0..<9 {
                if board[row][col] == 0 {
                    var count = 0
                    for num in 1...9 {
                        if isValid(row, col, num) {
                            board[row][col] = num
                            count += backtrackCount()
                            if count > 1 {
                                // Si ya hay más de una solución, no continúa buscando
                                board[row][col] = 0
                                return count
                            }
                            board[row][col] = 0
                        }
                    }
                    return count // Si no encuentra ningún número válido, no hay solución
                }
            }
        }
        // Si no hay celdas vacías, se ha encontrado una solución válida
        return 1
    }
}
