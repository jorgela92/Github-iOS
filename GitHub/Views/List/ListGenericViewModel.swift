//
//  RepositoriesViewModel.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 10/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Foundation
import UIKit

typealias ElementsCompletionHandler = () -> ()
typealias ElementsErrorHandler = (String) -> ()

protocol ListGenericViewModelDelegate: AnyObject {
    var listGenericModel: ListGenericModel { get set }
    var elementList: [RepositorieElement] { get }
    var elementSearchList: [ItemRepositorie] { get }
    func getProductElements(since: Int?, completion: @escaping ElementsCompletionHandler, failure: @escaping ElementsErrorHandler)
    func getProductElementSearch(text: String, completion: @escaping ElementsCompletionHandler, failure: @escaping ElementsErrorHandler)
    func detailElement(controller: ParentViewController, stringDetailElemetn: String)
}

protocol ListGenericManagerProtocol: AnyObject {
    associatedtype ServiceHandler
    var serviceHandler: ServiceHandler { get }
}

final class ListGenericViewModel {
    let manager: ListGenericViewModelDelegate
    weak var delegate: ListViewControllerDelegate?
    
    init(manager: ListGenericViewModelDelegate, delegate: ListViewControllerDelegate) {
        self.manager = manager
        self.delegate = delegate
    }
}

//MARK: - public methods -
extension ListGenericViewModel {
    func getTitleScreen() -> String {
        return manager.listGenericModel.title
    }
    
    func numberOfRows() -> Int {
        return getNumberElements() + (isSearch() ? 0 : getNumberPagination())
    }
    
    func getTypeCellsList() -> TypeCellsList {
        return manager.listGenericModel.typeCellList
    }
    
    func getName(index: Int) -> String {
        if isSearch() {
            return manager.listGenericModel.elementSearchModel[index].nameElement
        } else {
            return manager.listGenericModel.elementModel[index].nameElement
        }
    }
    
    func getRepositorieDescription(index: Int) -> String {
        if isSearch() {
            return manager.listGenericModel.elementSearchModel[index].repositorieDescriptionElement
        } else {
            return manager.listGenericModel.elementModel[index].repositorieDescriptionElement
        }
    }
    
    func getLogin(index: Int) -> String {
        if isSearch() {
            return manager.listGenericModel.elementSearchModel[index].loginElement
        } else {
            return manager.listGenericModel.elementModel[index].loginElement
        }
    }
    
    func getType(index: Int) -> UIImage? {
        if isSearch() {
            return manager.listGenericModel.elementSearchModel[index].typeElement
        } else {
            return manager.listGenericModel.elementModel[index].typeElement
        }
    }
    
    func getLastId() -> Int? {
        if isSearch() {
            return manager.elementSearchList.last?.id
        } else {
            return manager.elementList.last?.id
        }
    }
    
    func isPagination() -> Bool {
        return manager.listGenericModel.isPagintation
    }
    
    func setPagination(_ pagination: Bool) {
        manager.listGenericModel.isPagintation = pagination
    }
    
    func isSearch() -> Bool {
        return manager.listGenericModel.isSearch
    }
    
    func setSearch(_ search: Bool) {
        manager.listGenericModel.isSearch = search
    }
    
    func fetchData(since: Int? = nil) {
        manager.getProductElements(since: since, completion:{ [weak self] () in
                guard let weakself = self else { return }
                    weakself.delegate?.reloadTableView(isSearchClose: false)
                    weakself.setPagination(true)
            }, failure: { [weak self] (error) in
                guard let weakself = self else { return }
                    weakself.delegate?.errorFetchData(error: error)
                    weakself.setPagination(false)
            })
    }
    
    func searchData(_ text: String) {
        setSearch(true)
        manager.getProductElementSearch(text: text, completion:{ [weak self] () in
                guard let weakself = self else { return }
                    weakself.delegate?.reloadTableView(isSearchClose: false)
                    weakself.setPagination(false)
            }, failure: { [weak self] (error) in
                guard let weakself = self else { return }
                    weakself.setSearch(false)
                    weakself.delegate?.errorFetchData(error: error)
                    weakself.setPagination(false)
            })
    }
    
    func closeSearch() {
        setSearch(false)
        setPagination(true)
        delegate?.reloadTableView(isSearchClose: true)
    }
    
    func detailElement(viewController: ParentViewController, index: Int) {
        manager.detailElement(controller: viewController, stringDetailElemetn: isSearch() ? manager.listGenericModel.elementSearchModel[index].fullNameElement : manager.listGenericModel.elementModel[index].fullNameElement)
    }
}

//MARK: - private methods -
extension ListGenericViewModel {
    private func getNumberElements() -> Int {
        if isSearch() {
            return manager.listGenericModel.elementSearchModel.count
        } else {
            return manager.listGenericModel.elementModel.count
        }
    }
    
    private func getNumberPagination() -> Int {
        return (isPagination() && getNumberElements() != 0 ? 1 : 0)
    }
}
