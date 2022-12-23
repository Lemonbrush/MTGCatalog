//
//  ScrollViewOffset.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 21.12.2022.
//

import SwiftUI

private struct OffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

struct ScrollViewOffset<Content: View>: View {
  let content: () -> Content
    let onOffsetChange: (CGFloat) -> Void
    let showsIndicators: Bool

    init(showsIndicators: Bool = true,
        @ViewBuilder content: @escaping () -> Content,
        onOffsetChange: @escaping (CGFloat) -> Void
      ) {
        self.showsIndicators = showsIndicators
        self.content = content
        self.onOffsetChange = onOffsetChange
      }

  var body: some View {
    ScrollView(showsIndicators: showsIndicators) {
      offsetReader
      content()
        .padding(.top, -8) // 👈🏻 places the real content as if our `offsetReader` was not there.
    }
    .coordinateSpace(name: "frameLayer")
    .onPreferenceChange(OffsetPreferenceKey.self, perform: onOffsetChange)
  }

  var offsetReader: some View {
    GeometryReader { proxy in
      Color.clear
        .preference(
          key: OffsetPreferenceKey.self,
          value: proxy.frame(in: .named("frameLayer")).minY
        )
    }
    .frame(height: 0)
  }
}
