//
//  InteractiveCardLoadedStateModel.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 25.12.2022.
//

import UIKit

protocol InteractiveCardStateProtocol { }

struct InteractiveCardLoadingStateModel: InteractiveCardStateProtocol { }

struct InteractiveCardErrorStateModel: InteractiveCardStateProtocol { }

struct InteractiveCardLoadedStateModel: InteractiveCardStateProtocol {
    let frontFace: UIImage
    let backFace: UIImage?
}
