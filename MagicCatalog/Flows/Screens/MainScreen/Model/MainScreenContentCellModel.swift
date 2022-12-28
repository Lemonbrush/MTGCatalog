//
//  MainScreenContentCellModel.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 28.12.2022.
//

import SwiftUI

protocol MainScreenContentCell { }

struct MainScreenGridContentCellModel: MainScreenContentCell {
    let viewModels: [MainScreenCellModel]
    let columns: Int
    let hSpacing: Int
    let vStack: Int
}

struct MainScreenSearchContentCellModel: MainScreenContentCell {}
