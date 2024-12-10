//
//  ContentView.swift
//  AahaCMS
//
//  Created by Rujin on 29/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            TabView{

                    Home().tabItem{
                    Label("Home",systemImage: "house")
                    
                
                }
                
                Gallery().tabItem{
                    Label("Gallery",systemImage: "photo")
                }
                
                Orders().tabItem{
                    Label("Order",systemImage: "mail.stack.fill")
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        ContentView()
    }
}
