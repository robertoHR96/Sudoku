//
//  SudokuSolver.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 20/5/25.
//


class SudokuSolver {
    var board: [[Int]]

    init(board: [[Int]]) {
        self.board = board
    }

    func isValid(_ row: Int, _ col: Int, _ num: Int) -> Bool {
        for i in 0..<9 {
            if board[row][i] == num || board[i][col] == num {
                return false
            }
        }
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

    func countSolutions() -> Int {
        return backtrackCount()
    }

    private func backtrackCount() -> Int {
        for row in 0..<9 {
            for col in 0..<9 {
                if board[row][col] == 0 {
                    var count = 0
                    for num in 1...9 {
                        if isValid(row, col, num) {
                            board[row][col] = num
                            count += backtrackCount()
                            if count > 1 {  // Ya hay más de una solución, corta
                                board[row][col] = 0
                                return count
                            }
                            board[row][col] = 0
                        }
                    }
                    return count
                }
            }
        }
        // Si llegamos aquí, hemos encontrado una solución completa
        return 1
    }
}
