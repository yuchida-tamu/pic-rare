//
//  Gesture3DTransformView.swift
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

import SwiftUI

struct Gesture3DTransformView<Content: View>: View {
    @ViewBuilder let content: () -> Content
    @Binding var offset: CGSize

    var body: some View {

        content()
            .rotation3DEffect(
                .degrees(20.0), axis: (x: offset.height, y: offset.width, z: 0)
            )
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        offset = .zero
                    })

    }

    init(offset: Binding<CGSize>, @ViewBuilder content: @escaping () -> Content)
    {
        self.content = content
        self._offset = offset
    }
}

#Preview {
    struct PreviewContent: View {
        @State var offset = CGSize.zero
        var body: some View {
            VStack {
                Gesture3DTransformView(offset: $offset) {
                    ImageCard()
                }
            }
        }
    }

    return PreviewContent()
}
