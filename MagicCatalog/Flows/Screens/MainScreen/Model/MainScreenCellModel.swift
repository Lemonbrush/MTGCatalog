//
//  MainScreenCellModel.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import UIKit

protocol MainScreenCellModelProtocol { }

struct MainScreenCellModel: Identifiable {
    var id: Int
    let model: MainScreenCellModelProtocol
}

struct MainScreenErrorCellModel: MainScreenCellModelProtocol {
    let image: UIImage?
    let topText: String
    let bottomText: String
    let buttonLabelText: String
}

struct MainScreenCardCellModel: MainScreenCellModelProtocol {
    let imageName: String
    let cardTitle: String
    let cardType: String
}
