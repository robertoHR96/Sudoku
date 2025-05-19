//
//  GameView.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


struct Celda: View {
    var isSelected: Bool = false // Primero
    var valor: String = ""     // Segundo
    var tamanio: CGFloat = 40
    var columna: Int = 8
    var fila: Int = 8
    @EnvironmentObject var tableroViewModel : TableroViewModel
    
    var body: some View {
        if(!isSelected){
        Button{
                tableroViewModel.selectCell(row: fila, column: columna)
        } label: {
            Text(valor)
                .font(.system(size: 33))
                .frame(width: tamanio, height: tamanio)
                .border(Color(hex:"#DEDFDF"), width: 1)
                .background(.white)
                .foregroundColor(Color(hex: "#0094D9"))
                .overlay(
                    VStack(spacing: 0) {
                        if (fila == 0) || (fila % 3 == 0) {
                            Rectangle()
                                .frame(height: 3)
                                .foregroundColor(.black)
                            
                        }
                        
                        Spacer()
                        
                        if (fila == 8){
                            Rectangle()
                                .frame(height: 3)
                                .foregroundColor(.black)
                            
                        }
                    }
                )
                .overlay(
                    HStack(spacing: 0) {
                        if (columna == 0) || (columna % 3 == 0) {
                            Rectangle()
                                .frame(width: 3)
                                .foregroundColor(.black)
                            
                        }
                        
                        Spacer()
                        
                        if (columna == 8) {
                            Rectangle()
                                .frame(width: 3)
                                .foregroundColor(.black)
                            
                        }
                    }
                )
        }
        }else{
            Text(valor)
                .font(.system(size: 33))
                .frame(width: tamanio, height: tamanio)
                .border(Color(hex:"#DEDFDF"), width: 1)
                .background(.white)
                .foregroundColor(.black)
                .overlay(
                    VStack(spacing: 0) {
                        if (fila == 0) || (fila % 3 == 0) {
                            Rectangle()
                                .frame(height: 3)
                                .foregroundColor(.black)
                            
                        }
                        
                        Spacer()
                        
                        if (fila == 8){
                            Rectangle()
                                .frame(height: 3)
                                .foregroundColor(.black)
                            
                        }
                    }
                )
                .overlay(
                    HStack(spacing: 0) {
                        if (columna == 0) || (columna % 3 == 0) {
                            Rectangle()
                                .frame(width: 3)
                                .foregroundColor(.black)
                            
                        }
                        
                        Spacer()
                        
                        if (columna == 8) {
                            Rectangle()
                                .frame(width: 3)
                                .foregroundColor(.black)
                            
                        }
                    }
                )
        }
    }
}



struct Tablero: View {
    @EnvironmentObject var tableroViewModel : TableroViewModel
    var body: some View {
        HStack (spacing: 0){
            ForEach(0..<9, id: \.self) { columna in
                VStack(spacing: 0){
                    ForEach(0..<9, id: \.self) { fila in
                        Celda(
                            isSelected: tableroViewModel.board[fila][columna].estado,
                            valor:tableroViewModel.board[fila][columna].valor != 0 ? String(tableroViewModel.board[fila][columna].valor) : "",
                            columna: columna,
                            fila: fila
                        )
                    }
                }
            }
        }
    }
    
}




struct GameView: View {
    
    let columns = Array(repeating: GridItem(.flexible()), count: 9)
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @StateObject var tableroViewModel = TableroViewModel()
    
    var body: some View {
        VStack{
            Spacer()
            Tablero()
                .padding(10)
                .environmentObject(tableroViewModel)
            
            HStack(spacing:0){
                Spacer()
                Button{
                    tableroViewModel.backHistory()
                }label: {
                    Image(systemName: "arrowshape.turn.up.backward")
                        .padding()
                        .frame(width:30, height: 50)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Spacer()
                ForEach(1..<10){ i in
                    Button{
                        tableroViewModel.modCell(valor: i)
                        tableroViewModel.onSelectCell()
                    }label: {
                        Text(String(i))
                            .font(.system(size: 26))
                            .bold()
                            .frame(width:30, height: 50)
                            .background(Color(hex:"#B6B6B6"))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    Spacer()
                }
            }
            .padding()
            Spacer()
            Button{
                gameViewModel.initGame = false
            } label: {
                Text("Salir")
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Spacer()
            /*
             Button{
             tableroViewModel.mostrarTablero()
             }label: {
             Text("Mostrar tablero")
             }
             */
        }
        .onAppear {
               tableroViewModel.initTableroDesdeGenerador()
           }
    }
}

#Preview {
    GameView(tableroViewModel: TableroViewModel())
        .environmentObject(GameViewModel())
}


