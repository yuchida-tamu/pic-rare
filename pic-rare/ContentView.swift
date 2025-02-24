//
//  ContentView.swift
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    var photoGalleryViewModel = PhotoDetailViewModel()

    var body: some View {
        TabView {
            PhotoGalleryView()
                .environmentObject(photoGalleryViewModel)
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("gallery")
                }

            SettingsView(context: modelContext)
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("settings")
                }
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: UserSettings.self, inMemory: true)
}
