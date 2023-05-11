//
//  ModelUser.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 20.04.2023.
//

import Foundation


struct User : Identifiable{
    let uid, email : String
    var id: String { uid }
}
