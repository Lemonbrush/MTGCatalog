//
//  GridStack.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 28.12.2022.
//

import SwiftUI

protocol GridStackDelegate: AnyObject {
    func didItemAppeared(index: Int)
}

struct GridStack<CellViewModelType, Content: View>: View {
    
    // MARK: - Properties
    
    weak var delegate: GridStackDelegate?
    
    let columns: Int
    let hSpacing: CGFloat
    let vSpacing: CGFloat
    let content: (CellViewModelType) -> Content
    let viewModels: [CellViewModelType]
    let isLazyLoad: Bool
    
    // MARK: - Construction
    
    init(_ viewModels: [CellViewModelType],
         columns: Int = 1,
         hSpacing: CGFloat = 0,
         vSpacing: CGFloat = 0,
         isLazyLoad: Bool = false,
         @ViewBuilder content: @escaping (CellViewModelType) -> Content) {
        self.viewModels = viewModels
        self.columns = columns
        self.hSpacing = hSpacing
        self.vSpacing = vSpacing
        self.content = content
        self.isLazyLoad = isLazyLoad
    }

    // MARK: - Body view
    
    var body: some View {
        if isLazyLoad {
            LazyVStack(spacing: vSpacing) {
                gridRows
            }
        } else {
            VStack(spacing: vSpacing) {
                gridRows
            }
        }
    }
    
    // MARK: - Private body view
    
    private var gridRows: some View {
        ForEach(0 ... viewModels.count / columns , id: \.self) { row in
            HStack(spacing: hSpacing) {
                ForEach(0 ..< columns, id: \.self) { column in
                    createItem(row: row, column: column)
                        .onAppear {
                            didItemAppeared(row: row, column: column)
                        }
                }
            }
        }
    }
    
    private var spacerItem: some View {
        VStack {
            HStack { Spacer() }
            Spacer()
        }
    }
    
    // MARK: - Private properties
    
    private func didItemAppeared(row: Int, column: Int) {
        let currentIndex = calculateIndex(row: row, column: column)
        delegate?.didItemAppeared(index: currentIndex)
    }
    
    private func createItem(row: Int, column: Int) -> AnyView? {
        var view: AnyView? = nil
        
        let index = calculateIndex(row: row, column: column)
        if index < viewModels.count {
            let contentView = content(viewModels[index])
            view = AnyView(contentView)
        } else if columns > 1 {
            let spacer = spacerItem
            view = AnyView(spacer)
        }
        
        return view
    }
    
    private func calculateIndex(row: Int, column: Int) -> Int {
        return (row * columns) + column
    }
}
