//
//  PhotosView.swift
//  AahaCMS
//
//  Created by Rujin on 22/10/24.
//
import SwiftUI

struct PhotosView: View {
    
    
     var thumbnail: String?
     var image1: String?
     var image2: String?
     var image3: String?
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Thumbnail")
                    .font(.title)
                    .padding()
                Spacer()
            }
            
            if let thumbnail = thumbnail {
                
                DataImage(base64String: thumbnail, width: 200, height: 200)
                
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 200, height: 200)
                    .padding()
            }
            
            HStack {
                Text("Images")
                    .font(.title)
                    .padding()
                Spacer()
            }
            
            HStack(spacing: 20) {
                if let image1 = image1 {
                    DataImage(base64String: image1, width: 80, height: 80)
                } else {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                }

                if let image2 = image2 {
                    DataImage(base64String: image2, width: 80, height: 80)
                } else {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                }

                if let image3 = image3 {
                    DataImage(base64String: image3, width: 80, height: 80)
                } else {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                }
            }
            .padding()
        }
    }
}
