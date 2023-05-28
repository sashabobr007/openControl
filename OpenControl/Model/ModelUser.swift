//
//  ModelUser.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 20.04.2023.
//

import Foundation

enum Role{
    case buisnes, inspector
}

struct UserRole{
    static var role : Role = .buisnes
    static var uid = ""
    
}


struct User : Identifiable{
    let uid, email : String
    var id: String { uid }
}
