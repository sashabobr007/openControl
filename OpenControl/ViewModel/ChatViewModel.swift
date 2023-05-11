//
//  ChatViewModel.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 20.04.2023.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

enum PickerDown : String {
    case image = "image"
    case video = "video"
    case file = "file"
}


struct ChatMessage : Identifiable{
    let fromId, toId, text : String
    
    var id : String { docId }
    
    let docId : String
    
    let docUrl : String
    
    let docType : String
    
    let timeDay : String
    let timeHM : String

    
    init(docId : String, data  : [String : Any]) {
        self.docId = docId
        self.fromId = data["from"] as? String ?? ""
        self.toId = data["to"] as? String ?? ""
        self.text = data["text"] as? String ?? ""
        self.docUrl = data["docUrl"] as? String ?? ""
        self.docType = data["docType"] as? String ?? ""
        let time = data["time"] as? Timestamp ?? Timestamp()
        let timeDate = Date(timeIntervalSince1970: Double(time.seconds))
        
        self.timeDay = timeDate.formatted(date: .numeric, time: .omitted)
        self.timeHM = timeDate.formatted(date: .omitted, time: .shortened)

        //print(self.timeDay)
        //print(self.timeHM)
    }
}

class ChatViewModel : ObservableObject {
    
    @Published var text = ""
    
    @Published var chatMessages = [ChatMessage]()
    
    @Published var count = 0
    
    
    
    let user : User?
    
    init(user : User?){
        self.user = user
        fetchMessages()
    }
    
    private func fetchMessages(){
        let fromID = Database.shared.getUuid()
        guard let toID = user?.uid else {return }
        Database.shared.db.collection("messages").document(fromID).collection(toID).order(by: "time").addSnapshotListener { query, error in
            if let error = error {
                return
            }
            
            query?.documentChanges.forEach({ change in
                if change.type == .added{
                    let data = change.document.data()
                    let id = change.document.documentID
                    let chatMessage = ChatMessage(docId: id, data: data)
                    self.chatMessages.append(chatMessage)
                }
            })
            DispatchQueue.main.async {
                self.count += 1
                
            }
            
        }
    }
    
    func sendDoc(uploadData : Data, picker : PickerDown , file : URL?){
        guard let from = Auth.auth().currentUser?.uid else { return }
        guard let to = user?.uid else { return }
        let docType = picker.rawValue
        var path = from + "/"
        let uuid = UUID().uuidString
        //print(uuid)
        path += uuid
        if picker == .image{
            path += ".jpg"
        }else if picker == .video{
            
            path += ".MOV"
        }
        
        print(path)
        
        let riversRef = Database.shared.storageRef.child(path)
        
        // Create file metadata including the content type
        //        let metadata = StorageMetadata()
        //        metadata.contentType = "image/jpeg"
        //        metadata.contentLanguage = ""
        
        if picker == .file{
            riversRef.putFile(from: file!) { _, err in
                if err != nil{
                    
                }else{
                    print("ok")
                    riversRef.downloadURL { (url, error) in
                        guard let downloadURL = url else {
                            return
                        }
                        print(downloadURL)
                        DispatchQueue.main.async {
                            print(downloadURL)
                            
                            self.handleSend(text: "", docUrl: downloadURL.description, docType: docType)
                        }
                    }
                }
                
            }
            
        }else{
            let uploadTask = riversRef.putData(uploadData, metadata: nil) { (metadata, error) in
//                      guard let metadata = metadata else {
//                        // Uh-oh, an error occurred!
//                        return
//                      }
//                      // Metadata contains file metadata such as size, content-type.
//                      let size = metadata.size
            
                      //print(size)
                      // You can also access to download URL after upload.
                      riversRef.downloadURL { (url, error) in
                        guard let downloadURL = url else {                          return
                        }
                          DispatchQueue.main.async {
                              print(downloadURL)
                              
                              self.handleSend(text: "", docUrl: downloadURL.description, docType: docType)
            
            
                          }
                      }
                    }
            
            
            
        }
        
        
        
            }
        
    func handleSend(text : String, docUrl : String, docType : String){
            guard let from = Auth.auth().currentUser?.uid else { return }
            guard let to = user?.uid else { return }
            
            Database.shared.db.collection("messages").document(from).collection(to).document().setData([
                "from": from,
                "to": to,
                "text" : self.text,
                "time"  : Timestamp(),
                "docUrl" : docUrl,
                "docType" : docType
            ]){ err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added")
                }
            }
            self.count += 1
            
            Database.shared.db.collection("messages").document(to).collection(from).document().setData([
                "from": from,
                "to": to,
                "text" : self.text,
                "time"  : Timestamp(),
                "docUrl" : docUrl,
                "docType" : docType
            ]){ err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added")
                }
            }
            
            self.text = ""
            
        }
        
    }

