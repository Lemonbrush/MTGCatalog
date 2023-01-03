//
//  MainScreenActivityIndicatorContentCell.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 03.01.2023.
//

import SwiftUI

struct MainScreenActivityIndicatorContentCell: View {
    
    // MARK: - Body view
    
    var body: some View {
        VStack {
            ProgressView()
        }.padding(20)
    }
}

