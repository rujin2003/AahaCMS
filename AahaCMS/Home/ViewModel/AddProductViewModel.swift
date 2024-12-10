//
//  AddProductViewModel.swift
//  AahaCMS
//
//  Created by Rujin on 03/11/24.
//

import Foundation
import SwiftUI

class AddProductViewModel: ObservableObject{
    @Published var productTitle: String = ""
    @Published var description: String = ""
    @Published var category: String = ""
    @Published var stock: String = ""
    @Published var price: String = ""
    @Published var discount: String = ""
    @Published var size: String = ""
    @Published var offer: String = ""
    @Published var highlights: String = ""
    @Published var bgColor = Color.red
    
    @Published var thumbnailImage: UIImage?
    @Published var image1: UIImage?
    @Published var image2: UIImage?
    @Published var image3: UIImage?

    func addProduct(model: Product) {
        let mainImageData = image1?.jpegData(compressionQuality: 1.0)
        let imageListData: [Data] = [
            image2?.jpegData(compressionQuality: 1.0),
            image3?.jpegData(compressionQuality: 1.0)
        ].compactMap { $0 }

        Task {
            do {
                try await NetworkService.shared.postRequest(
                    urlPath: URLPath.postProducts,
                    model: model,
                    addTokens: true,
                    isMultipart: true,
                    mainImageData: mainImageData,
                    imageListData: imageListData,
                    mainImageFileName: "\(model.name).jpg",
                    imageListFileNames: ["\(model.name)1.jpg", "\(model.name)2.jpg","\(model.name)3.jpg"]
                )
                
            } catch {
                print("Failed to add product:", error)
            }
        }
    }


    
}
