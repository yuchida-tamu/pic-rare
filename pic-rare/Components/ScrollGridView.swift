//
//  ScrollGridView.swift
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

import SwiftUI

struct ScrollGridView<Content: View, T: Identifiable>: View {
    var items: [T]
    var columnCount = 3
    var content: (T) -> Content

    private var columns: [GridItem] {
        Array(repeating: GridItem(spacing: 8), count: columnCount)
    }

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                spacing: 8
            ) {
                ForEach(items, id: \.id) { item in
                    content(item)
                }
            }
        }
    }

    init(items: [T], content: @escaping (T) -> Content) {
        self.items = items
        self.content = content
    }

    init(items: [T], columnCount: Int, content: @escaping (T) -> Content) {
        self.items = items
        self.columnCount = columnCount
        self.content = content
    }
}
