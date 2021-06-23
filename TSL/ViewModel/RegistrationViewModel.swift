//
//  RegistrationViewModel.swift
//  TSL
//
//  Created by Chayon Ahmed on 6/24/21.
//  Copyright © 2021 Chayon Ahmed. All rights reserved.
//

import Foundation
import Combine

class RegistrationViewModel: ObservableObject {
    static var apiKey = ""
    private let apiProvider = APIProvider<LoginEndPoint>()
    private var cancellable = Set<AnyCancellable>()
    
    @Published var userName = ""
    @Published var password = ""
    @Published var showingHomePage = false
    @Published private(set) var apiToken: APIToken?
    
    func registerUser() {
        print("register")
        apiProvider.getData(from: .registration(userName: userName, password: password))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self]  completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("Error :: \(error)")
                }
            }, receiveValue: { [weak self] data in
                self?.getAPIKey()
            })
            .store(in: &cancellable)
    }

    func getAPIKey() {
        print("apiKey")
        apiProvider.getData(from: .apiToken)
            .decode(type: APIToken.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] _ in
                
            }, receiveValue: { [weak self] token in
                print(token.token)
                self?.apiToken = token
                Self.apiKey = token.token
                self?.showingHomePage = true
            })
            .store(in: &cancellable)
    }
}
