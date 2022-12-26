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
    
    @Environment(\.isSearching) private var isSearching: Bool
    @Environment(\.dismissSearch) private var dismissSearch
    
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
            .onChange(of: searchCardText) { value in
                if searchCardText.isEmpty && !isSearching {
                    viewModel.didCancelSearch()
                }
            }
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
                viewModel.showRandomCardReviewScreen()
            }) {
                Label("Random Card", systemImage: "rectangle.portrait.on.rectangle.portrait")
            }
            
            Button(action: {
                // Action
            }) {
                Label("Key words dictionary", systemImage: "questionmark.circle")
            }
            
            Divider()
            
            groupMenu
            
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
    
    private var groupMenu: some View {
        Menu {
            Button(action: {
                // Action
            }) {
                Label("1 column", systemImage: "square")
            }
            
            Button(action: {
                // Action
            }) {
                Label("2 columns", systemImage: "square.grid.2x2")
            }
            
            Button(action: {
                // Action
            }) {
                Label("3 columns", systemImage: "square.grid.3x3")
            }
            
            Button(action: {
                // Action
            }) {
                Label("Inline", systemImage: "list.bullet")
            }
        } label: {
            HStack {
                Text("View style")
                Spacer()
                Image(systemName: "square.grid.2x2")
            }
        }
    }
}
