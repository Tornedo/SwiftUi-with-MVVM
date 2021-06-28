//
//  MessageEndPoint.swift
//  TSL
//
//  Created by Chayon Ahmed on 6/24/21.
//  Copyright © 2021 Chayon Ahmed. All rights reserved.
//

import Foundation

enum MessageEndPoint {
    case getMessage
    case saveMessage(_ message: String)
}

extension MessageEndPoint: APIEndPoint {
    var baseURL: String {
        "https://tslwallapp.herokuapp.com/api"
    }

    var absoluteURL: String {
        switch self {
        case .getMessage:
            return baseURL + "/messages"
        case .saveMessage(_):
            return baseURL + "/messages"
        }
    }

    var params: [String : String] {
        switch self {
        case .getMessage:
            return [:]
        case .saveMessage(let message):
            return ["message": message]
        }
    }

    var headers: [String : String] {
        
        switch self {
        case .getMessage:
            return [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
        case .saveMessage(_):
            let hello = ""
            let loginString = String(format: "%@:%@", RegistrationViewModel.apiKey, hello)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            return ["Authorization": "Basic \(base64LoginString)", "Content-Type": "application/json", "Accept": "application/json"]
        }

    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getMessage: return .get
        case .saveMessage(_): return .post
        }
    }
}
