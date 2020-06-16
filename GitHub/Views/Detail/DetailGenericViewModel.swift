//
//  DetailViewModel.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 12/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Foundation
import UIKit

protocol DetailGenericViewModelDelegate: AnyObject {
    var detailGenericModel: DetailGenericModel { get set }
    func getDetailElement(text: String, completion: @escaping ElementsCompletionHandler, failure: @escaping ElementsErrorHandler)
}

protocol DetailGenericManagerProtocol: AnyObject {
    associatedtype ServiceHandler
    var serviceHandler: ServiceHandler { get }
}

final class DetailGenericViewModel {
    let manager: DetailGenericViewModelDelegate
    weak var delegate: DetailGenericViewControllerDelegate?
    
    init(manager: DetailGenericViewModelDelegate, delegate: DetailGenericViewControllerDelegate) {
        self.manager = manager
        self.delegate = delegate
    }
}

//MARK: - public methods -
extension DetailGenericViewModel {
    func getTitleScreen() -> String {
        return manager.detailGenericModel.title
    }
    
    func numberOfRows() -> Int {
        return manager.detailGenericModel.cellsDetail.count
    }
    
    func getTypeCell(_ index: Int) -> TypeCellsDetail {
        return manager.detailGenericModel.cellsDetail[index].tipeCellElement
    }
    
    func getTypeDetail() -> TypeDetail {
        return manager.detailGenericModel.typeDetail
    }
    
    func getTitleCell(_ index: Int) -> String {
        return manager.detailGenericModel.cellsDetail[index].titleElement
    }
    
    func getSubtitleCell(_ index: Int) -> String {
        return manager.detailGenericModel.cellsDetail[index].detailElement
    }
    
    func getTitleHeader() -> String? {
        return manager.detailGenericModel.detailHeaderGenericModel?.titleElement
    }
    
    func getSubtitleHeader() -> String? {
        return manager.detailGenericModel.detailHeaderGenericModel?.subtitleElement
    }
    
    func getTypeHeader() -> UIImage? {
        return manager.detailGenericModel.detailHeaderGenericModel?.type
    }
    
    func getImageHeader() -> String {
        return manager.detailGenericModel.detailHeaderGenericModel?.imageElement ?? ""
    }
    
    func fetchData() {
        manager.getDetailElement(text: manager.detailGenericModel.textDetail, completion:{ [weak self] () in
            guard let weakself = self else { return }
                weakself.delegate?.reloadTableView()
        }, failure: { [weak self] (error) in
            guard let weakself = self else { return }
                weakself.delegate?.errorFetchData(error: error)
        })
    }
}
