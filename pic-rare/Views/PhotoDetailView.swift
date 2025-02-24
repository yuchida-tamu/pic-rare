//
//  PhotoDetailView.swift
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

import SwiftData
import SwiftUI

struct PhotoDetailView: View {
    var photoItem: PhotoItem

    @EnvironmentObject var viewModel: PhotoDetailViewModel
    @State var offset: CGSize = CGSize.zero
    @Query var settings: [UserSettings]

    var saturation: Double {
        if let userSetting = settings.first {
            return userSetting.saturation
        }
        return 1.3
    }

    var borderColor: Color {
        if let userSetting = settings.first {
            return userSetting.borderColor.color
        }
        return .white
    }

    var body: some View {
        Gesture3DTransformView(offset: $offset) {
            ImageCard(image: photoItem.image)
                .borderColor(borderColor)
                .reflective(offset: offset)
                .horographic(
                    offset: offset, voronoi: viewModel.horographicImage,
                    saturation: saturation
                )
                .shadow(radius: 8.0)
        }
        .padding()
    }
}
//
//#Preview {
//    PhotoDetailView()
//}
