//
//  HorographicViewModifier.swift
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

import GameplayKit
import SwiftUI

struct HorographicViewModifier: ViewModifier {
    var offset: CGSize
    var voronoi: Image
    var saturation: Double

    var magnitude: Double {
        let xRotAbs = abs(offset.width)
        let capped = min(xRotAbs, 50.0)
        return capped / 50.0
    }

    var saturationFactor: Double {
        return magnitude * saturation
    }

    func body(content: Content) -> some View {
        content
            .colorEffect(
                ShaderLibrary.holographic(
                    .image(voronoi), .float(magnitude), .float(saturationFactor)
                )
            )
    }
}
