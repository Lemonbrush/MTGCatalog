//
//  Coordinator.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 21.12.2022.
//

import SwiftUI

protocol Coordinator: ObservableObject {
    associatedtype NavigationItem: Equatable
    
    var navigationStack: [(NavigationItem, Any)] { get set }
}

extension Coordinator {
    func isActive(_ item: NavigationItem) -> Binding<Bool> {
        return .constant(navigationStack.contains(where: { $0.0 == item }))
    }
    
    func viewModel<T: ObservableObject>(for item: NavigationItem) -> T {
        guard let strongItem = navigationStack.first(where: { $0.0 == item }) else {
            fatalError("Item is not in stack")
        }
        
        guard let viewModel = strongItem.1 as? T else {
            fatalError("View model type is not correct")
        }
        return viewModel
    }
    
    func pushToNavigationStack(_ item: NavigationItem, viewModel: Any) {
        navigationStack.append((item, viewModel))
    }
    
    func popFromNavigationStack() {
        navigationStack.removeLast()
    }
}

