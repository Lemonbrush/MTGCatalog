//
//  MainScreenView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 22.12.2022.
//

import SwiftUI
import QGrid

struct MainScreenView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: MainScreenViewModel
    
    @State var searchCardText: String = ""
    @State var shouldShowSearchButton = false
    @State var isSearchEmpty = true
    
    // MARK: - Private properties
    
    private let contentAdapter = MainScreenCollectionViewAdapter()
    
    // MARK: - Construction
    
    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        contentAdapter.delegate = viewModel
    }
    
    // MARK: - Body view
    
    var body: some View {
        VStack {
            QGrid(viewModel.cardViewModels, columns: viewModel.contentGridColumns) { cellModel in
                contentAdapter.getCell(cellModel)
            }.ignoresSafeArea(.all, edges: [.bottom, .leading, .trailing])
            .navigationTitle(viewModel.navigationTitle)
            .toolbar { menuButton }
            .searchable(text: $searchCardText, placement: .navigationBarDrawer(displayMode: .always))
            .onSubmit(of: .search) {
                viewModel.didPressSearch(query: searchCardText)
            }
        }
    }
    
    // MARK: - Private body views
    
    private var menuButton: some View {
        Menu {
            Button(action: {
                // Action
            }) {
                Label("All Sets", systemImage: "crown")
            }
            
            Button(action: {
                // Action
            }) {
                Label("Random Card", systemImage: "rectangle.portrait.on.rectangle.portrait")
            }
            
            Button(action: {
                // Action
            }) {
                Label("Key words dictionary", systemImage: "questionmark.circle")
            }
            
            Divider()
            
            Button(action: {
                // Action
            }) {
                Label("Advanced search", systemImage: "list.bullet.rectangle")
            }
            
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }
}
