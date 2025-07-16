//
//  GameView.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//

import SwiftUI


func encender(model: TableModel, fila: Int, columna: Int, valor: Int) -> Bool {
    guard let selectedRow = model.selectedRow,
          let selectedColumn = model.selectedColumn,
          selectedRow >= 0, selectedRow < model.board.count,
          selectedColumn >= 0, selectedColumn < model.board[selectedRow].count else {
        return false
    }

    // También validamos fila y columna actuales
    guard fila >= 0, fila < model.board.count,
          columna >= 0, columna < model.board[fila].count else {
        return false
    }

    if fila == selectedRow || columna == selectedColumn {
        return true
    }

    if valor == model.board[selectedRow][selectedColumn].valor {
        return true
    }

    return false
}

/// Vista que representa una celda individual del tablero Sudoku.
/// - Parámetros:
///   - isSelected: Indica si la celda está actualmente seleccionada.
///   - valor: Valor numérico de la celda para mostrar (cadena).
///   - tamanio: Tamaño de la celda (ancho y alto).
///   - fila: Índice de fila en el tablero.
///   - columna: Índice de columna en el tablero.
struct Celda: View {
    var isSelected: Bool = false
    var isFallida: Bool = true
    var valor: String = ""
    var tamanio: CGFloat = 40
    var fila: Int
    var columna: Int
    @EnvironmentObject var tableroViewModel: TableroViewModel
    
    var body: some View {
        Button {
            // Acción al pulsar la celda: seleccionar esta posición
            if(!isSelected){
                tableroViewModel.selectCell(row: fila, column: columna)
            }
        } label: {
            Text(valor)
                .font(.system(size: 33))
                .frame(width: tamanio, height: tamanio)
                .foregroundColor(
                    isSelected ? .black :
                        isFallida ? .red :
                        Color(hex: "#0094D9")
                )
            
                .background(
                    encender(
                        model: tableroViewModel.model,
                        fila: fila,
                        columna: columna,
                        valor: Int(valor) ?? -1 // usa -1 si la conversión falla
                    )
                    ? Color(hex: "#D7F2FF")
                    : .white
                )
            
                .border(Color(hex: "#DEDFDF"), width: 1)
                .overlay(gridLines) // Añade líneas gruesas que delimitan bloques 3x3
        }
        .buttonStyle(PlainButtonStyle()) // Sin animación de botón por defecto
    }
    
    /// Líneas gruesas que marcan las divisiones entre bloques 3x3 en el tablero
    private var gridLines: some View {
        ZStack {
            VStack(spacing: 0) {
                if fila == 0 || fila % 3 == 0 {
                    Rectangle().frame(height: 3).foregroundColor(.black)
                }
                Spacer()
                if fila == 8 {
                    Rectangle().frame(height: 3).foregroundColor(.black)
                }
            }
            HStack(spacing: 0) {
                if columna == 0 || columna % 3 == 0 {
                    Rectangle().frame(width: 3).foregroundColor(.black)
                }
                Spacer()
                if columna == 8 {
                    Rectangle().frame(width: 3).foregroundColor(.black)
                }
            }
        }
    }
}

/// Vista que representa el tablero completo de Sudoku, formado por una cuadrícula 9x9 de `Celda`.
struct Tablero: View {
    @EnvironmentObject var tableroViewModel: TableroViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<9, id: \.self) { fila in
                HStack(spacing: 0) {
                    ForEach(0..<9, id: \.self) { columna in
                        Celda(
                            isSelected: tableroViewModel.board[fila][columna].estado,
                            isFallida:tableroViewModel.board[fila][columna].fallida,
                            valor: tableroViewModel.board[fila][columna].valor != 0 ? String(tableroViewModel.board[fila][columna].valor) : "",
                            fila: fila,
                            columna: columna
                        )
                    }
                }
            }
        }
    }
}

/// Vista que contiene los botones de control debajo del tablero:
/// - Botón para deshacer el último movimiento.
/// - Botones para ingresar números del 1 al 9 en la celda seleccionada.
struct Buttons: View {
    @EnvironmentObject var tableroViewModel: TableroViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            // Botón para deshacer el último movimiento
            Button {
                tableroViewModel.backHistory()
            } label: {
                Image(systemName: "arrowshape.turn.up.backward")
                    .frame(width: 40, height: 50)
                    .background(Color(hex: "#0094D9"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            // Botones del 1 al 9 para modificar la celda seleccionada
            ForEach(1..<10) { i in
                Button {
                    tableroViewModel.modCell(valor: i)
                    tableroViewModel.onSelectCell() // Deselecciona la celda tras insertar
                } label: {
                    Text(String(i))
                        .font(.system(size: 33))
                        .bold()
                        .foregroundColor(Color(hex: "#0094D9"))
                }
                .frame(width: 22, height: 50)
            }
        }
        .padding(.horizontal)
    }
}

/// Vista informativa que muestra:
/// - La dificultad actual del juego.
/// - El tiempo transcurrido desde el inicio de la partida.
struct Info: View {
    @EnvironmentObject var tableroViewModel: TableroViewModel
    
    var body: some View {
        HStack {
            Text(tableroViewModel.getDificultad().capitalizedFirstLetter())
                .padding()
            Spacer()
            Text(String(format: "Tiempo: %02d:%02d", tableroViewModel.model.elapsedSeconds / 60, tableroViewModel.model.elapsedSeconds % 60))
                .padding()
        }
    }
}

/// Vista principal del juego Sudoku.
/// Contiene la información, el tablero y los botones numéricos para interacción.
struct GameView: View {
    
    @EnvironmentObject var tableroViewModel: TableroViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Info()
                    .environmentObject(tableroViewModel)
                Tablero()
                    .environmentObject(tableroViewModel)
                Buttons()
                    .environmentObject(tableroViewModel)
                    .padding(10)
                Spacer()
            }
            .alert("Enorabuena", isPresented: $tableroViewModel.isGameFinished) {
                Button("OK", role: .cancel) {
                    tableroViewModel.isGameFinished = false // opcional para reiniciar
                }
            } message: {
                Text("Juego terminado con éxito.")
            }
            .navigationBarTitle("Sudoku", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            tableroViewModel.startTimer()  // Inicia el temporizador cuando aparece la vista
        }
        .onDisappear{
            tableroViewModel.stopTimer()   // Detiene el temporizador al salir
        }
        // Reinicia el temporizador cuando la app vuelve a primer plano
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            tableroViewModel.startTimer()
        }
    }
}

#Preview {
    GameView()
        .environmentObject(TableroViewModel())
}
