//
//  PhotoGalleryView.swift
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

import GameplayKit
import PhotosUI
import SwiftUI

struct PhotoItem: Identifiable, Hashable {
    let id = UUID()
    let image: UIImage
}

struct PhotoGalleryHeaderView: View {
    @Binding var selectedImages: [PhotosPickerItem]

    var body: some View {
        HStack {
            Spacer()
            PhotosPicker(selection: $selectedImages, matching: .images) {
                Image(systemName: "photo.badge.plus.fill")
                Text("Add Images")
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)

    }
}

struct PhotoGalleryView: View {
    @Namespace var namespace
    @EnvironmentObject var photoGalleryViewModel: PhotoDetailViewModel
    @State var selectedImages: [PhotosPickerItem] = []
    @State var loadedImages: [PhotoItem] = []
    @State var offset: CGSize = CGSize.zero

    private let date = Date()

    var rotation: Double {
        let xRotAbs = abs(offset.width)
        let capped = min(xRotAbs, 50.0)
        return capped / 50.0
    }

    var body: some View {
        NavigationStack {
            VStack {
                PhotoGalleryHeaderView(selectedImages: $selectedImages)
                ScrollGridView(items: loadedImages) { item in
                    NavigationLink(value: item) {
                        ImageCard(image: item.image)
                            .small()
                            .horographic(
                                offset: offset,
                                voronoi: photoGalleryViewModel
                                    .horographicImage
                            )
                            .shadow(
                                radius: 4.0
                            )
                    }
                }
            }
            .navigationDestination(for: PhotoItem.self) {
                photoItem in
                PhotoDetailView(photoItem: photoItem)
            }
            .onChange(of: selectedImages, initial: false) {
                loadImages(selectedImages)
            }
        }

    }  //: body

    func loadImages(_ pickerItems: [PhotosPickerItem]) {
        Task {
            loadedImages = []

            for image in pickerItems {
                guard
                    let data = try await image.loadTransferable(
                        type: Data.self)
                else { return }
                guard let uiImage = UIImage(data: data) else { return }
                loadedImages.append(PhotoItem(image: uiImage))
            }

        }
    }
}

#Preview {
    PhotoGalleryView()
        .environmentObject(PhotoDetailViewModel())
}
