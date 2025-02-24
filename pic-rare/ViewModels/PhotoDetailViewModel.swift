//
//  PhotoDetailViewModel.swift
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

import GameplayKit
import PhotosUI
import SwiftUI

class PhotoDetailViewModel: ObservableObject {
    var horographicImage: Image

    init() {
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
}
