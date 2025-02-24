//
//  ImageCard.swift
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

import SwiftUI

struct ImageCard: View {
    var image: UIImage? = nil
    var padding = 16.0
    var borderColor = Color.white

    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8.0)
                    )

            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0)
                        .foregroundStyle(.gray)

                    Text("NO DATA")
                        .foregroundStyle(.white)
                }
            }

        }
        .padding(padding)
        .background(borderColor)
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }

    init(image: UIImage? = nil) {
        self.image = image
    }
}

extension ImageCard {
    func small() -> ImageCard {
        var updated = self
        updated.padding = 4
        return updated
    }

    func borderColor(_ color: Color) -> ImageCard {
        var updated = self
        updated.borderColor = color
        return updated
    }
}

extension View {
    func reflective(offset: CGSize) -> some View {
        modifier(ReflectionViewModifier(offset: offset))
    }
}

extension View {
    func horographic(offset: CGSize, voronoi: Image, saturation: Double)
        -> some View
    {
        modifier(
            HorographicViewModifier(
                offset: offset, voronoi: voronoi, saturation: saturation))
    }
}

#Preview {
    ImageCard()
        .shadow(
            color: Color(.sRGBLinear, white: 0, opacity: 0.33),
            radius: 8.0,
            x: 0,
            y: 0
        )
}
