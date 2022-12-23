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
    
    var backgroundGradient: LinearGradient = {
        let gradient = Gradient(colors: [Color(UIColor.brandDarkPurple),
                                         Color(UIColor.brandPurple)])
        return LinearGradient(gradient: gradient,
                              startPoint: .top,
                              endPoint: .bottom)
    }()
    
    // MARK: - Private properties
    
    private let cardViewModels: [CardCellViewModel] = [CardCellViewModel(id: 1)]
    
    // MARK: - Body view
    
    var body: some View {
        ZStack {
            QGrid(cardViewModels, columns: 1) { _ in
                CardCell(didPressButton: {
                    viewModel.didPressRandomCardButton()
                })
            }
            .navigationTitle(viewModel.navigationTitle)
            .toolbar { menuButton }
            .searchable(text: $searchCardText, placement: .navigationBarDrawer(displayMode: .always))
            .onSubmit {
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

struct CardCellViewModel : Codable, Identifiable {
  var id: Int
}

struct CardCell: View {
    
    // MARK: - Properties
    
    var didPressButton: () -> Void
    
    // MARK: - Body view
    
      var body: some View {
          VStack(spacing: 30) {
              Image(systemName:"rectangle.portrait.on.rectangle.portrait.fill")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 60, height: 60)
                  .foregroundColor(Color(UIColor.systemGray5))
              
              VStack(spacing: 10) {
                  Text("Find a card")
                      .font(.title.weight(.bold))
                  
                  VStack(spacing: 5) {
                      Text("Start searching for an mtg card or get a ")
                          .multilineTextAlignment(.center)
                          .foregroundColor(.gray)
                      Button(action: {
                          didPressButton()
                      }) {
                          Text("Random card")
                      }.foregroundColor(.blue)
                  }
              }
          }.frame(height: UIScreen.main.bounds.size.height / 1.5)
      }
}
