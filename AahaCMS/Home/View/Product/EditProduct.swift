import SwiftUI

struct EditProduct: View {
    @StateObject var viewModel: EditProductViewModel
    @State private var showDeleteAlert = false
    @State private var showPhotoSheet = false
    var data: Product
    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        NavigationStack {
            VStack {
                VStack {
                    HStack(alignment: .top) {
                        ColorPicker("", selection: $viewModel.bgColor, supportsOpacity: false)
                            .padding(.leading)
                            .frame(width: 40, height: 40)
                        Spacer()
                        VStack {
                            DataImage(base64String: data.image, width: 180, height: 180)
                              
                        }
                        .onTapGesture {
                            showPhotoSheet = true
                        }
                        .padding(.leading)

                        Spacer()

                        Menu {
                            Button("Delete Product", role: .destructive) {
                                showDeleteAlert = true
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

                    ScrollView {
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
                }
                .frame(height: UIScreen.main.bounds.height * 0.78)

                Spacer()

                HStack {
                    CustomButton(title: "Cancel", action: {
                        dismiss() 
                    }, color: Color.gray, icon: Image(systemName: "xmark"))

                    CustomButton(title: "Update", action: {
                        
                        viewModel.updateProduct(model: viewModel.editData)
                        
                        
                    }, color: Color.blue, icon: Image(systemName: "square.and.arrow.down"))
                }
                .padding(.horizontal)
                .sheet(isPresented: $showPhotoSheet) {
                    EditPhotosView(
                        thumbnail: $viewModel.thumbnailImage,
                        
                        
                        image1: $viewModel.image1,
                        image2: $viewModel.image2,
                        image3: $viewModel.image3
                    )
                }
            }
            .onAppear {
                viewModel.placeProductData(data: self.data)
                
            }
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("Delete Product"),
                    message: Text("Are you sure you want to delete this product?"),
                    primaryButton: .destructive(Text("Delete")) {
                        
                    },
                    secondaryButton: .cancel()
                )
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

