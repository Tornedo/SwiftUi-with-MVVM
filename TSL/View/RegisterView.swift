//
//  RegisterView.swift
//  TSL
//
//  Created by Chayon Ahmed on 6/24/21.
//  Copyright © 2021 Chayon Ahmed. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject private var viewModel = RegistrationViewModel()
    
    var body: some View {
        Group {
            if viewModel.showingHomePage {
                ContentView()
            } else {
                NavigationView {
                    Form {
                        Section {
                            TextField("User Name", text: $viewModel.userName)
                            SecureField("Password", text: $viewModel.password)
                        }
                        
                        Section {
                            Button(action: {
                                viewModel.registerUser()
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Registration")
                                    Spacer()
                                }
                            }
                            
                        }
                    }
                    .navigationTitle(Text("Registration"))
                }
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
