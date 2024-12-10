//
//  NetworkImage.swift
//  AahaCMS
//
//  Created by Rujin on 30/09/24.
//
import SwiftUI
final class NetworkImage{
    static let shared = NetworkImage()
    let cache = NSCache<NSString,UIImage>()
    
    func downloadImage(fromURLString urlString: String , completed: @escaping(UIImage?)-> Void){
      // checking if the image is in the chache
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey){
            completed(image)
            return
        }
        guard let url = URL(string: urlString) else{completed(nil)
        return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)){
            data, response, erroe in
           
            guard let data = data, let image = UIImage(data: data) else{
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
        
        }
        task.resume()
    }
}
