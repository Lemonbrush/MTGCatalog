//
//  MainScreenButton.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 22.12.2022.
//

import SwiftUI

struct MainScreenButton: View {
    
    // MARK: - Private properties
    
    private let text: String
    private let buttonAction: () -> Void
    private let backgroundButtonColor: Color
    private let textColor: Color
    
    // MARK: - Construction
    
    init(text: String,
         backgroundButtonColor: Color = .blue,
         textColor: Color = .white,
         buttonAction: @escaping () -> Void) {
        self.text = text
        self.backgroundButtonColor = backgroundButtonColor
        self.textColor = textColor
        self.buttonAction = buttonAction
    }
    
    // MARK: - Body view
    
    var body: some View {
        Button(action: {
            buttonAction()
        }, label: {
            Text(text).bold()
        }).padding([.top, .bottom], 15)
            .padding([.leading, .trailing], 30)
            .frame(maxWidth: .infinity)
            .background(backgroundButtonColor)
            .foregroundColor(textColor)
            .cornerRadius(10)
    }
}
