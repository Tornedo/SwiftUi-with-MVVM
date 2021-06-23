//
//  ApiEndPoint.swift
//  TSL
//
//  Created by Chayon Ahmed on 6/24/21.
//  Copyright © 2021 Chayon Ahmed. All rights reserved.
//

import Foundation

protocol APIEndPoint {
    var baseURL: String { get }
    var absoluteURL: String { get }
    var params: [String: String] { get }
    var headers: [String: String] { get }
    var httpMethod: HTTPMethod { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
