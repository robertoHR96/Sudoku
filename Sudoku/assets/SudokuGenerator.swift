//
//  SudokuGenerator.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 20/5/25.
//


import Foundation

class SudokuGenerator {
    private var tempBoard: [[Int]] = Array(repeating: Array(repeating: 0, count: 9), count: 9)
    
    func generateCeldaModelBoard() -> [[CeldaModel]] {
        _ = fillBoard()
        deleteCeldas()
        return convertToCeldaModelBoard()
    }
    
    func deleteCeldas() {
        for i in 0..<46 {
            var seguir = false;
            while(!seguir){
                var numero1 = Int.random(in: 0...8)
                var numero2 = Int.random(in: 0...8)
                var guardaValor = tempBoard[numero1][numero2]
                tempBoard[numero1][numero2]=0;
                var sudokuSolver = SudokuSolver(board:tempBoard);
                if(sudokuSolver.countSolutions() == 1){
                    seguir = true;
                }else{
                    tempBoard[numero1][numero2]=guardaValor
                }
            }
        }
    }
    
    private func fillBoard() -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                if tempBoard[row][col] == 0 {
                    var numbers = Array(1...9).shuffled()
                    for num in numbers {
                        if isValid(row: row, col: col, num: num) {
                            tempBoard[row][col] = num
                            if fillBoard() {
                                return true
                            }
                            tempBoard[row][col] = 0 // backtrack
                        }
                    }
                    return false
                }
            }
        }
        return true
    }
    
    private func isValid(row: Int, col: Int, num: Int) -> Bool {
        for i in 0..<9 {
            if tempBoard[row][i] == num || tempBoard[i][col] == num {
                return false
            }
        }
        
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
    
    private func convertToCeldaModelBoard() -> [[CeldaModel]] {
        return tempBoard.map { row in
            row.map { value in
                CeldaModel(valor: value, estado:value != 0 ? true : false) // estado: true para que sean "fijas"
            }
        }
    }
}
