//
//  HorographicViewModifier.swift
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

import SwiftUI
import GameplayKit

struct HorographicViewModifier: ViewModifier {
    var offset: CGSize
    var voronoi: Image
    
    var magnitude: Double {
        let xRotAbs = abs(offset.width)
        let capped = min(xRotAbs, 50.0);
        return capped / 50.0;
    }
    
    var saturation: Double {
        return magnitude * 1.3
    }
    
    func body(content: Content) -> some View {
        content
            .colorEffect(
                ShaderLibrary.holographic(.image(voronoi), .float(magnitude), .float(saturation))
            )
    }
}
