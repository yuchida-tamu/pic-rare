//
//  Item.swift
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
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
