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
    
    @Binding var email1 : String
    @State var inspector : Bool
    @State var email = ""
    @State var password = ""

    @State var showsAlert = false

    @State var text = "Email"
    
    var body: some View {
        VStack{
            
                
                Group{
                    TextField("", text: $email, prompt: Text(text).foregroundColor(mainColorOrange1)).keyboardType(.emailAddress).textInputAutocapitalization(.none).padding(.horizontal)
                    Capsule().foregroundColor(mainColorOrange1).frame(width: 360,height: 5)
                    SecureField("", text: $password, prompt: Text("пароль").foregroundColor(mainColorOrange1)).padding(.horizontal).padding(.top)
                    Capsule().foregroundColor(mainColorOrange1).frame(width: 360,height: 5)
                }.frame(height: 30).background(.white).padding(.bottom, 5).padding(.horizontal)
                
                HStack{
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Забыли пароль?").foregroundColor(mainColorOrange1).padding(.trailing, 30)
                    }
                    
                }
                
                Button(action: {
                    logAction()
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 16).frame(width: 327, height: 60).foregroundColor(mainColorOrange1)
                        Text("Войти").foregroundColor(.white)
                    }
                }).padding()
                
                NavigationLink(destination: {
                    RegisterView(email1: $email1, inspector: inspector)
                }, label: {
                    Text("Зарегестрироваться").foregroundColor(mainColorOrange1)
                })
                .alert(isPresented: $showsAlert) {
                    Alert(title: Text("вы ввели некорректный email"))
                    

                }

        }.onAppear {
            if inspector{
                self.text = "введите номер кно(от 1 до 19) @yandex.ru"
            }
        }
        }
    
    private func logAction(){
        if inspector{
            print(email)
            if let log = Int(email.split(separator: "@").first?.description ?? "5"){
                if log > 0 && log < 20{
                    UserRole.role = .inspector
                    UserRole.uid = email.split(separator: "@").first?.description ?? "5"
                    Auth.auth().signIn(withEmail: email, password: password){
                        result , err in
                        if let err = err{
                            self.showsAlert = true

                            print(err.localizedDescription)
                            return
                        }
                        print("success  \(result?.user.uid)")
                        self.email1 = "s"
                        
                      // saveUser()
                    }
                    self.email1 = "s"
                }else{
                    showsAlert.toggle()
                }
            }else{
                showsAlert.toggle()
            }
        }else{
            login()
        }
        
    }
    
    private func login(){
        Auth.auth().signIn(withEmail: email, password: password){
            result , err in
            if let err = err{
                self.showsAlert = true

                print(err.localizedDescription)
                return
            }
            print("success  \(result?.user.uid)")
            self.email1 = "s"
            
          // saveUser()
        }
        
    }
    
//    private func createNewAccount(){
//        Auth.auth().createUser(withEmail: email, password: password){
//            result , err in
//            if let err = err{
//                print(err)
//                return
//            }
//
//            Database.shared.saveUser()
//
//            email1 = result?.user.uid ?? ""
//            print("success  \(result?.user.uid)")
//
//        }
//    }

}




struct ContentView_Previews: PreviewProvider {
    @State static var isShowing = ""
    static var previews: some View {
        SwiftUIView( email1: $isShowing, inspector: false)
    }
}
