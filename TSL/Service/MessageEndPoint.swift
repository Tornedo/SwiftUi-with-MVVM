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
        "http://127.0.0.1:5000/api"
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
        [
            "X-Api-Key": RegistrationViewModel.apiKey,
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getMessage: return .post
        case .saveMessage(_): return .get
        }
    }
}
