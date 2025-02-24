//
//  ImageData.swift
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

import SwiftData
import SwiftUI

@Model
class ImageData {
    @Attribute(.externalStorage)
    var data: Data
    
    init(data: Data) {
        self.data = data
    }
}
