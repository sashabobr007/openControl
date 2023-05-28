//
//  Video.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 20.04.2023.
//

import SwiftUI

import AgoraUIKit
import AgoraRtcKit
import _PhotosUI_SwiftUI

struct Token : Decodable{
    let rtcToken : String
}

struct Video: View {
    let user : User?
    init(user: User?) {
        self.user = user
        self.chat = ChatViewModel(user: user)
        self.id = Database.shared.getUuid()
        
    }
    
    
    let id : String?
    @State var selectedItems: [PhotosPickerItem] = []

    @State private var image : UIImage?
    @State private var videoURL: URL?
    @State private var documentURL: URL?


    @State private var showSheet = false
    @State private var showingVideoPicker = false
    @State private var showingDocumentPicker = false
    
    @State var chatText = ""
    @ObservedObject private var chat : ChatViewModel
    
    @State var mDate = ""
    
    
    let appId = "862e4e676c6c497f97014b5cd0c8f5bf"
    
    let uid = Database.shared.getUuid()
    
    @State var isActive : Bool?
    
    @State var idd : UInt?

    @State var token : String?
    
    @State var chanel : String?
    
    @State var show : Bool = false
    
    @State var start : Bool = true

    
    @State var recordData : (UInt, String, String)?


    var agview: AgoraViewer {
        var agoraView = AgoraViewer(
          connectionData: AgoraConnectionData(
            appId: appId,
            rtcToken: token
          ),
          style: .floating
        )
        
        agoraView.viewer.join(channel: chanel ?? "", with: token, uid: idd)
        
        //agoraView.join(channel: "test1", with: token, as: .broadcaster)
        return agoraView
      }

    var body: some View {
        
            ZStack{
                if token == nil{
                    ProgressView().font(.system(size: 32))
                }else{
                    VStack {
                        
                        VStack {
                            agview
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                        
                        VStack{
                            Button {
                                self.show = true
                                
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 15).frame(width: 176, height: 50).foregroundColor(mainColorBlue1)
                                    Text("Создать чат").foregroundColor(.white)
                                }
                            }.sheet( isPresented: $show) {
                               // ChatView(user: user)
                                ChatView(user: user, chat: ChatViewModel(user: user), show : $show)
                                //                            .onTapGesture {
                                //                                sheetDetail = nil
                                //                            }
                            }
                        }

                        Button(action: {
                            agview.viewer.exit()
                        }, label: {
                            Text("Покинуть").frame(maxWidth: .infinity, maxHeight: 50).foregroundColor(.white)
                        }).background(.red).clipShape(Capsule()).frame(width: 380, height: 40)
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                }
            }.onAppear(perform: {
                
                Database.shared.db.collection("users").document(self.user!.uid).getDocument { snaphot, error in
                    if let er = error{
                        print(er)
                        
                    }
                    else {
                        let data = snaphot?.data()
                        
                        
//                        isActive = data?["video"] as? Bool ?? false
//                        print(isActive)
                        
                        
                        if UserRole.role == .inspector{
                            self.chanel = "\(self.user?.uid ?? "")-\(UserRole.uid)"
                        }else{
                            self.chanel = "\(self.uid)-\(self.user?.uid ?? "")"
                        }
                        
                        
                        
                        let idRandom = UInt.random(in: 0..<1000000)
                        self.idd = idRandom
                        
                        let headers = ["accept": "application/json"]
                        
                        
                        
                        print(self.chanel)
                        let url = "http://alexbobr.ru:8080/rtc/\(self.chanel ?? "")/publisher/userAccount/\(String(idRandom))/"
                        
                        print(url )
                        
                        //print(url)
                        
                        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                                          cachePolicy: .useProtocolCachePolicy,
                                                          timeoutInterval: 10.0)
                        request.httpMethod = "GET"
                        request.allHTTPHeaderFields = headers
                        
                        let session = URLSession.shared
                        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                            if (error != nil) {
                                print(error)
                            } else {
                                let httpResponse = response as? HTTPURLResponse
                                do{
                                    let json = try JSONDecoder().decode(Token.self, from: data!)
                                    token = json.rtcToken
                                    // print(token)
                                    // print(json)
                                }
                                catch{
                                    print("Error")
                                }
                            }
                        })
                        
                        dataTask.resume()
                        
                    }
                    
                }
                
                
            })
            .onDisappear(perform: {
                agview.viewer.exit()
                //TODO: - Set user video toggle
            })
            .toolbar {
                Button {
                    startRecord()
                } label: {
                    if start{
                        Image(systemName: "autostartstop")
                    }else{
                        ProgressView()
                    }

                }

            }
        }
    
    func startRecord() {
      let body: [String: String] = ["channel": self.chanel ?? ""]
        print(body)
      let postData = try? JSONSerialization.data(withJSONObject: body)
      var request = URLRequest(url: URL(string: "http://alexbobr.ru:8080/api/start/call")!, timeoutInterval: 10)
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")

      request.httpMethod = "POST"
      request.httpBody = postData

      let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
          print(String(describing: error))
          return
        }
        guard let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []),
              let responseDict = responseJSON as? [String: Any],
              let responseData = responseDict["data"] as? [String: Any],
              let uid = responseData["uid"] as? UInt,
              let sid = responseData["sid"] as? String,
              let rid = responseData["rid"] as? String
        else {
          return
        }
        // Store the record data
          DispatchQueue.main.async {
              recordData = (uid, sid, rid)
              print(recordData)
              start.toggle()
              print(start)
          }
          

        // Update the record button
//        sender.isSelected = true
//        sender.setImage(UIImage(
//          systemName: "record.circle.fill",
//          withConfiguration: UIImage.SymbolConfiguration(scale: .large)
//        ), for: .normal)
//        sender.backgroundColor = .systemRed
      }
      task.resume()
    }
}


//
//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        Video()
//    }
//}

