//
//  NetworkServiceProtocol.swift
//  AahaCMS
//
//  Created by Rujin on 29/09/24.
//

import Foundation

protocol NetworkServiceProtocol {
  

    func getRequest<T: Decodable>(urlPath: URLPath,
                                  addTokens: Bool) async throws -> T
    
    func postRequest<U: Encodable>(
        urlPath: URLPath,
        model: U,
        addTokens: Bool,
        isMultipart: Bool ,
        mainImageData: Data? ,
        imageListData: [Data]? ,
        mainImageFileName: String? ,
        imageListFileNames: [String]?
        
    ) async throws
    
    func createMultipartBody<U: Encodable>(model: U,
                                           mainImageData: Data?,
                                           imageListData: [Data]?,
                                           boundary: String,
                                           mainImageFileName: String?,
                                           imageListFileNames: [String]?) -> Data

    func encodeRequestBody<T: Encodable>(for requestBody: T) -> Data?
}
