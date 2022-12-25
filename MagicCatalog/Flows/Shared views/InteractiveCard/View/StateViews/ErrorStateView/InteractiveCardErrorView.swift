//
//  InteractiveCardErrorView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 25.12.2022.
//

import SwiftUI

struct InteractiveCardErrorView: View {
    
    // MARK: - Properties
    
    //let cardSize: CardViewSize
    
    // MARK: - Body view
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 80, height: 110)
            .foregroundColor(.red)
    }
}
