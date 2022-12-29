//
//  MainScreenContentCellModel.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 28.12.2022.
//

import SwiftUI

protocol MainScreenContentCell { }

struct MainScreenSearchContentCellModel: MainScreenContentCell { }

struct MainScreenGridContentCellModel: MainScreenContentCell {
    let viewModels: [CardsGridCellModel]
    let columns: Int
    let hSpacing: Int = 5
    let vStack: Int = 5
}

struct MainScreenStubContentCellModel: MainScreenContentCell {
    let image: UIImage?
    let topText: String
    let bottomText: String
    let buttonLabelText: String
}
