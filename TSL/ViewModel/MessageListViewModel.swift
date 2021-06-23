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
    func getMessages() {
        apiProvider.getData(from: .getMessage)
            .decode(type: [Message].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.messages, on: self)
            .store(in: &cancellable)
    }

    func saveMessage() {
        apiProvider.getData(from: .saveMessage(message))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case.failure(let error) :
                    print(error.localizedDescription)
                case .finished:
                    self?.message = ""
                }
            }, receiveValue: { [weak self] data in
                
            })
            .store(in: &cancellable)
        
    }
}
