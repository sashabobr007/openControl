//
//  ProfilViewModel.swift
//  OpenControl
//
//  Created by Александр Алексеев on 26.05.2023.
//

import Foundation


import Firebase
import FirebaseCore
import FirebaseFirestore


class ProfilViewModel: ObservableObject {
    @Published var kno = ""
    @Published var email = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var surName = ""
    @Published var inn = ""
    @Published var snils = ""
    //@Published var users : [User] = []
    
    init(){
        if UserRole.role == .inspector{
            fetchCurrentInspector()
        }else{
            fetchCurrentUser()
        }
    }
    
    func addCurrentUser () {
       
       guard let uid = Auth.auth().currentUser?.uid else { return }
        print(uid)
       
        var params : [String : Any] = [
        
              "userId": uid,
              "email": email,
              "firstName": firstName,
              "lastName": lastName,
              "surName": surName,
              "inn": Int(inn) ?? 0,
              "snils": Int(snils) ?? 0
            
        ]
        
        Database.shared.saveUser(path: "/business-info/update", parameters: params) { (value : Welcome) in
            print(params)
        }
       
       
      
   }
    
     func fetchCurrentUser () {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
         print(uid)
        
        Database.shared.kno(path: "/business-info?userId=\(uid)") { (value : UserJson) in
            
            self.email = value.user.email
            self.firstName = value.user.firstName
            self.lastName = value.user.lastName
            self.surName = value.user.surName
            self.inn = String(value.user.inn)
            self.snils = String(value.user.snils)

        }
        
        
       
    }
    private func fetchCurrentInspector () {
        
        
        Database.shared.kno(path: "/knos") { (value : Kno) in
            
            for item in value.knoList{
                if item.id == Int(UserRole.uid) ?? 1{
                    self.kno = item.name
                }
            }
            

        }
        
        
       
    }
    
    
}

