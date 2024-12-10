//
//  Home.swift
//  AahaCMS
//
//  Created by Rujin on 29/09/24.
//


import SwiftUI


struct Home: View {
    @ObservedObject var viewModel = HomeViewModel()
    @ObservedObject var editViewModel = EditProductViewModel()
    
    @State var  showAddProducts : Bool = false

    var body: some View {
        
        
        NavigationStack {
            ZStack {
        Color.white.ignoresSafeArea()
                Button{
                    showAddProducts.toggle()
                }
                
                label: {
                    Image(systemName: "plus")
                }.frame(width: 60,height: 60).background(.blue).cornerRadius(30).foregroundStyle(.white).font(.system(size: 20)).offset(x:130,y: 280)
                
                VStack {
                    TitleText(text: "Products")
                    
                    ForEach(viewModel.data) { product in
                        ProductRow(product: product,edit: editViewModel)
                    }
                    
                    Spacer()
                }
                .onAppear {
                    Task {
                        await viewModel.getValues()
                    }
                    
            
                }
            }.sheet(isPresented: $showAddProducts) {
                AddProductsView()
            }
        }
    }
}


#Preview {
    Home()
}


struct ProductRow: View {
    let product: Product
    let edit: EditProductViewModel
    @State private var showProductSheet = false
    
    var body: some View {
        HStack {
            VStack {
                DataImage(base64String: product.image, width: 60, height: 60)
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 60, height: 60)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(5)
            .padding(.leading)

            Spacer().frame(width: 20)

            VStack {
                Spacer().frame(height: 10)

                HStack {
                    Text(product.name)
                    Spacer()
                  
                    NavigationLink {
                        EditProduct(viewModel: edit, data: product)
                    } label: {
                        Image(systemName: "pencil")
                            .padding(.top, 5)
                    }

                    Spacer().frame(width: 15)
                    
                    Button {} label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.red)
                            .padding(.trailing, 10)
                    }
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .frame(width: 350, height: 70)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .onTapGesture {
            showProductSheet = true
        }
        .sheet(isPresented: $showProductSheet) {
            ViewProduct(data: product)
        }
    }
}


