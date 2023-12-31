//
//  SearchBar.swift
//  Your Notes
//
//  Created by Franco Marquez on 16/10/23.
//

import SwiftUI



struct SearchBar: View {
    
    @Binding var searchText: String
    
    @State private var isEditing = false
    @State private var runInitialAnimation = false
    @State private var disappearSelf = false
    
    var body: some View {
        
        if !disappearSelf {
            
            GeometryReader(content: { geometry in
                
                
                HStack {
                    TextField("Search ...", text: $searchText)
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.horizontal, 10)
                        .frame(maxWidth: isEditing ? geometry.size.width * 0.8 : .infinity)
                        .onTapGesture {
                            withAnimation (.linear(duration: 0.1)) {
                                self.isEditing = true
                            }
                        }
                    
                    if isEditing {
                        Button(action: {
                            withAnimation (.linear){
                                self.isEditing = false
                                self.disappearSelf = true
                            }
                            
                            self.searchText = ""
                        }) {
                            Text("Cancel")
                                .padding(10)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: geometry.size.width * 0.2, alignment: .center)
                        .transition(.move(edge: .trailing))
                    }
                }
                .frame(maxHeight: 50)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .offset(x: geometry.size.width * 0.04)
                        
                        if isEditing {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .offset(x: geometry.size.width * -0.27)
                        }
                    }
                )
            })
            
        }
        
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}
