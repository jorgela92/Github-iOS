//
//  RepositorieServiceHandler.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 12/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Foundation

protocol RepositorieServiceHandlerProtocol: AnyObject {
    func getRepositorieDetail(fullName: String, completion: @escaping (ResultResponse<RepositorieDetail?>) -> ())
}

final class RepositorieServiceHandler: BaseServiceHandler {
    private let baseServiceUrl = "repos"
}

//MARK: - CharactersServiceHandlerProtocol
extension RepositorieServiceHandler: RepositorieServiceHandlerProtocol {
    func getRepositorieDetail(fullName: String, completion: @escaping (ResultResponse<RepositorieDetail?>) -> ()) {
        ConnectionsManager.shared.request(getUrl(fullName: fullName), method: .get) { (result) in
            switch result {
            case .success(let data):
                guard let data = data else {
                    completion(ResultResponse.success(nil))
                    return
                }
                completion(ResultResponse.success(RepositorieDetail.getModelFrom(data)))
                break
                
            case .error(let error):
                completion(ResultResponse.error(error))
                break
            }
        }
    }
}

//MARK: - private methods -
extension RepositorieServiceHandler {
    private func getUrl(fullName: String) -> String {
        return getBaseUrl(baseServiceUrl + "/\(fullName)")
    }
}

