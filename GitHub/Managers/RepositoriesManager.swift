//
//  RepositoriesManager.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 10/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Foundation
import UIKit

final class RepositoriesManager {
    
    let serviceHandler: RepositoriesServiceHandler
    var listGenericModel: ListGenericModel
    var elementList: [RepositorieElement] = []
    var elementSearchList: [ItemRepositorie] = []
    
    private let TITLE = "repositories"
    private let ERROR_ELEMENTS = "not_elements"
    private let ERROR_ELEMENTS_SEARCH = "not_elements_search"
    
    init(serviceHandler: RepositoriesServiceHandler) {
        self.serviceHandler = serviceHandler
        listGenericModel = ListGenericModel(title: TITLE.localized, typeCellList: .repositories)
    }
}

// MARK: - ListGenericManagerProtocol
extension RepositoriesManager: ListGenericManagerProtocol {
    typealias ServiceHandler = RepositoriesServiceHandler
    
    func setElementModel(elementModel: [ListGenericModelProtocol]) {
        if listGenericModel.isSearch {
            listGenericModel.elementSearchModel.append(contentsOf: elementModel)
        } else {
            listGenericModel.elementModel.append(contentsOf: elementModel)
        }
    }
}

// MARK: - ListGenericViewModelDelegate
extension RepositoriesManager: ListGenericViewModelDelegate {
    func getProductElements(since: Int? = nil, completion: @escaping ElementsCompletionHandler, failure: @escaping ElementsErrorHandler) {
        serviceHandler.getRepositories(since: since) { [weak self](response) in
            guard let weakself = self else { return }
            switch response {
            case .success(let model):
                if let model = model {
                    weakself.setElementModel(elementModel: model)
                    weakself.elementList.append(contentsOf: model)
                    if weakself.elementList.count == 0 {
                        failure(weakself.ERROR_ELEMENTS.localized)
                    }
                    completion()
                } else {
                    failure(weakself.ERROR_ELEMENTS.localized)
                }
                break
                
            case .error(let error):
                failure(error.message)
                break
            }
        }
    }
    
    func getProductElementSearch(text: String, completion: @escaping ElementsCompletionHandler, failure: @escaping ElementsErrorHandler) {
        listGenericModel.elementSearchModel.removeAll()
        elementSearchList.removeAll()
        serviceHandler.getSearchRepositories(search: text){ [weak self](response) in
            guard let weakself = self else { return }
            switch response {
            case .success(let model):
                if let model = model {
                    let items = model.items.filter { !($0.itemPrivate ?? true) }
                    weakself.setElementModel(elementModel: items)
                    weakself.elementSearchList.append(contentsOf: items)
                    if weakself.elementSearchList.count == 0 {
                        failure(weakself.ERROR_ELEMENTS_SEARCH.localized)
                    }
                    completion()
                } else {
                    failure(weakself.ERROR_ELEMENTS_SEARCH.localized)
                }
                break
                
            case .error(let error):
                failure(error.message)
                break
            }
        }
    }
    
    func detailElement(controller: ParentViewController, stringDetailElemetn: String) {
        controller.openDetailGenericViewController(manager: RepositorieDetailManager(serviceHandler: RepositorieServiceHandler(), textDetail: stringDetailElemetn))
    }
}

// MARK: - RepositorieElement - ListGenericModelProtocol
extension RepositorieElement: ListGenericModelProtocol {
    var nameElement: String {
        return name.uppercased()
    }
    
    var repositorieDescriptionElement: String {
        return repositorieDescription ?? ""
    }
    
    var loginElement: String {
        return owner.login.capitalized
    }
    
    var typeElement: UIImage? {
        return owner.getTypeImage()
    }
    
    var fullNameElement: String {
        return fullName
    }
}

// MARK: - ItemRepositorie - ListGenericModelProtocol
extension ItemRepositorie: ListGenericModelProtocol {
    var nameElement: String {
        return name?.uppercased() ?? ""
    }
    
    var repositorieDescriptionElement: String {
        return itemDescription ?? ""
    }
    
    var loginElement: String {
        return owner?.login.capitalized ?? ""
    }
    
    var typeElement: UIImage? {
        return owner?.getTypeImage()
    }
    
    var fullNameElement: String {
        return fullName ?? ""
    }
}
