//
//  LoginEndPoint.swift
//  TSL
//
//  Created by Chayon Ahmed on 6/24/21.
//  Copyright © 2021 Chayon Ahmed. All rights reserved.
//

import Foundation

enum LoginEndPoint {
    case registration(userName: String, password: String)
    case login(userName: String, password: String)
}

extension LoginEndPoint: APIEndPoint {
    var baseURL: String {
        "https://tslwallapp.herokuapp.com/api"
    }

    var absoluteURL: String {
        switch self {
        case .registration(_, _):
            return baseURL + "/users"
        case .login(_, _):
           return baseURL + "/token"
        }
    }

    var params: [String : String] {
        switch self {
        case .registration(let userName, let password):
            return ["username": userName, "password": password]
        case .login(let userName, let password):
            return [:]
        }
    }

    var headers: [String : String] {
        switch self {
        case .registration(let _, let _):
            return ["Content-Type": "application/json", "Accept": "application/json"]
        case .login(let userName, let password):
            let loginString = String(format: "%@:%@", userName, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            return ["Authorization": "Basic \(base64LoginString)"]
        }

    }

    var httpMethod: HTTPMethod {
        switch self {
        case .registration(_, _):
            return .post
        default:
            return .get
        }
    }
}
