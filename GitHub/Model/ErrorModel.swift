//
//  ErrorModel.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 10/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Foundation

// MARK: - ErrorModel
public struct ErrorModel: Decodable {
    let code: String
    let message: String
    let httpCode: Int
    
    public init(code: String, message: String, httpCode:Int) {
        self.code = code
        self.message = message
        self.httpCode = httpCode
    }
}
