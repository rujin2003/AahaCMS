//
//  Title.swift
//  AahaCMS
//
//  Created by Rujin on 30/09/24.
//

import SwiftUI
func TitleText(text: String )-> some View{
    return HStack{
        Text(text).font(.system(size: 30,weight:.bold))
            Spacer()
    }.padding(.leading,25).padding(.top,10)
}
