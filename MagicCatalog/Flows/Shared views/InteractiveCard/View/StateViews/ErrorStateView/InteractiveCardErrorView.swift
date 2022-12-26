//
//  InteractiveCardErrorView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 25.12.2022.
//

import SwiftUI

struct InteractiveCardErrorView: View {
    
    // MARK: - Properties
    
    @State private var showingInfoAlert = false
    
    // MARK: - Body view
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10]))
                .frame(width: 80, height: 110)
                .foregroundColor(Color(UIColor.systemGray3))
        }
    }
}
