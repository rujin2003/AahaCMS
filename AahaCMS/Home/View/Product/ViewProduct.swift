import SwiftUI

struct ViewProduct: View {
    @StateObject  var viewModel = EditProductViewModel()
    
    var data : Product
    
    @State private var showPhotoSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack {
                        VStack {
                        }
                        .frame(width: 25, height: 25)
                        .background(.red)
                        .cornerRadius(20)
                        .padding(.leading)
                        .offset(x: -50, y: -80)

                        VStack {
                            DataImage(base64String: data.image, width: 200, height: 200)
                               
                        }
                        .frame(width: 180, height: 170)
                        .background(viewModel.bgColor)
                        .cornerRadius(5)
                        .padding(.leading)
                        .offset(x: 5)
                        .onTapGesture {
                            showPhotoSheet = true
                        }
                        
                        NavigationLink(destination: EditProduct(viewModel: viewModel, data: self.data)) {
                            Image(systemName: "pencil")
                                .font(.title)
                                .padding()
                        }
                        .offset(x: 35, y: -80)
                    }
                    .padding(.top, 10)

                    ScrollView {
                        ProductDetailText(label: "Title", text: viewModel.productTitle)
                        Spacer().frame(height: 10)

                        ProductDetailText(label: "Description", text: viewModel.description, isLargeText: true)
                        Spacer().frame(height: 10)

                        ProductDetailText(label: "Category", text: viewModel.category)
                        Spacer().frame(height: 10)
                        
                        HStack {
                            VStack {
                                Text("Stock").bold()
                                Text(viewModel.stock)
                                    .padding()
                                    .frame(width: 55, height: 40)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }
                            
                            Spacer().frame(width: 40)

                            VStack {
                                Text("Price").bold()
                                Text(viewModel.price)
                                    .padding()
                                    .frame(width: 55, height: 40)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }
                            
                            Spacer().frame(width: 40)

                            VStack {
                                Text("Discount").bold()
                                Text(viewModel.discount)
                                    .padding()
                                    .frame(width: 55, height: 40)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }

                        ProductDetailText(label: "Size", text: viewModel.size)
                        Spacer().frame(height: 10)

                        ProductDetailText(label: "Offer", text: viewModel.offer)
                        Spacer().frame(height: 10)

                        ProductDetailText(label: "Highlights", text: viewModel.highlights, isLargeText: true)
                    }
                    .scrollIndicators(.hidden)
                }
                .frame(height: UIScreen.main.bounds.height * 0.78)
                .padding(.top, 20)

                Spacer()
            }.onAppear{
                viewModel.placeProductData(data: self.data)
            }
            .sheet(isPresented: $showPhotoSheet) {
                let imagesBase64 = data.images.components(separatedBy: ",")
                                
                PhotosView(
                    thumbnail: data.image,
                    image1: imagesBase64.count > 0 ? imagesBase64[0] : "",
                    image2: imagesBase64.count > 1 ? imagesBase64[1] : "",
                    image3: imagesBase64.count > 2 ? imagesBase64[2] : ""
                )

            }
        }
    }
}

struct ProductDetailText: View {
    let label: String
    let text: String
    var isLargeText: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    .background(Color.clear)
                
                ScrollView {
                    Text(text)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(height: isLargeText ? 150 : 55)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}


