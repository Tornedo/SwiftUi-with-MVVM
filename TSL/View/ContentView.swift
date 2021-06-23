//
//  ContentView.swift
//  TSL
//
//  Created by Chayon Ahmed on 6/24/21.
//  Copyright © 2021 Chayon Ahmed. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MessageView()
                .tabItem {
                    VStack {
                        Image(systemName: "note.text.badge.plus")
                        Text("Create Message")
                    }
                }
                .tag(0)
            
            MessageListView()
                .tabItem {
                    VStack {
                        Image(systemName: "text.book.closed")
                        Text("All Messages")
                    }
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
