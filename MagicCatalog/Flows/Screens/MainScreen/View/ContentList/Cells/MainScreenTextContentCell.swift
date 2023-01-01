//
//  MainScreenTextContentCell.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 01.01.2023.
//

import SwiftUI

struct MainScreenTextContentCell: View {
    
    // MARK: - Properties
    
    let text: String
    
    // MARK: - Body view
    
    var body: some View {
        HStack {
            Text(text).foregroundColor(.gray)
        }.padding(20)
    }
}

