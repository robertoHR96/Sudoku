//
//  CeldaModel.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//

struct CeldaModel {
    var valor : Int = 0
    var estado : Bool = false
    
    mutating func changeValor(nuevoEstado: Bool? = nil) {
        estado = nuevoEstado ?? !estado
    }
}
