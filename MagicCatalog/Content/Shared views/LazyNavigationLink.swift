//
//  LazyNavigationLink.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 21.12.2022.
//

import SwiftUI

struct LazyNavigationLink<Destination>: View where Destination: View {
    let isActive: Binding<Bool>
    @ViewBuilder let destination: () -> Destination
    
    var body: some View {
        NavigationLink(isActive: isActive,
                       destination: { LazyLoadView(destination()) },
                       label: { EmptyView() })
    }
}
