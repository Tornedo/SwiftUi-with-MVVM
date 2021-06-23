//
//  MessageListView.swift
//  TSL
//
//  Created by Chayon Ahmed on 6/24/21.
//  Copyright © 2021 Chayon Ahmed. All rights reserved.
//

import SwiftUI

struct MessageListView: View {
    @ObservedObject private var viewModel = MessageViewListModel()
    
    var body: some View {
        List(viewModel.messages) { message in
            Text(message.message)
        }
        .onAppear {
            viewModel.getMessages()
        }
    }
}

struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        MessageListView()
    }
}
