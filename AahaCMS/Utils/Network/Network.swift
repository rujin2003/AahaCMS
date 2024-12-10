import SwiftUI

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct NetworkService: NetworkServiceProtocol {

    static let shared = NetworkService()

    // MARK: - GET Request
    func getRequest<T: Decodable>(urlPath: URLPath,
                                  addTokens: Bool) async throws -> T {
        
        guard let url = URL(string: "\(Constants.shared.baseURL)\(urlPath.rawValue)") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        
        request.httpMethod = HTTPMethod.get.rawValue

        if addTokens {
            let token = Constants.shared.token
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
            print("error occurred \(response.description)")
            throw URLError(URLError.Code(rawValue: httpResponse.statusCode))
        }

        let decodedResponse = try JSONDecoder().decode(T.self, from: data)
        return decodedResponse
    }

  
    // MARK: - POST Request (for creating/updating resources)
    func postRequest<U: Encodable>(
        urlPath: URLPath,
        model: U,
        addTokens: Bool,
        isMultipart: Bool = false,
        mainImageData: Data? = nil,
        imageListData: [Data]? = nil,
        mainImageFileName: String? = nil,
        imageListFileNames: [String]? = nil
    ) async throws {
        guard let url = URL(string: "\(Constants.shared.baseURL)\(urlPath.rawValue)") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue

        if isMultipart {
            let boundary = UUID().uuidString
            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            let body = createMultipartBody(model: model, mainImageData: mainImageData, imageListData: imageListData, boundary: boundary, mainImageFileName: mainImageFileName, imageListFileNames: imageListFileNames)
            request.httpBody = body
        } else {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let body = encodeRequestBody(for: model)
            request.httpBody = body
        }

        if addTokens {
            let token = Constants.shared.token
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
            print("Error occurred \(response.description)")
            throw URLError(URLError.Code(rawValue: httpResponse.statusCode))
        }

        // Optionally handle response data if any (omit if no response expected)
        if !data.isEmpty {
            // Handle response if there's any
            print("Received response data, but ignoring as per the function setup.")
        }
    }


    // MARK: - Helper Methods
    func createMultipartBody<U: Encodable>(model: U,
                                           mainImageData: Data?,
                                           imageListData: [Data]?,
                                           boundary: String,
                                           mainImageFileName: String?,
                                           imageListFileNames: [String]?) -> Data {
        var body = Data()

        // Add model fields
        let modelDict = try! JSONEncoder().encode(model)
        if let modelJSON = try? JSONSerialization.jsonObject(with: modelDict, options: []) as? [String: String] {
            for (key, value) in modelJSON {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)\r\n".data(using: .utf8)!)
            }
        }

        // Add main image (for "image" field)
        if let mainImageData = mainImageData, let mainImageFileName = mainImageFileName {
            let mimeType = "image/jpeg"
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(mainImageFileName)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
            body.append(mainImageData)
            body.append("\r\n".data(using: .utf8)!)
        }

        // Add additional images (for "images" field)
        if let imageListData = imageListData, let imageListFileNames = imageListFileNames {
            for (index, imageData) in imageListData.enumerated() {
                let fileName = imageListFileNames[index]
                let mimeType = "image/jpeg"
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"images\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
                body.append(imageData)
                body.append("\r\n".data(using: .utf8)!)
            }
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return body
    }

    func encodeRequestBody<T: Encodable>(for requestBody: T) -> Data? {
        return try? JSONEncoder().encode(requestBody)
    }
}


