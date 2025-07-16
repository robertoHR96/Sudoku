//
//  CeldaModel.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//

/// Modelo que representa una celda individual del tablero de Sudoku.
struct CeldaModel {
    
    /// Valor numérico de la celda (entre 1 y 9). El valor `0` representa una celda vacía.
    var valor: Int = 0
    
    /// Estado lógico de la celda (por ejemplo, puede indicar si es una celda fija o editable).
    /// Su uso puede adaptarse según la lógica del juego.
    var estado: Bool = false
    
    /// Comprueba si la celda tiene un valor que no soluciona el tablero
    var fallida: Bool = false
    
    /// Cambia el estado de la celda.
    /// - Parameter nuevoEstado: Si se proporciona, establece el estado directamente. Si es `nil`, invierte el valor actual (`true` -> `false`, `false` -> `true`).
    mutating func changeValor(nuevoEstado: Bool? = nil) {
        estado = nuevoEstado ?? !estado
    }
}
