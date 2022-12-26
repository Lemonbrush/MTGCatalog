//
//  InteractiveCardLoadedStateModel.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 25.12.2022.
//

import UIKit

protocol InteractiveCardStateProtocol { }

struct InteractiveCardLoadingStateModel: InteractiveCardStateProtocol {
    let cardSize: CardViewSize
}

struct InteractiveCardErrorStateModel: InteractiveCardStateProtocol { }

struct InteractiveCardLoadedStateModel: InteractiveCardStateProtocol {
    let image: UIImage
    let cardSize: CardViewSize
}