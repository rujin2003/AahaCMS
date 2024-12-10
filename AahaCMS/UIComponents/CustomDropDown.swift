//
//  CustomDropDown.swift
//  AahaCMS
//
//  Created by Rujin on 21/10/24.
//

import SwiftUI

struct CustomDropdown: View {
    let label: String
    let options: [String]
    @Binding var selectedOption: String
    let color: Color
    let width: Double

    @State private var isExpanded: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
            
            VStack {
                Button(action: {
                    isExpanded.toggle()
                }) {
                    HStack {
                        Text(selectedOption.isEmpty ? "Select an option" : selectedOption)
                            .foregroundColor(Color.black)
                        Spacer()
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(Color.black)
                    }
                    .padding(.leading)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(color, lineWidth: 0.5)
                            .background(Color.clear)
                    )
                }
                
                if isExpanded {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            selectedOption = option
                            isExpanded = false
                        }) {
                            Text(option)
                                .foregroundColor(Color.black)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width * width)
        }
    }
}

#Preview {
    VStack {
        CustomDropdown(
            label: "Category",
            options: ["Electronics", "Furniture", "Clothing"],
            selectedOption: .constant(""),
            color: .black,
            width: 0.5
        )
    }
    .padding()
}
