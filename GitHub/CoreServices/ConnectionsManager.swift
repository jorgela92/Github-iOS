//
//  ConnectionsManager.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 10/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseUrlProtocol: AnyObject {
    var baseUrlDEV: String { get }
}

public enum ResultResponse<T> {
    case success(T)
    case error(ErrorModel)
}

public class BaseServiceHandler: NSObject, BaseUrlProtocol {
    
    let baseUrlDEV = "https://api.github.com/"
    
    func getBaseUrl(_ path: String) -> String {
        return baseUrlDEV + path
    }
}

class ConnectionsManager: NSObject {
    
    static let shared: ConnectionsManager = {
        return ConnectionsManager()
    }()
    
    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping(ResultResponse<Data?>) -> ()) {
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).response { (response) in
            switch response.result {
            case .success(let data):
                if response.response?.statusCode != 200 {
                    var code = ""
                    var message = ""
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                            if let codeString = json["documentation_url"] as? String {
                                code = codeString
                            }
                            if let messageString = json["message"] as? String {
                                message = messageString
                            }
                        }
                    } catch let error as NSError {
                        message = error.localizedDescription
                    }
                    completion(ResultResponse.error(ErrorModel(code: code, message: message, httpCode: response.response?.statusCode ?? 0)))
                    return
                }
                completion(ResultResponse.success(data))
                break
            case .failure(let error):
                completion(ResultResponse.error(ErrorModel(code: error.responseContentType ?? "", message: error.errorDescription ?? "", httpCode: response.response?.statusCode ?? 0)))
                break
            }
        }
    }
}
