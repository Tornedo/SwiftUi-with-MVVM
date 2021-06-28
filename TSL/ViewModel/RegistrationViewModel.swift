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
    @Published var showingAlert = false
    @Published var showingApiFailedAlert = false
    @Published var isRegistered = false
    @Published var isLoading = false

    @Published private(set) var apiToken: APIToken?
    
    func registerUser() {
        print("register")
        isLoading = true
        
        apiProvider.getData(from: .registration(userName: userName, password: password)) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
            }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.isRegistered = true
//                    self?.getAPIKey()
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showingApiFailedAlert = true
                }
                print(error.localizedDescription)
                break
            }
        }
    }
    
    func getAPIKey() {
        
        if userName.isEmpty || password.isEmpty {
            showingAlert = true
            return
        }
        print("apiKey")
        isLoading = true
        apiProvider.getData(from:  .login(userName: userName, password: password)) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
            }
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(APIToken.self, from: data)
                    DispatchQueue.main.async {
                        self?.apiToken = response
                        Self.apiKey = response.token
                        self?.showingHomePage = true
                    }
                } catch {
                    print("ERROR in LOGIN :: \(error)")
                }


                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showingApiFailedAlert = true
                }
                print(error.localizedDescription)
            }
        }
    }
}
