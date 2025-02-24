//
//  SettingsView.swift
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

import SwiftData
import SwiftUI

struct SettingsView: View {
    var context: ModelContext

    @State var saturation: Double = 1.3
    @State var borderColor: Color = .white
    @State var isPresentingColorPicker = false

    @Query var settings: [UserSettings]

    var icon: String {
        guard let setting = settings.first else { return "square.grid.3x3" }

        switch setting.galleryViewMode {
        case 1: return "rectangle.grid.1x2"
        case 2: return "square.grid.2x2"
        case 3: return "square.grid.3x3"
        default: return "square.grid.3x3"
        }
    }

    var color: Color {
        guard let setting = settings.first else { return .white }

        return setting.borderColor.color
    }

    var body: some View {
        List {
            HStack {
                Text("Border Color")
                Spacer()
                ColorPicker("", selection: $borderColor, supportsOpacity: false)
                    .onChange(of: borderColor) {
                        guard settings.first != nil else { return }
                        settings.first!.borderColor = .fromColor(borderColor)
                    }
            }
            HStack {
                Text("Saturation")
                Spacer(minLength: 60)

                VStack(alignment: .trailing) {
                    Slider(value: $saturation, in: 0.5...2.0, step: 0.1)
                        .onChange(of: saturation, initial: false) {
                            guard settings.first != nil else { return }
                            settings.first!.saturation = saturation
                        }
                    Text("\(saturation)")
                }

            }

            HStack {
                Text("Gallery View")
                Spacer()
                Image(systemName: icon)
                    .onTapGesture {
                        switchGalleryMode()
                    }
                    .animation(
                        .spring(), value: settings.first?.galleryViewMode)
            }

        }
        .listStyle(.plain)
        .padding(.horizontal, 16)
        .onAppear {
            if settings.isEmpty {
                let setting = UserSettings()
                context.insert(setting)
                borderColor = setting.borderColor.color
                saturation = setting.saturation
            } else {
                borderColor = settings.first!.borderColor.color
                saturation = settings.first!.saturation
            }
        }

    }

    func switchGalleryMode() {
        guard let setting = settings.first else { return }
        if setting.galleryViewMode > 2 {
            settings.first!.galleryViewMode = 1
        } else {
            settings.first!.galleryViewMode += 1
        }

    }
}

#Preview {
    struct PreviewComponent: View {
        @Environment(\.modelContext) private var modelContext
        var body: some View {
            SettingsView(context: modelContext)
        }
    }

    return PreviewComponent()
        .modelContainer(for: UserSettings.self, inMemory: true)
}
