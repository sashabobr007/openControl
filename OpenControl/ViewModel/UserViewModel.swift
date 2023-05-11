//
//  UserViewModel.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 20.04.2023.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore


class MainMessagesViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var users : [User] = []
    
    init(){
        fetchCurrentUser()
        getUserrs()
    }
    
    private func fetchCurrentUser () {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
         print(uid)
        Database.shared.db.collection("users").document(uid).getDocument { snaphot, error in
            if let er = error{
                print(er)
             
            }
            else {
                let data = snaphot?.data()
                //print(data)
                //print(data?["email"])
                self.email = data?["email"] as? String ?? "none"
            }
            
        }
    }
    
    private func getUserrs(){
        Database.shared.db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
               // print(querySnapshot?.documents)
                for document in querySnapshot!.documents {
                   let user = document.data()
                    let newUser = User(uid: user["uid"] as! String , email: user["email"] as! String)
                    self.users.append(newUser)
                   
//                    print(user["email"])
                }
                // print(self.users)
            }
        }
    }
    
    
    
}
