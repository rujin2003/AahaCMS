//
//  CustomBtn.swift
//  AahaCMS
//
//  Created by Rujin on 21/10/24.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var action: () -> Void
    var color: Color
    var icon: Image? = nil

    var body: some View {
        Button(action: action) {
            HStack {
                if let icon = icon {
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                Text(title)
                    .fontWeight(.bold)
            }            .padding().frame(width: 175,height: 50)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(10)
        }
    }
}

