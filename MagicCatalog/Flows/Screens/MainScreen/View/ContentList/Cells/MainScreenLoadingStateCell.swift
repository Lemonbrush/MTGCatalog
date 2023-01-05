//
//  MainScreenLoadingStateCell.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 06.01.2023.
//

import SwiftUI

struct MainScreenLoadingStateCell: View {
    
    @State var text: String = ""
    let finalText: String
    
    // MARK: - Body view
    
    var body: some View {
        HStack(spacing: 20) {
            ProgressView()
            
            Text(text)
                .foregroundColor(.gray)
                .onAppear {
                    typeWriter()
                }
        }
    }
    
    // MARK: - Private functions
    
    func typeWriter(at position: Int = 0) {
        guard position < finalText.count else {
            text = ""
            typeWriter(at: 0)
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            text.append(finalText[finalText.index(finalText.startIndex, offsetBy: position)])
            typeWriter(at: position + 1)
        }
    }
}

struct MainScreenLoadingStateCell_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenLoadingStateCell(finalText: "Searching for cards...")
    }
}
