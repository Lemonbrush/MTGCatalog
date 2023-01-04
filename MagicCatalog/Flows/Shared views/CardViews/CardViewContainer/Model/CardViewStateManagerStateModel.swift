//
//  CardViewStateManagerStateModel.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 25.12.2022.
//

import UIKit

protocol CardViewStateManagerStateProtocol { }

struct CardViewStateManagerLoadingStateModel: CardViewStateManagerStateProtocol { }

struct CardViewStateManagerErrorStateModel: CardViewStateManagerStateProtocol { }

struct CardViewStateManagerLoadedStateModel: CardViewStateManagerStateProtocol {
    let frontFace: UIImage
    let backFace: UIImage?
    let cardViewType: CardViewType
}
