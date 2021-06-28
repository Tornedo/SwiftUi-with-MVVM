//
//  MessageListViewModel.swift
//  TSL
//
//  Created by Chayon Ahmed on 6/24/21.
//  Copyright © 2021 Chayon Ahmed. All rights reserved.
//

import Foundation
import Combine

class MessageViewListModel: ObservableObject {
    private let apiProvider = APIProvider<MessageEndPoint>()
    @Published private(set) var messages: [Message] = []
    private var cancellable = Set<AnyCancellable>()
    @Published var message = ""
    @Published var isLoading = false
    @Published var showingApiFailedAlert = false

    func getMessages() {
        self.isLoading = false
        apiProvider.getData(from: .getMessage) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
            }

            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                let response = try! decoder.decode([Message].self, from: data)
                DispatchQueue.main.async {
                self?.messages = response
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

    func saveMessage() {
        self.isLoading = true

        apiProvider.getData(from: .saveMessage(message)) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
            }

            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                self?.message = ""
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showingApiFailedAlert = true
                }
                print(error.localizedDescription)
                break
            }
        }
    }
}
