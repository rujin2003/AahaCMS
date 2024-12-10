//
//  EditProductViewModel.swift
//  AahaCMS
//
//  Created by Rujin on 21/10/24.
//

import SwiftUI

class EditProductViewModel: ObservableObject {
    @Published var loading : Bool = false
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
    
    @Published var editData: Product = Product(
        id: "",
        name: "",
        category: "",
        description: "",
        image: "",
        images: "",
        stock: "",
        price: "",
        listed: "",
        offer: "",
        sizes: "",
        highlights: "",
        color: "",
        discount: ""
    )
    
    func placeProductData(data: Product){
        productTitle = data.name
        description = data.description
        category = data.category
        stock = data.stock
        price = data.price
        discount = data.discount
        size = data.sizes
        offer = data.offer
        highlights = data.highlights
        bgColor = Color(data.color)
        
        let imagesBase64 = data.images.components(separatedBy: ",")
        thumbnailImage = decodeBase64ToImage(data.image)
        image1 = decodeBase64ToImage(imagesBase64.count > 0 ? imagesBase64[0] : "")
        image2 = decodeBase64ToImage(imagesBase64.count > 1 ? imagesBase64[1] : "")
        image3 = decodeBase64ToImage(imagesBase64.count > 2 ? imagesBase64[2] : "")
    }
    
    func updateProduct(model: Product) {
        let mainImageData = thumbnailImage?.jpegData(compressionQuality: 1.0)
        let imageListData: [Data] = [
            image1?.jpegData(compressionQuality: 1.0),
            image2?.jpegData(compressionQuality: 1.0),
            image3?.jpegData(compressionQuality: 1.0)
        ].compactMap { $0 }

        Task {
            do {
                try await NetworkService.shared.postRequest(
                    urlPath: URLPath.updateProduct(id: Int(model.id) ?? 0),
                    model: model,
                    addTokens: true,
                    isMultipart: true,
                    mainImageData: mainImageData,
                    imageListData: imageListData,
                    mainImageFileName: "\(model.name).jpg",
                    imageListFileNames: ["\(model.name)1.jpg", "\(model.name)2.jpg", "\(model.name)3.jpg"]
                )
                print("Product updated successfully")
            } catch {
                print("Failed to update product:", error)
            }
        }
    }
    
    private func decodeBase64ToImage(_ base64String: String?) -> UIImage? {
        if base64String == "" {
            return UIImage(named: "dummyimage")
        }
        guard let base64String = base64String,
              let imageData = Data(base64Encoded: base64String) else { return nil }
        return UIImage(data: imageData)
    }
}

