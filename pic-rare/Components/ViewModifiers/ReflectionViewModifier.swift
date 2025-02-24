//
//  ReflectionViewModifier.swift
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

import SwiftUI

struct ReflectionViewModifier: ViewModifier {
    var offset: CGSize

    func body(content: Content) -> some View {
        content
            .colorEffect(
                ShaderLibrary.imageFilterShader(
                    .float(offset.width), .float(offset.height))
            )
    }
}
