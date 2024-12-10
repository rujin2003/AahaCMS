//
//  CustomTextFeild.swift
//  AahaCMS
//
//  Created by Rujin on 21/10/24.
//

import SwiftUI

enum TextFieldType {
    case email
    case password
    case text
    case longText
}

struct CustomTextField: View {
    let label: String
    let placeholder: String
    let textFieldType: TextFieldType
    let color: Color
    @Binding var text: String
    @State private var isPasswordVisible: Bool = false

    let width: Double
    var height: CGFloat? = nil // Optional height for longText fields

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
            
            VStack {
                ZStack(alignment: .trailing) {
                    if textFieldType == .password && !isPasswordVisible {
                        SecureField(placeholder, text: $text)
                            .foregroundColor(Color.black)
                            .padding(.leading)
                    } else if textFieldType == .longText {
                        TextEditor(text: $text)
                            .foregroundColor(Color.black)
                            .padding(.leading)
                            .frame(height: height ?? 100) // Default height if not provided
                    } else {
                        TextField(placeholder, text: $text)
                            .foregroundColor(Color.black)
                            .padding(.leading)
                    }

                    // Toggle Button for password visibility
                    if textFieldType == .password {
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.black)
                        }
                        .padding(.trailing, 10)
                    }
                }
            }
            .environment(\.colorScheme, .light)
            .frame(width: UIScreen.main.bounds.width * width, height: (textFieldType == .longText ? (height ?? 100) : 50)) // Adjust height for longText
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(color, lineWidth: 0.5)
                    .background(Color.clear)
            )
        }
    }
}

#Preview {
    VStack {
        CustomTextField(label: "Email", placeholder: "Email", textFieldType: .email, color: .black, text: .constant(""), width: 0.5)
        CustomTextField(label: "Password", placeholder: "Password", textFieldType: .password, color: .black, text: .constant(""), width: 0.5)
        CustomTextField(label: "Description", placeholder: "Enter description", textFieldType: .longText, color: .black, text: .constant("Product description here..."), width: 0.9, height: 150) // Example with custom height
    }
    .padding()
}
