//
//  ImageDownloader.swift
//  AahaCMS
//
//  Created by Rujin on 30/09/24.



import Foundation
import SwiftUI


final class ImageDownloader: ObservableObject {
   @Published  var image : Image? = nil
    
    
    func ImageNetworkcall( urlString: String){
        NetworkImage.shared.downloadImage(fromURLString:urlString){
            uiImage in
            guard let image = uiImage else{
                return
            }
            DispatchQueue.main.async{
                self.image = Image(uiImage: image)
            }
            
            
        }
        
        
    }
    
    
}

struct remote:View {
    
    var image: Image?
    var body: some View{
        
        image?.resizable() ?? Image("dummyImage").resizable()
    }
}

struct ImagerLoader: View{
    @StateObject var imageData = ImageDownloader()
    let urlString: String
    var body: some View{
        remote(image: imageData.image).onAppear{
            imageData.ImageNetworkcall(urlString: urlString)
        }
    }
}
