//
//  RepositorieDetailManager.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 12/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Foundation
import UIKit

final class RepositorieDetailManager {
    
    let serviceHandler: RepositorieServiceHandler
    var detailGenericModel: DetailGenericModel
    private let TITLE = "detail"
    
    init(serviceHandler: RepositorieServiceHandler, textDetail: String) {
        self.serviceHandler = serviceHandler
        detailGenericModel = DetailGenericModel(title: TITLE.localized, textDetail: textDetail, typeDetail: .repositorie)
    }
}

// MARK: - ListGenericManagerProtocol
extension RepositorieDetailManager: DetailGenericManagerProtocol {
    typealias ServiceHandler = RepositorieServiceHandler
    
    func setElementModel(elementModel: RepositorieDetail) {
        setHeader(elementModel: elementModel)
        setCells(elementModel: elementModel)
    }
}

//MARK: - private methods -
extension RepositorieDetailManager {
    private func setHeader(elementModel: RepositorieDetail) {
        detailGenericModel.detailHeaderGenericModel = DetailHeaderGenericModel(titleElement: elementModel.name?.uppercased() ?? "", subtitleElement: elementModel.owner?.login.capitalized ?? "", imageElement: elementModel.owner?.avatarURL ?? "", type: elementModel.owner?.getTypeImage())
    }
    
    private func setCells(elementModel: RepositorieDetail) {
        if let repositorieDetailDescription = elementModel.repositorieDetailDescription, "" != repositorieDetailDescription {
            detailGenericModel.cellsDetail.append(DetailCellGenericModel(titleElement: "detail".localized, detailElement: repositorieDetailDescription, tipeCellElement: .baseCell))
        }
        if let language = elementModel.language, "" != language {
            detailGenericModel.cellsDetail.append(DetailCellGenericModel(titleElement: "language".localized, detailElement: language, tipeCellElement: .baseCell))
        }
        if let licenseName = elementModel.license?.name, "" != licenseName {
            detailGenericModel.cellsDetail.append(DetailCellGenericModel(titleElement: "license".localized, detailElement: licenseName, tipeCellElement: .baseCell))
        }
        if let createdAt = elementModel.createdAt?.getDateFormat, "" != createdAt {
            detailGenericModel.cellsDetail.append(DetailCellGenericModel(titleElement: "created_at".localized, detailElement:  createdAt, tipeCellElement: .baseCell))
        }
        if let updatedAt = elementModel.updatedAt?.getDateFormat, "" != updatedAt {
            detailGenericModel.cellsDetail.append(DetailCellGenericModel(titleElement: "updated_at".localized, detailElement: updatedAt, tipeCellElement: .baseCell))
        }
        if let pushedAt = elementModel.pushedAt?.getDateFormat, "" != pushedAt {
            detailGenericModel.cellsDetail.append(DetailCellGenericModel(titleElement: "pushed_at".localized, detailElement: pushedAt, tipeCellElement: .baseCell))
        }
        if let openIssuesCount = elementModel.openIssuesCount {
            detailGenericModel.cellsDetail.append(DetailCellGenericModel(titleElement: "open_issues_count".localized, detailElement: "\(openIssuesCount)", tipeCellElement: .baseCell))
        }
        if let forksCount = elementModel.forksCount {
            detailGenericModel.cellsDetail.append(DetailCellGenericModel(titleElement: "forks_count".localized, detailElement: "\(forksCount)", tipeCellElement: .baseCell))
        }
        if let forks = elementModel.forks {
            detailGenericModel.cellsDetail.append(DetailCellGenericModel(titleElement: "forks".localized, detailElement: "\(forks)", tipeCellElement: .baseCell))
        }
        if let forksCount = elementModel.forksCount {
            detailGenericModel.cellsDetail.append(DetailCellGenericModel(titleElement: "forks_count".localized, detailElement: "\(forksCount)", tipeCellElement: .baseCell))
        }
        if let openIssues = elementModel.openIssues {
            detailGenericModel.cellsDetail.append(DetailCellGenericModel(titleElement: "open_issues".localized, detailElement: "\(openIssues)", tipeCellElement: .baseCell))
        }
        if let watchers = elementModel.watchers {
            detailGenericModel.cellsDetail.append(DetailCellGenericModel(titleElement: "watchers".localized, detailElement: "\(watchers)", tipeCellElement: .baseCell))
        }
        if let networkCount = elementModel.networkCount {
            detailGenericModel.cellsDetail.append(DetailCellGenericModel(titleElement: "network_count".localized, detailElement: "\(networkCount)", tipeCellElement: .baseCell))
        }
        if let subscribersCount = elementModel.subscribersCount {
            detailGenericModel.cellsDetail.append(DetailCellGenericModel(titleElement: "subscribers_count".localized, detailElement: "\(subscribersCount)", tipeCellElement: .baseCell))
        }
        if let htmlURL = elementModel.htmlURL, "" != htmlURL {
            detailGenericModel.cellsDetail.append(DetailCellGenericModel(titleElement: "html_url".localized, detailElement: htmlURL, tipeCellElement: .webCell))
        }
        if let cloneURL = elementModel.cloneURL, "" != cloneURL {
            detailGenericModel.cellsDetail.append(DetailCellGenericModel(titleElement: "clone_url".localized, detailElement: cloneURL, tipeCellElement: .webCell))
        }
        if let homepage = elementModel.homepage, "" != homepage {
            detailGenericModel.cellsDetail.append(DetailCellGenericModel(titleElement: "homepage".localized, detailElement: homepage, tipeCellElement: .webCell))
        }
    }
}

// MARK: - ListGenericViewModelDelegate
extension RepositorieDetailManager: DetailGenericViewModelDelegate {
    func getDetailElement(text: String, completion: @escaping ElementsCompletionHandler, failure: @escaping ElementsErrorHandler) {
        serviceHandler.getRepositorieDetail(fullName: text){ [weak self] (response) in
            guard let weakself = self else { return }
            switch response {
            case .success(let model):
                if let model = model {
                    weakself.setElementModel(elementModel: model)
                    completion()
                } else {
                    failure("not_elements".localized)
                }
                break
                
            case .error(let error):
                failure(error.message)
                break
            }
        }
    }
}
