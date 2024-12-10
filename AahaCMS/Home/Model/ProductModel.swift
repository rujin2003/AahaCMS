//
//  ProductModel.swift
//  AahaCMS
//
//  Created by Rujin on 01/10/24.
//

import Foundation


struct Product: Identifiable, Codable {
    var id: String
    var name: String
    var category: String
    var description: String
    var image: String
    var images: String
    var stock: String
    var price: String
    var listed: String
    var offer: String
    var sizes: String
    var highlights: String
    var color: String
    var discount: String
}

struct ProductModelResponse : Codable {
    let responseData : [Product]
}
