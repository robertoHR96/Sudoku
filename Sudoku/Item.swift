//
//  Item.swift
//  Sudoku
//
//  Created by Roberto Hermoso Rivero on 19/5/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
