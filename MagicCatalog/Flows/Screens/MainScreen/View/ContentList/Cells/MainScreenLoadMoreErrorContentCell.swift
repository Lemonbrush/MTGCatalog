//
//  MainScreenLoadMoreErrorContentCell.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 03.01.2023.
//

import SwiftUI

struct MainScreenLoadMoreErrorContentCell: View {
    
    // MARK: - Properties
    
    let text: String
    let systemImageName: String
    
    // MARK: - Body view
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.pink)
            
            HStack(spacing: 30) {
                HStack(spacing: 20) {
                    Image(systemName: systemImageName)
                        .foregroundColor(.white)
                    
                    Text(text)
                        .bold()
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "arrow.clockwise").foregroundColor(.white)
                }
            }
            .padding(20)
        }
        .padding([.top, .bottom], 20)
    }
}


struct MainScreenLoadMoreErrorContentCell_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenLoadMoreErrorContentCell(text: "Lost connection", systemImageName: "wifi.slash")
    }
}
