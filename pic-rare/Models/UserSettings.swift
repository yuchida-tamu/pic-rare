//
//  UserSettings.swift
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

import SwiftData
import SwiftUI

struct ColorComponents: Codable {
    let red: Float
    let green: Float
    let blue: Float

    var color: Color {
        Color(red: Double(red), green: Double(green), blue: Double(blue))
    }

    static func fromColor(_ color: Color) -> ColorComponents {
        let resolved = color.resolve(in: EnvironmentValues())
        return ColorComponents(
            red: resolved.red,
            green: resolved.green,
            blue: resolved.blue
        )
    }
}

@Model
class UserSettings {
    var borderColor: ColorComponents
    var saturation: Double
    var galleryViewMode: Int

    init() {
        borderColor = .fromColor(.white)
        saturation = 1.3
        galleryViewMode = 3
    }
}
