//
//  InteractiveCardLoadingView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 25.12.2022.
//

import SwiftUI

struct InteractiveCardLoadingView : View {
    
    // MARK: - Properties
    
    @State var show = false
    
    var center = (UIScreen.main.bounds.width / 2) + 110
    
    //let cardSize: Card
    
    
    // MARK: - Body view
    
    var body : some View{
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 80, height: 110)
            .foregroundColor(.blue)
    }
}
