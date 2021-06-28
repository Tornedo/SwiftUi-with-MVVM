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
    func getData(from endPoint: EndPoint, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let request = performRequest(for: endPoint) else {
            completion(.failure(APIProviderErrors.invalidURL))
            return
        }
        
        loadData(with: request, completion: completion)
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
        
        print(endPoint.params)
        print("BODY :: \(urlRequest.httpBody)")
        endPoint.headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)}
        
        print(endPoint.headers)
        return urlRequest
    }
    
    private func loadData(with request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void){
        print(request.url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(APIProviderErrors.unknownError))
            }
        }
        .resume()
    }
}
