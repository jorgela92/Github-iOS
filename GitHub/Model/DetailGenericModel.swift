//
//  DetailGenericModel.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 12/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Foundation
import UIKit

// MARK: - RepositoriesSeacrh
struct DetailGenericModel {
    let title, textDetail: String
    var detailHeaderGenericModel: DetailHeaderGenericModel?
    var cellsDetail: [DetailCellGenericModel]
    let typeDetail: TypeDetail
    
    init(title: String, textDetail: String, typeDetail: TypeDetail) {
        self.title = title
        self.textDetail = textDetail
        self.cellsDetail = []
        self.typeDetail = typeDetail
    }
}

enum TypeDetail {
    case repositorie
}

// MARK: - DetailCellGenericModel
struct DetailHeaderGenericModel {
    let titleElement: String
    let subtitleElement: String
    let imageElement: String
    let type: UIImage?
    
    init(titleElement: String, subtitleElement: String, imageElement: String, type: UIImage?) {
        self.titleElement = titleElement
        self.subtitleElement = subtitleElement
        self.imageElement = imageElement
        self.type = type
    }
}

// MARK: - DetailCellGenericModel
struct DetailCellGenericModel {
    var titleElement: String
    var detailElement: String
    var tipeCellElement: TypeCellsDetail
    
    init(titleElement: String, detailElement: String, tipeCellElement: TypeCellsDetail) {
        self.titleElement = titleElement
        self.detailElement = detailElement
        self.tipeCellElement = tipeCellElement
    }
}

enum TypeCellsDetail {
    case baseCell
    case webCell
}
