//
//  PhotoDetailView.swift
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

import SwiftUI

struct PhotoDetailView: View {
    var photoItem: PhotoItem
    
    @EnvironmentObject var viewModel: PhotoDetailViewModel
    @State var offset: CGSize = CGSize.zero
    
    var body: some View {
        Gesture3DTransformView(offset: $offset){
            ImageCard(image: photoItem.image)
                .reflective(offset: offset)
                .horographic(offset: offset, voronoi: viewModel.horographicImage)
                .shadow(radius: 8.0)
        }
        .padding()
    }
}
//
//#Preview {
//    PhotoDetailView()
//}
