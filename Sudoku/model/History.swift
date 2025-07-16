//
//  History.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 20/5/25.
//

/// Estructura que representa una acción realizada por el usuario en el tablero de Sudoku.
/// Se utiliza para mantener un historial de cambios, permitiendo funcionalidades como deshacer movimientos.
struct History {
    
    /// Fila del tablero donde se realizó el cambio.
    var fila: Int = 0
    
    /// Columna del tablero donde se realizó el cambio.
    var columna: Int = 0
    
    /// Valor que fue colocado en la celda correspondiente.
    var valor: Int = 0
}
