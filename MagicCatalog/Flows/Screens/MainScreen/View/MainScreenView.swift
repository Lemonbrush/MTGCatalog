//
//  MainScreenView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 22.12.2022.
//

import SwiftUI

struct MainScreenView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: MainScreenViewModel
    
    @Environment(\.isSearching) private var isSearching: Bool
    
    @State var searchCardText: String = ""
    
    // MARK: - Private properties
    
    private let gridContentAdapter = MainScreenCollectionViewAdapter()
    
    // MARK: - Body view
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            GridStack(viewModel.contentCellModels) { cellViewModel in
                gridContentAdapter.createContentCell(cellViewModel)
            }
            
            Spacer(minLength: 50)
        }
        .padding(.horizontal, 5)
        .ignoresSafeArea(.all, edges: [.bottom, .leading, .trailing])
        .navigationTitle(viewModel.navigationTitle)
        .toolbar { menuButton }
        .searchable(text: $searchCardText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: searchCardText) { _ in cancelSearchIfNeeded() }
        .onSubmit(of: .search) { viewModel.didPressSearch(query: searchCardText) }
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
            gridMenuOption
            
            Button(action: {
                viewModel.updateContentGridType(.inline)
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
    
    private var gridMenuOption: some View {
        Menu {
            Button(action: {
                viewModel.updateContentGridType(.grid(columns: 1))
            }) {
                Label("1 column", systemImage: "square")
            }
            
            Button(action: {
                viewModel.updateContentGridType(.grid(columns: 2))
            }) {
                Label("2 columns", systemImage: "square.grid.2x2")
            }
            
            Button(action: {
                viewModel.updateContentGridType(.grid(columns: 3))
            }) {
                Label("3 columns", systemImage: "square.grid.3x2")
            }
            
            Button(action: {
                viewModel.updateContentGridType(.grid(columns: 4))
            }) {
                Label("4 columns", systemImage: "square.grid.4x3.fill")
            }
        } label: {
            HStack {
                Text("Grid")
                Spacer()
                Image(systemName: "square.grid.2x2")
            }
        }
    }
    
    // MARK: - Private functions
    
    private func cancelSearchIfNeeded() {
        if searchCardText.isEmpty && !isSearching {
            viewModel.didCancelSearch()
        }
    }
}
