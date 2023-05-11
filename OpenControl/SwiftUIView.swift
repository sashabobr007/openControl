//
//  SwiftUIView.swift
//  OpenControl
//
//  Created by Александр Алексеев on 06.05.2023.
//

import SwiftUI


import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import UIKit


struct SwiftUIView: View {
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""

  
    var body: some View {
    NavigationStack {
        ScrollView{
//            Picker(selection: $isLoginMode, content: {
//                Text("login").tag(true)
//                Text("Regiset").tag(false)
//            }, label: {
//                
//            }).pickerStyle(SegmentedPickerStyle()).padding()
//            
            if !isLoginMode{
                Button{
                    
                }label: {
                    Image(systemName: "person.fill").font(.system(size: 64)).padding()
                    
                }
            }
            Group{
                TextField("Email", text: $email).keyboardType(.emailAddress).textInputAutocapitalization(.none)
                SecureField("Password", text: $password)
            }.frame(height: 50).background(.white).clipShape(RoundedRectangle(cornerRadius: 10)).padding(.bottom, 5).padding(.horizontal)
            
         
            
            Button(action: {
                logAction()
            }, label: {
                Text("Create").foregroundColor(.white).frame(width: 380, height: 40)
            }).background(.blue).clipShape(RoundedRectangle(cornerRadius: 10)).padding()
            
            NavigationLink(destination: {
                MainMessageView()
            }, label: {
                Text("Next").foregroundColor(.white).frame(width: 380, height: 40)
            }).background(.blue).clipShape(RoundedRectangle(cornerRadius: 10))
            
            
        }.background(Color(.init(white: 0, alpha: 0.05)))
        
        .navigationTitle(isLoginMode ? "Log In" : "Create Account")
        
    }
}
    private func logAction(){
        if isLoginMode{
            login()
        }else{
            createNewAccount()
            Database.shared.saveUser()
            //getUserrs()
            //Database.shared.getUser()
        }
    }
    
    private func login(){
        Auth.auth().signIn(withEmail: email, password: password){
            result , err in
            if let err = err{
                print(err)
                return
            }
            print("success  \(result?.user.uid)")
            
          // saveUser()
        }
        
    }
    
    private func createNewAccount(){
        Auth.auth().createUser(withEmail: email, password: password){
            result , err in
            if let err = err{
                print(err)
                return
            }
            
            print("success  \(result?.user.uid)")
        }
    }
    

    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
