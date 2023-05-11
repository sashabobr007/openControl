//
//  Api.swift
//  OpenControl
//
//  Created by Александр Алексеев on 06.05.2023.
//


import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

struct Database{
    static let shared = Database()
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    
    func downloadFile(){
        // Create a reference to the file you want to download
        let islandRef = storageRef.child("images/island.jpg")

        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            // Uh-oh, an error occurred!
          } else {
            // Data for "images/island.jpg" is returned
            //let image = UIImage(data: data!)
          }
        }
            
    }
    
//    func uploadFile(uploadData : Data){
//
//        // Create a reference to the file you want to upload
//        let riversRef = storageRef.child("images/rivers.jpg")
//
//        // Create file metadata including the content type
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpeg"
//        metadata.contentLanguage = ""
//
//
//
//        // Upload the file to the path "images/rivers.jpg"
//        let uploadTask = riversRef.putData(uploadData, metadata: metadata) { (metadata, error) in
//          guard let metadata = metadata else {
//            // Uh-oh, an error occurred!
//            return
//          }
//          // Metadata contains file metadata such as size, content-type.
//          let size = metadata.size
//
//          print(size)
//          // You can also access to download URL after upload.
//          riversRef.downloadURL { (url, error) in
//            guard let downloadURL = url else {
//              // Uh-oh, an error occurred!
//              return
//            }
//              print(downloadURL)
//          }
//        }
//
//    }
    
    func getUuid() -> String{
        guard let uid = Auth.auth().currentUser?.uid else { return ""}
        return uid
    }
    
    func getUserrs(){
       db.collection("users").getDocuments() { (querySnapshot, err) in
           if let err = err {
               print("Error getting documents: \(err)")
           } else {
               for document in querySnapshot!.documents {
                   let users = document.data()
                   print(users["email"])
               }
           }
       }
   }

    func getUser(){
       guard let uid = Auth.auth().currentUser?.uid else { return }
        print(uid)
       var email = "none"

        db.collection("users").document(uid).getDocument { snaphot, error in
           if let er = error{
               print(er)
            
           }
           else {
               let data = snaphot?.data()
               //print(data)
               print(data?["email"])
               email = data?["email"] as? String ?? "none"
               
               
           }
           
       }
   }
    
    func getOtherUser(uid : String){
       
       var video = false
        db.collection("users").document(uid).getDocument { snaphot, error in
           if let er = error{
               print(er)
            
           }
           else {
               let data = snaphot?.data()
               //print(data)
               //print(data?["email"])
               video = data?["video"] as? Bool ?? false
            }
           
       }
   }

    func saveUser(){
       guard let uid = Auth.auth().currentUser?.uid else { return }
        print(uid)
       guard let email = Auth.auth().currentUser?.email else { return }

       var ref : DocumentReference? = nil
       
       
       db.collection("users").document(uid).setData([
           "uid": uid,
           "email": email,
           "video" : false
       ]){ err in
           if let err = err {
               print("Error adding document: \(err)")
           } else {
               print("Document added")
           }
       }
       
   //        ref = db.collection("users").addDocument(data: [
   //            "uid": uid,
   //            "email": email
   //
   //        ]) { err in
   //            if let err = err {
   //                print("Error adding document: \(err)")
   //            } else {
   //                print("Document added with ID: \(ref!.documentID)")
   //            }
   //        }
       
   }

    
}

 
