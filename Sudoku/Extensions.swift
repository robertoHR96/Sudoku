//
//  Extensions.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 21/5/25.
//

import SwiftUI

// MARK: - Extensión para crear colores desde valores hexadecimales

extension Color {
    /// Inicializa un color SwiftUI a partir de una cadena hexadecimal.
    /// Soporta formatos cortos (RGB 12-bit), largos (RGB 24-bit) y con alfa (ARGB 32-bit).
    ///
    /// - Parameter hex: Cadena hexadecimal que representa el color (ej. "#FF0000", "FF0000", "FFFF0000").
    init(hex: String) {
        // Quita caracteres no hexadecimales al principio y al final
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        
        // Convierte la cadena hex a un valor numérico entero
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        
        switch hex.count {
        case 3: // Formato RGB (12-bit), cada dígito repetido: e.g. "F00" => "FF0000"
            (a, r, g, b) = (
                255,
                (int >> 8) * 17,
                (int >> 4 & 0xF) * 17,
                (int & 0xF) * 17
            )
        case 6: // Formato RGB (24-bit)
            (a, r, g, b) = (
                255,
                int >> 16,
                int >> 8 & 0xFF,
                int & 0xFF
            )
        case 8: // Formato ARGB (32-bit)
            (a, r, g, b) = (
                int >> 24,
                int >> 16 & 0xFF,
                int >> 8 & 0xFF,
                int & 0xFF
            )
        default: // Valor por defecto (negro opaco)
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        // Inicializa el color con valores normalizados (0-1) y alfa
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Extensión para manipulación de cadenas

extension String {
    /// Devuelve la cadena con la primera letra en mayúscula y el resto en minúsculas.
    ///
    /// - Returns: Una nueva cadena con formato capitalizado solo en la primera letra.
    func capitalizedFirstLetter() -> String {
        // Si la cadena está vacía, la retorna igual
        guard let first = self.first else { return self }
        
        // Combina la primera letra mayúscula y el resto minúscula
        return first.uppercased() + self.dropFirst().lowercased()
    }
}
