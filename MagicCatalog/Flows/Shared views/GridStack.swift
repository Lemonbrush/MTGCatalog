//
//  GridStack.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 28.12.2022.
//

import SwiftUI

struct GridStack<CellViewModelType, Content: View>: View {
    
    // MARK: - Properties
    
    let columns: Int
    let hSpacing: CGFloat
    let vSpacing: CGFloat
    let content: (CellViewModelType) -> Content
    let viewModels: [CellViewModelType]

    // MARK: - Body view
    
    var body: some View {
        VStack(spacing: vSpacing) {
            ForEach(0 ... viewModels.count / columns , id: \.self) { row in
                HStack(spacing: hSpacing) {
                    ForEach(0 ..< columns, id: \.self) { column in
                        if let index = calculateIndex(row: row, column: column),
                            index < viewModels.count {
                            content(viewModels[index])
                        } else if columns > 1 {
                            VStack {
                                HStack { Spacer() }
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Construction
    
    init(_ viewModels: [CellViewModelType],
         columns: Int = 1,
         hSpacing: CGFloat = 0,
         vSpacing: CGFloat = 0,
         @ViewBuilder content: @escaping (CellViewModelType) -> Content) {
        self.viewModels = viewModels
        self.columns = columns
        self.hSpacing = hSpacing
        self.vSpacing = vSpacing
        self.content = content
    }
    
    // MARK: - Private properties
    
    private func calculateIndex(row: Int, column: Int) -> Int {
        return (row * columns) + column
    }
}
