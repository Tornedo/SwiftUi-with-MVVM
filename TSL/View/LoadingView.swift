//
//  LoadingView.swift
//  TSL
//
//  Created by Chayon Ahmed on 6/28/21.
//

import SwiftUI

struct LoadingView: View {
    var body: some View{
        ZStack{
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .red))
                .scaleEffect(1)
        }
    }
    
}
