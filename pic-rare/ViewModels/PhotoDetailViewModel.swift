//
//  PhotoDetailViewModel.swift
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

import GameplayKit
import PhotosUI
import SwiftData
import SwiftUI

class PhotoDetailViewModel: ObservableObject {
    var context: ModelContext
    var horographicImage: Image
    @Published var photoItems: [PhotoItem] = []

    init(context: ModelContext) {
        self.context = context

        let voronoiNoiseSource = GKVoronoiNoiseSource(
            frequency: 20, displacement: 1, distanceEnabled: false, seed: 555)
        let noise = GKNoise(voronoiNoiseSource)
        let noiseMap = GKNoiseMap(
            noise, size: .init(x: 1, y: 1), origin: .zero,
            sampleCount: .init(x: 900, y: 900), seamless: true)
        let texture = SKTexture(noiseMap: noiseMap)
        let cgImage = texture.cgImage()

        self.horographicImage = Image(cgImage, scale: 1, label: Text(""))
    }

    func loadImages() {
        let descriptor = FetchDescriptor<ImageData>()
        photoItems = []
        do {
            let images = try context.fetch(descriptor)

            for image in images {
                guard let data = UIImage(data: image.data) else { break }
                photoItems.append(PhotoItem(image: data))
            }
        } catch {
            print("Failed to fetch data")
        }
    }

    func saveImages(images: [Data]) {
        for data in images {
            context.insert(ImageData(data: data))
        }
    }
    
    func savePhotoItem(items: [UIImage]){
        for item in items {
            photoItems.append(PhotoItem(image: item))
        }
    }

    func resetImages() {
        photoItems = []
    }
}
