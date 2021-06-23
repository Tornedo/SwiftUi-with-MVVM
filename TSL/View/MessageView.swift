//
//  MessageView.swift
//  TSL
//
//  Created by Chayon Ahmed on 6/24/21.
//  Copyright © 2021 Chayon Ahmed. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    @ObservedObject private var viewModel = MessageViewListModel()

    var body: some View {
        VStack(alignment: .center) {
            TextView(text: $viewModel.message)
                .padding()
            
            Button(action: {
                viewModel.saveMessage()
            }
                   , label: {
                    HStack {
                        Spacer()
                        Text("Send")
                            .fontWeight(.medium)
                        Spacer()
                    }
            })
            .frame(height: 45)
            .background(Color.green)
            .padding()
            
            Spacer()
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
