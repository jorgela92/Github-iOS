//
//  ListGenericModel.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 11/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

// MARK: - ListGenericModel
struct ListGenericModel {
    let title: String
    var elementModel: [ListGenericModelProtocol] = []
    var isPagintation: Bool = true
    var isSearch: Bool = false
    var elementSearchModel: [ListGenericModelProtocol] = []
    let typeCellList: TypeCellsList
    
    init(title: String, typeCellList: TypeCellsList) {
        self.title = title
        self.typeCellList = typeCellList
    }
}

enum TypeCellsList {
    case repositories
}

// MARK: - ElementModelProtocol
protocol ListGenericModelProtocol {
    var nameElement: String { get }
    var repositorieDescriptionElement: String { get }
    var loginElement: String { get }
    var fullNameElement: String { get }
    var typeElement: UIImage? { get }
}
