//
//  ContentView.swift
//  Shared
//
//  Created by Alex Nagy on 26.02.2021.
//

import SwiftUI
import Introspect

struct ContentView: View {
    
    @State private var email = ""
    @State private var isValidEmail = false
    
    var body: some View {
        ZStack {
            
            Color.background.ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                Image("logo")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 150, height: 150)
                    .foregroundColor(.background)
                    .shadow(color: .darkShadow, radius: 3, x: 2, y: 2)
                    .shadow(color: .lightShadow, radius: 3, x: -2, y: -2)
                
                TextField("Enter email...", text: $email, onEditingChanged: { changed in
                    print("onEditingChanged: \(changed)")
                }) {
                    print("onCommit")
                }
    //            .textFieldStyle(RoundedBorderTextFieldStyle())
    //            .modifier(NeumorphicTextFieldModifier())
                .neumorphicTextField(cornerRadius: 16)
                .onChange(of: email) { (value) in
                    if value.contains("@") && value.contains(".com") {
                        isValidEmail = true
                    } else {
                        isValidEmail = false
                    }
                }
                .introspectTextField { (textField) in
                    textField.becomeFirstResponder()
                    // https://youtu.be/YuDJDUvFfXo
                }
                
                Text(email)
                    .bold()
                    .foregroundColor(isValidEmail ? Color(.systemGray2) : .red)
                
                if isValidEmail {
                    Button {
                        hideKeyboard()
                    } label: {
                        Text("Login")
                            .bold()
                            .padding(.horizontal, 24)
                            .padding(.vertical, 8)
                            .neumorphic(cornerRadius: 12)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct NeumorphicTextFieldModifier: ViewModifier {
    
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.accentColor)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .neumorphic(cornerRadius: cornerRadius)
//            .background(
//                RoundedRectangle(cornerRadius: 8)
//                    .fill(Color(.systemGray5))
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 8)
//                            .stroke(Color(.systemGray3), lineWidth: 1)
//                    )
//            )
    }
}

struct NeumorphicModifier: ViewModifier {
    
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.neumorphicTextColor)
            .background(Color.background)
            .cornerRadius(cornerRadius)
            .shadow(color: .darkShadow, radius: 3, x: 2, y: 2)
            .shadow(color: .lightShadow, radius: 3, x: -2, y: -2)
    }
}

extension View {
    func neumorphicTextField(cornerRadius: CGFloat) -> some View {
        modifier(NeumorphicTextFieldModifier(cornerRadius: cornerRadius))
    }
    
    func neumorphic(cornerRadius: CGFloat) -> some View {
        modifier(NeumorphicModifier(cornerRadius: cornerRadius))
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Color {
    static let lightShadow = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
    static let darkShadow = Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255)
    static let background = Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
    static let neumorphicTextColor = Color(red: 132 / 255, green: 132 / 255, blue: 132 / 255)
}
