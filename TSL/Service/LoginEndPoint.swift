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
    case apiToken
}

extension LoginEndPoint: APIEndPoint {
    var baseURL: String {
        "http://127.0.0.1:5000/api"
    }

    var absoluteURL: String {
        baseURL + "/users"
    }

    var params: [String : String] {
        switch self {
        case .registration(let userName, let password):
            return ["username": userName, "password": password]
        case .login(let userName, let password):
            return ["username": userName, "password": password]
        case .apiToken:
            return [:]
        }
    }

    var headers: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }

    var httpMethod: HTTPMethod {
        .post
    }
}
