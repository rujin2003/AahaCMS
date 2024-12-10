//
//  EditPhotosView.swift
//  AahaCMS
//
//  Created by Rujin on 22/10/24.
//
import SwiftUI

struct EditPhotosView: View {
    @State private var isPickerPresented = false
    @State private var selectedImageForPicker: Int? = nil
    
    @Binding var thumbnail: UIImage?
    @Binding var image1: UIImage?
    @Binding var image2: UIImage?
    @Binding  var image3: UIImage?
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Thumbnail")
                    .font(.title)
                    .padding()
                Spacer()
            }

           
            if let thumbnail = thumbnail {
                Image(uiImage: thumbnail)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                    .onTapGesture {
                        selectedImageForPicker = 0
                        isPickerPresented = true
                    }
            } else {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 200, height: 200)
                    .padding()
                    .onTapGesture {
                        selectedImageForPicker = 0
                        isPickerPresented = true
                    }
            }

            HStack {
                Text("Images")
                    .font(.title)
                    .padding()
                Spacer()
            }

            HStack(spacing: 20) {
              
                if let image1 = image1 {
                    Image(uiImage: image1)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .onTapGesture {
                            selectedImageForPicker = 1
                            isPickerPresented = true
                        }
                } else {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                        .onTapGesture {
                            selectedImageForPicker = 1
                            isPickerPresented = true
                        }
                }

                // Second image with tap to change
                if let image2 = image2 {
                    Image(uiImage: image2)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .onTapGesture {
                            selectedImageForPicker = 2
                            isPickerPresented = true
                        }
                } else {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                        .onTapGesture {
                            selectedImageForPicker = 2
                            isPickerPresented = true
                        }
                }

                if let image3 = image3 {
                    Image(uiImage: image3)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .onTapGesture {
                            selectedImageForPicker = 3
                            isPickerPresented = true
                        }
                } else {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                        .onTapGesture {
                            selectedImageForPicker = 3
                            isPickerPresented = true
                        }
                }
            }
            .padding()
        }
        .sheet(isPresented: $isPickerPresented) {
            // Use selectedImageForPicker to determine which image to update
            switch selectedImageForPicker {
            case 0:
                ImagePicker(selectedImage: $thumbnail)
            case 1:
                ImagePicker(selectedImage: $image1)
            case 2:
                ImagePicker(selectedImage: $image2)
            case 3:
                ImagePicker(selectedImage: $image3)
            default:
                EmptyView()
            }
        }
    }
}
