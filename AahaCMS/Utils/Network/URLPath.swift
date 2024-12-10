import Foundation

enum URLPath {
    // MARK: - Authentication
    case login

    // MARK: - Products
    case getProducts
    case postProducts
    case getProductById(id: Int)
    case updateProduct(id: Int)
    case deleteProduct(id: Int)

    // MARK: - Gallery
    case addGalleryImage
    case getGalleryImageById(id: Int)
    case getAllGalleryImageLinks
    case deleteGalleryImage(id: Int)

    // MARK: - Product Images
    case addProductImages
    case getProductImagesByName(productName: String)
    case getProductImageById(id: Int)
    case deleteProductImagesByName(productName: String)

    // MARK: - Status
    case getStatus
    case updateStatus

    var rawValue: String {
        switch self {
        case .login:
            return "Account/LoginUser"

        // Products
        case .getProducts, .postProducts:
            return "products"
        case .getProductById(let id), .updateProduct(let id), .deleteProduct(let id):
            return "products/\(id)"
        
        // Gallery
        case .addGalleryImage, .getAllGalleryImageLinks:
            return "gallery-images"
        case .getGalleryImageById(let id), .deleteGalleryImage(let id):
            return "gallery-images/\(id)"
        
        // Product Images
        case .addProductImages:
            return "productimage"
        case .getProductImagesByName(let productName), .deleteProductImagesByName(let productName):
            return "productimage/\(productName)"
        case .getProductImageById(let id):
            return "productimg/\(id)"
        
        // Status
        case .getStatus, .updateStatus:
            return "status"
        }
    }
}

