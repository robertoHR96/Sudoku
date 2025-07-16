//
//  TableroViewModel.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//

import SwiftUI

/// ViewModel que controla la lógica y estado del tablero Sudoku,
/// incluyendo la gestión del temporizador, selección y modificación de celdas, historial de movimientos y dificultad.
class TableroViewModel: ObservableObject {
    
    /// Modelo de datos que representa el tablero y su estado.
    @Published private(set) var model = TableModel()
    
    /// Temporizador que cuenta el tiempo transcurrido desde que se inicia el juego.
    private var timer: Timer?
    
    /// Indicador de si se a terminado la partida
    @Published var isGameFinished: Bool = false
    
    /// Diccionario que asocia niveles de dificultad con la cantidad de celdas a borrar.
    var diccionarioDificultad: [String: Int] = [
        "facil": 40,
        "medil": 50,   // ⚠️ Revisa este string, probablemente querías "medio"
        "dificil": 60
    ]

    /// Propiedad para acceder y modificar el tablero de celdas.
    var board: [[CeldaModel]] {
        get {
            model.board
        }
        set {
            model.board = newValue
            objectWillChange.send()  // Notifica la actualización a la vista
        }
    }
    
    // MARK: - Temporizador
    
    /// Inicia el temporizador que cuenta segundos transcurridos.
    func startTimer() {
        timer?.invalidate() // Si ya hay un temporizador activo, se detiene primero
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.model.elapsedSeconds += 1
            self.objectWillChange.send() // Notifica cambio para actualizar la UI
        }
    }
    
    /// Modifica el nivel de dificultad actual en el modelo.
    func modDificultad(dificultad: String){
        model.dificultad = dificultad
    }

    /// Detiene el temporizador.
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    /// Reinicia el temporizador y el contador a cero.
    func resetTimer() {
        stopTimer()
        model.elapsedSeconds = 0
        objectWillChange.send()
    }
    
    /// Obtiene el nivel de dificultad actual.
    func getDificultad() -> String {
        return model.dificultad
    }
    
    /// Indica si el tablero ya ha sido inicializado.
    func getInitTablero() -> Bool {
        return model.iniciado
    }
    
    /// Inicializa el tablero usando el generador de Sudoku,
    /// con el número de celdas a borrar según la dificultad seleccionada.
    func initTableroDesdeGenerador() {
        let generator = SudokuGenerator()
        (model.boardComplete, model.board) = generator.generateCeldaModelBoard(
            newNumeroBorrar: diccionarioDificultad[model.dificultad] ?? 40
        )
        model.iniciado = true
        objectWillChange.send()
    }
    
    // MARK: - Historial y deshacer movimientos
    
    /// Añade un movimiento al historial, para permitir deshacerlo después.
    private func addHistory(newFila: Int, newColumna: Int, valor: Int) {
        model.historial.append(History(fila: newFila, columna: newColumna, valor: valor))
        objectWillChange.send()
    }
    
    /// Revierte el último cambio realizado en el tablero (función "deshacer").
    func backHistory() {
        if model.historial.count > 0 {
            let ultimo = model.historial.removeLast()
            model.board[ultimo.fila][ultimo.columna].valor = ultimo.valor
            objectWillChange.send()
        }
    }

    // MARK: - Selección de celdas
    
    /// Selecciona una celda específica del tablero.
    func selectCell(row: Int, column: Int) {
        model.selectCell(row: row, column: column)
        objectWillChange.send() // Notifica manualmente el cambio
    }
    
    /// Deselecciona cualquier celda (resetea selección).
    func onSelectCell() {
        model.selectCell(row: -1, column: -1)
    }

    // MARK: - Modificación de celdas
    
    /// Modifica el valor de la celda seleccionada, guarda el cambio en el historial
    /// y comprueba si el tablero sigue válido tras la modificación.
    func modCell(valor: Int) {
        if let row = model.selectedRow, let col = model.selectedColumn, row >= 0 || col >= 0 {
            addHistory(newFila: row, newColumna: col, valor: model.board[row][col].valor)
            model.modCell(valor: valor)
            model.board[row][col].fallida = valor != model.boardComplete[row][col].valor
            objectWillChange.send()
            isGameFinished = comprobar()
        }
    }
    
    // MARK: - Herramientas adicionales
    
    /// Imprime el tablero actual en consola (para debug).
    func mostrarTablero() {
        for i in 0..<9 {
            for e in 0..<9 {
                print(String(self.model.boardComplete[i][e].valor))
            }
        }
    }
    
    /// Comprueba si el tablero está correcto y completo según las reglas de Sudoku.
    func comprobar() -> Bool{
        for i in 0..<9 {
            for e in 0..<9 {
                if (model.board[i][e].valor != model.boardComplete[i][e].valor){
                    return false
                }
            }
        }
        return true
    }
}
