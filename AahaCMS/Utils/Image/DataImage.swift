//
//  DataImage.swift
//  AahaCMS
//
//  Created by Rujin on 21/10/24.
//

import SwiftUI

struct DataImage: View {
    let base64String: String
    var width: CGFloat
    var height: CGFloat
    var contentMode: ContentMode = .fit
    var cornerRadius: CGFloat = 8
    
    var image: UIImage? {
        guard let data = Data(base64Encoded: base64String),
              let uiImage = UIImage(data: data) else {
            return nil
        }
        return uiImage
    }
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .shadow(radius: 10)
        } else {
            
            Image("dummyImage").resizable().aspectRatio(contentMode: contentMode)
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .shadow(radius: 10)
        }
    }
}
