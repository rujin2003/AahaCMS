import SwiftUI

struct AddProductsView: View {
    
    @StateObject var viewModel = AddProductViewModel()
    @State private var addProductAlert = false
    @State private var showPhotoSheet = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Spacer().frame(height: 20)
                    
                    HStack(alignment: .top) {
                        ColorPicker("", selection: $viewModel.bgColor, supportsOpacity: false)
                            .padding(.leading)
                            .frame(width: 40, height: 40)
                        
                        Spacer()
                        
                        VStack {
                            Image("dummyImage2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 180, height: 170)
                                .cornerRadius(5)
                        }
                        .onTapGesture {
                            showPhotoSheet = true
                        }
                        .padding(.leading)

                        Spacer()

                        Menu {
                            Button("Delete Product", role: .destructive) {
                                addProductAlert = true
                            }
                            Button("Add Product") {
                                addProductAlert = true
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .rotationEffect(.degrees(90))
                                .font(.title)
                                .padding()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    VStack(spacing: 10) {
                        CustomTextField(
                            label: "Title",
                            placeholder: "Product Title",
                            textFieldType: .text,
                            color: Color.black,
                            text: $viewModel.productTitle,
                            width: 0.9
                        )

                        CustomTextField(
                            label: "Description",
                            placeholder: "Enter description",
                            textFieldType: .longText,
                            color: Color.black,
                            text: $viewModel.description,
                            width: 0.9
                        )

                        CustomDropdown(
                            label: "Category",
                            options: ["Electronics", "Furniture", "Clothing"],
                            selectedOption: $viewModel.category,
                            color: Color.black,
                            width: 0.9
                        )

                        HStack(spacing: 40) {
                            VStack {
                                Text("Stock").bold()
                                TextField("", text: $viewModel.stock)
                                    .padding()
                                    .frame(width: 55, height: 40)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }

                            VStack {
                                Text("Price").bold()
                                TextField("", text: $viewModel.price)
                                    .padding()
                                    .frame(width: 55, height: 40)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }

                            VStack {
                                Text("Discount").bold()
                                TextField("", text: $viewModel.discount)
                                    .padding()
                                    .frame(width: 55, height: 40)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }

                        CustomTextField(
                            label: "Size",
                            placeholder: "Enter size",
                            textFieldType: .text,
                            color: Color.black,
                            text: $viewModel.size,
                            width: 0.9
                        )

                        CustomTextField(
                            label: "Offer",
                            placeholder: "Enter offer",
                            textFieldType: .text,
                            color: Color.black,
                            text: $viewModel.offer,
                            width: 0.9
                        )

                        CustomTextField(
                            label: "Highlights",
                            placeholder: "Enter highlights",
                            textFieldType: .longText,
                            color: Color.black,
                            text: $viewModel.highlights,
                            width: 0.9
                        )
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 100)
                .scrollIndicators(.hidden)
            }
            .sheet(isPresented: $showPhotoSheet) {
                EditPhotosView(
                    thumbnail: $viewModel.thumbnailImage,
                    image1: $viewModel.image1,
                    image2: $viewModel.image2,
                    image3: $viewModel.image3
                )
            }
            .alert(isPresented: $addProductAlert) {
                Alert(
                    title: Text("Add Product"),
                    message: Text("Are you sure you want to add this product?"),
                    primaryButton: .default(Text("Add")) {
                       
                        let product = Product(id: UUID().uuidString, name: viewModel.productTitle, category: viewModel.category, description: viewModel.description, image: "", images: "", stock: viewModel.stock, price: viewModel.price, listed: "yes", offer: viewModel.offer, sizes: viewModel.size, highlights: viewModel.highlights, color: viewModel.bgColor.toHex() ?? "none", discount: viewModel.discount)
                        
                        Task {
                            do {
                               viewModel.addProduct(model: product)
                                print("Product added successfully.")
                                dismiss()
                            }
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    AddProductsView()
}


extension Color{
    
    func toHex() -> String? {
           guard let components = UIColor(self).cgColor.components else { return nil }
           let r = components[0]
           let g = components[1]
           let b = components[2]
           let hexString = String(format: "#%02lX%02lX%02lX",
                                  lroundf(Float(r * 255)),
                                  lroundf(Float(g * 255)),
                                  lroundf(Float(b * 255)))
           return hexString
       }
}
