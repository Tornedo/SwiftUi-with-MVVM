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
                                if viewModel.isRegistered {
                                    viewModel.getAPIKey()
                                } else {
                                    viewModel.registerUser()
                                }
                            }) {
                                HStack {
                                    Spacer()
                                    Text(viewModel.isRegistered ? "Login" : "Registration")
                                    Spacer()
                                }
                            }
                            
                            if !viewModel.isRegistered {
                                Button(action: {
                                    viewModel.isRegistered = true
                                }, label: {
                                    HStack {
                                        Spacer()
                                        Text("Already have an accunt? Login")
                                        Spacer()
                                    }
                                })
                            }
                        }
                        
                        if viewModel.isLoading{
                            LoadingView()
                        }
                        
                    }
                    
                    .navigationTitle(Text("Registration"))
                }
                
            }
        }
        .alert(isPresented: $viewModel.showingAlert, content: {
            Alert(title: Text("Error"),
                  message: Text("UserName and Password is required"),
                  dismissButton: .default(Text("OK")))
        })
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
