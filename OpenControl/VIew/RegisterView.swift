//
//  RegisterView.swift
//  OpenControl
//
//  Created by Александр Алексеев on 24.05.2023.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import UIKit

struct RegisterView: View {
    @Binding var email1 : String
    @State var inspector : Bool
    @State var email = ""
    
    @State var showsAlert = false


    @State var password = ""
    @Environment(\.presentationMode) private var presentationMode

  
    var body: some View {
        
        VStack{
            Text("Регистрация").font(Font.custom("Manrope", size: 20)).fontWeight(.bold).foregroundColor(mainColorOrange1).padding(.bottom, 40)
                
                Group{
                    TextField("", text: $email, prompt: Text("Email").foregroundColor(mainColorOrange1)).keyboardType(.emailAddress).textInputAutocapitalization(.none).padding(.horizontal)
                    Capsule().foregroundColor(mainColorOrange1).frame(width: 360,height: 5)
                    SecureField("", text: $password, prompt: Text("пароль").foregroundColor(mainColorOrange1)).padding(.horizontal).padding(.top)
                    Capsule().foregroundColor(mainColorOrange1).frame(width: 360,height: 5)
                }.frame(height: 30).background(.white).padding(.bottom, 5).padding(.horizontal)
                
                HStack{
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Уже есть аккаунт?").foregroundColor(mainColorOrange1).padding(.trailing, 30)
                    }
                    
                }
                
                Button(action: {
                    logAction()
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 16).frame(width: 327, height: 60).foregroundColor(mainColorOrange1)
                        Text("Зарегестрироваться").foregroundColor(.white)
                    }
                }).padding()
        }.alert(isPresented: $showsAlert) {
            Alert(title: Text("вы ввели некорректный email"))
            

        }
        
        }
    
    private func logAction(){
        
        createNewAccount()
    }
    
//    private func login(){
//        Auth.auth().signIn(withEmail: email, password: password){
//            result , err in
//            if let err = err{
//                print(err)
//                return
//            }
//            print("success  \(result?.user.uid)")
//            
//          // saveUser()
//        }
//        
//    }
    
    private func createNewAccount(){
        Auth.auth().createUser(withEmail: email, password: password){
            result , err in
            if let err = err{
                self.showsAlert = true

                print(err)
                return
            }
            print("success : \(result?.user.uid ?? "")")

            var params : [String : Any] = [
                "userId": result?.user.uid ?? "",
                  "role": "BUSINESS"
                        ]
            
            Database.shared.saveUser(path: "/user", parameters: params) { (value : Welcome) in
                DispatchQueue.main.async {
                    var params : [String : Any] = [
                    
                          "userId": result?.user.uid ?? "",
                          "email": email,
                          "firstName": "",
                          "lastName": "",
                          "surName": "",
                          "inn": 0,
                          "snils": 0
                        
                    ]
                    
                    Database.shared.saveUser(path: "/business-info/update", parameters: params) { (value : Welcome) in
                        print(params)
                    }
                }
                
            }
            
           
            
            Database.shared.saveUserFire()
            
            
            email1 = result?.user.uid ?? ""

            
            
        }
    }
    

    
}


struct RegisterView_Previews: PreviewProvider {
    @State static var isShowing = ""
    static var previews: some View {
        RegisterView( email1: $isShowing, inspector: false)
    }
}
