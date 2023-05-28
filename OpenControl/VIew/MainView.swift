//
//  MainView.swift
//  OpenControl
//
//  Created by Александр Алексеев on 26.05.2023.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

struct MainView: View {
    @State private var login = ""

    var body: some View {
        
        NavigationView {
            if login.count != 0{
                TabBar(login: $login)
            }else{
                //SwiftUIView(email1: $login)
                Enter(login: $login)
            }
            
                
            //TabBar()
            
            //PickerNew()
        }.onAppear {
            login = Auth.auth().currentUser?.uid ?? ""
            print(login)
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
