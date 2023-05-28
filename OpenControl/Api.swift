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



// MARK: - Appointment
struct AppointmentDetail: Decodable {
    let id, time: String
    let knoID: Int
    let businessID: String
    let inspectionID: JSONNull?
    let measureID: Int
    let description, files: JSONNull?
    let status: String

    enum CodingKeys: String, CodingKey {
        case id, time
        case knoID = "knoId"
        case businessID = "businessId"
        case inspectionID = "inspectionId"
        case measureID = "measureId"
        case description, files, status
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Decodable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

struct ap: Decodable {
    let id, time: String
    let knoID: Int
    let businessID, inspectionID: String?
    let measureID: Int
    let description, files, status: String?
    
}

struct AppointmentList: Decodable {
    let appointments: [Appointment]
}

// MARK: - Appointment
struct Appointment: Decodable {
    let id, time, status, withWho: String
}


struct Window: Decodable {
    let freeWindows: [FreeWindow]
}

// MARK: - FreeWindow
struct FreeWindow: Decodable {
    let id, appointmentTime: String
}

struct Kno: Decodable {
    let knoList: [KnoList]
}

// MARK: - KnoList
struct KnoList: Decodable {
    let id: Int
    let name: String
}

struct UserJson: Decodable {
    let user: UserJ
}

// MARK: - User
struct UserJ: Decodable {
    let id, email, firstName, lastName: String
    let surName: String
    let inn, snils: Int
}

struct Welcome: Decodable {
    
}

struct BotJson: Decodable {
    let answer: String
    let success: Bool
}


struct Measurements: Decodable {
    let measures: [Measure]
}

// MARK: - Measure
struct Measure: Codable {
    let id: Int
    let name: String
}

struct Database{
    static let shared = Database()
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    
    let url = "http://178.170.195.121:5000"
    
    let urlBot = "http://178.170.194.57:8080/question"

    
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
    
    func saveApp<T : Decodable>( path : String, parameters : [String : Any], decodedValue : @escaping  (T) -> Void) {
           
           let headers = [
             "accept": "application/json",
             "Content-Type": "application/json"
           ]
           
        let newUrl = self.url + path
           
           let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])

           
           guard let url = URL (string: newUrl) else {return}
                   
                   var request = URLRequest(url: url)
                   request.httpMethod = "PUT"
                   request.allHTTPHeaderFields = headers
                   request.httpBody = (postData ?? Data()) as Data

           
                   let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                       if (error != nil) {
                           print(error ?? "")
                       } else {
                           let httpResponse = response as? HTTPURLResponse
                           print(httpResponse?.statusCode ?? "")
                           
                           do{
                               let json : T = try JSONDecoder().decode(T.self, from: data!)
                               decodedValue(json)
                              // print(json)
                           }
                           catch{
                               print("Error")
                           }
                           
                           
                       }
                   })
                   task.resume()
           }
    
    func saveUser<T : Decodable>( path : String, parameters : [String : Any], decodedValue : @escaping  (T) -> Void) {
           
           let headers = [
             "accept": "application/json",
             "Content-Type": "application/json"
           ]
           
        let newUrl = self.url + path
           
           let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])

           
           guard let url = URL (string: newUrl) else {return}
                   
                   var request = URLRequest(url: url)
                   request.httpMethod = "POST"
                   request.allHTTPHeaderFields = headers
                   request.httpBody = (postData ?? Data()) as Data

           
                   let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                       if (error != nil) {
                           print(error ?? "")
                       } else {
                           let httpResponse = response as? HTTPURLResponse
                           print(httpResponse?.statusCode ?? "")
                           
                           do{
                               let json : T = try JSONDecoder().decode(T.self, from: data!)
                               decodedValue(json)
                              // print(json)
                           }
                           catch{
                               print("Error")
                           }
                           
                           
                       }
                   })
                   task.resume()
           }
    
    func bot<T : Decodable>(parameters : [String : Any], decodedValue : @escaping  (T) -> Void) {
           
           let headers = [
             "accept": "application/json",
             "Content-Type": "application/json"
           ]
           
        let newUrl = self.urlBot
           
           let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])

           
           guard let url = URL (string: newUrl) else {return}
                   
                   var request = URLRequest(url: url)
                   request.httpMethod = "POST"
                   request.allHTTPHeaderFields = headers
                   request.httpBody = (postData ?? Data()) as Data

           
                   let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                       if (error != nil) {
                           print(error ?? "")
                       } else {
                           let httpResponse = response as? HTTPURLResponse
                          // print(httpResponse?.statusCode ?? "")
                           
                           do{
                               let json : T = try JSONDecoder().decode(T.self, from: data!)
                               decodedValue(json)
                              // print(json)
                           }
                           catch{
                               print("Error")
                           }
                           
                           
                       }
                   })
                   task.resume()
           }
    
    
    func kno<T : Decodable>(path :String,  decodedValue : @escaping  (T) -> Void) {
           
           let headers = ["accept": "application/json"]
        
        guard let url = URL (string: self.url + path) else {return}
                        
            var request = URLRequest(url: url)

           request.httpMethod = "GET"
           request.allHTTPHeaderFields = headers

           let session = URLSession.shared
           let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
             if (error != nil) {
               print(error)
             } else {
               let httpResponse = response as? HTTPURLResponse
                 print(httpResponse?.statusCode ?? "")
                 do{
                     let json : T = try JSONDecoder().decode(T.self, from: data!)
                     decodedValue(json)
                    // print(json)
                 }
                 catch{
                     print("Error")
                 }
             }
           })

           dataTask.resume()
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

    func saveUserFire(){
       guard let uid = Auth.auth().currentUser?.uid else { return }
        print(uid)
       guard let email = Auth.auth().currentUser?.email else { return }



       var ref : DocumentReference? = nil
       
       
//       db.collection("users").document(uid).setData([
//           "uid": uid,
//           "email": email,
//           "video" : false
//       ]){ err in
//           if let err = err {
//               print("Error adding document: \(err)")
//           } else {
//               print("Document added")
//           }
//       }
       
           ref = db.collection("users").addDocument(data: [
               "uid": uid,
               "email": email

           ]) { err in
               if let err = err {
                   print("Error adding document: \(err)")
               } else {
                   print("Document added with ID: \(ref!.documentID)")
               }
           }
       
   }

    
}

 
