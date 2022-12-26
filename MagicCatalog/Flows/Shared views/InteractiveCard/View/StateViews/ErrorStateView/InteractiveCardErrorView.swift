//
//  InteractiveCardErrorView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 25.12.2022.
//

import SwiftUI

struct InteractiveCardErrorView: View {
    
    // MARK: - Private properties
    
    @State private var showingInfoAlert = false
    
    // MARK: - Body view
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10]))
                .foregroundColor(Color(UIColor.systemGray3))
        }
    }
}
