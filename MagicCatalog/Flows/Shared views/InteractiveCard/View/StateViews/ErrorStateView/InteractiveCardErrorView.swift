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
        Button {
            showingInfoAlert = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10]))
                    .frame(width: 80, height: 110)
                    .foregroundColor(Color(UIColor.systemGray3))
                
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .foregroundColor(Color(UIColor.systemGray3))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
            }
        }.alert("Failed to download card image :(", isPresented: $showingInfoAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}
