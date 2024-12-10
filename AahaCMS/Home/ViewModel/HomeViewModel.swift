//
//  HomeViewModel.swift
//  AahaCMS
//
//  Created by Rujin on 01/10/24.
//




import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var data: [Product] = []
    
    func getValues() async {
        let urlPath = URLPath.getProducts
        

        do {
            let request: [Product] = try await NetworkService.shared.getRequest(urlPath: urlPath, addTokens: true)
            
            DispatchQueue.main.async{[weak self] in
                self?.data = request
               
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}
