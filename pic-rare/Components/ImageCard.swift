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
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }

    init(image: UIImage? = nil) {
        self.image = image
    }
}

extension ImageCard {
    func small() -> some View {
        var updated = self
        updated.padding = 4
        return updated
    }
}

extension View {
    func reflective(offset: CGSize) -> some View {
        modifier(ReflectionViewModifier(offset: offset))
    }
}

extension View {
    func horographic(offset: CGSize, voronoi: Image) -> some View {
        modifier(HorographicViewModifier(offset: offset, voronoi: voronoi))
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
