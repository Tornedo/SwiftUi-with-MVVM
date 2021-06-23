//
//  APIProvider.swift
//  TSL
//
//  Created by Chayon Ahmed on 6/24/21.
//  Copyright © 2021 Chayon Ahmed. All rights reserved.
//

import Foundation
import Combine

class APIProvider<EndPoint: APIEndPoint> {
    func getData(from endPoint: EndPoint) -> AnyPublisher<Data, Error> {
        guard let request = performRequest(for: endPoint) else {
            return Fail(error: APIProviderErrors.invalidURL)
                .eraseToAnyPublisher()
        }

        return loadData(with: request)
                .eraseToAnyPublisher()
    }
    
    private func performRequest(for endPoint: EndPoint) -> URLRequest? {
        guard var urlComponents = URLComponents(string: endPoint.absoluteURL) else {
            return nil
        }
        
        if endPoint.httpMethod == .get {
            urlComponents.queryItems = endPoint.params.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else { return nil }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 30)
        urlRequest.httpMethod = endPoint.httpMethod.rawValue
        
        if endPoint.httpMethod == .post {
            let json: [String : Any] = endPoint.params
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            urlRequest.httpBody = jsonData
        }
        
        endPoint.headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)}
        return urlRequest
    }
    
    private func loadData(with request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error -> Error in
                APIErrors(rawValue: error.code.rawValue) ?? APIProviderErrors.unknownError
            }
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
