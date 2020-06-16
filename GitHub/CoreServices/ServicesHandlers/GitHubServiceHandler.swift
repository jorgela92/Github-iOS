//
//  GitHubServiceHandler.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 10/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Foundation

protocol GitHubServiceHandlerProtocol: AnyObject {
    func getRepositories(since: Int?, completion: @escaping (ResultResponse<[RepositorieElement]?>) -> ())
    func getSearchRepositories(search: String, completion: @escaping (ResultResponse<[RepositorieElement]?>) -> ())
}

final class RepositoriesServiceHandler: BaseServiceHandler {
    private let baseServiceUrl = "repositories"
}

//MARK: - CharactersServiceHandlerProtocol
extension RepositoriesServiceHandler: GitHubServiceHandlerProtocol {
    func getRepositories(since: Int?, completion: @escaping (ResultResponse<[RepositorieElement]?>) -> ()) {
        ConnectionsManager.shared.request(getUrl(since: since), method: .get) { (result) in
            switch result {
            case .success(let data):
                guard let data = data else {
                    completion(ResultResponse.success(nil))
                    return
                }
                completion(ResultResponse.success(RepositorieElement.getRepositoriesArray(data)))
                break
                
            case .error(let error):
                completion(ResultResponse.error(error))
                break
            }
        }
    }
    
    func getSearchRepositories(search: String, completion: @escaping (ResultResponse<[RepositorieElement]?>) -> ()) {
        ConnectionsManager.shared.request(getSearchUrl(search), method: .get) { (result) in
            switch result {
            case .success(let data):
                guard let data = data else {
                    completion(ResultResponse.success(nil))
                    return
                }
                completion(ResultResponse.success(RepositorieElement.getRepositoriesArray(data)))
                break
                
            case .error(let error):
                completion(ResultResponse.error(error))
                break
            }
        }
    }
}

//MARK: - private methods -
extension RepositoriesServiceHandler {
    private func getUrl(since: Int? = nil) -> String {
        return getBaseUrl(baseServiceUrl + (since != nil ? "?since=\(since!)" : ""))
    }
    
    private func getSearchUrl(_ search: String) -> String {
        return getBaseUrl("search/" + baseServiceUrl + "?q=\(search)")
    }
}

