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
            Spacer()
            if viewModel.isLoading{
                LoadingView()
            }
            TextView(text: $viewModel.message)
                .frame(height: 350)
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
            .frame(width: 250, height: 45)
            .background(Color.green)
            .padding()
            
            Spacer()
            
        }
        .background(Color.gray)
        .alert(isPresented: $viewModel.showingApiFailedAlert, content: {
            Alert(title: Text("Oops!"),
                  message: Text("Something went wrong."),
                  dismissButton: .default(Text("OK")){
                    viewModel.showingApiFailedAlert = false
                  }
            )
        })
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
