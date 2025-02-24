//
//  ScrollGridView.swift
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

import SwiftUI

struct ScrollGridView<Content: View, T: Identifiable>: View {
    var items: [T]
    var content: (T) -> Content
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(spacing: 8), GridItem(spacing: 8),
                    GridItem(spacing: 8),
                ],
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
}
