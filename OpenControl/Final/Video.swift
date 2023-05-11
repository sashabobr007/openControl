//
//  Video.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 20.04.2023.
//

import SwiftUI

import AgoraUIKit
import AgoraRtcKit

struct Token : Decodable{
    let rtcToken : String
}

struct Video: View {
    let user : User?
    init(user: User?) {
        self.user = user
        
        
    }
    let appId = "862e4e676c6c497f97014b5cd0c8f5bf"
    
    let uid = Database.shared.getUuid()
    
    @State var isActive : Bool?
    
    @State var id : UInt?

    @State var token : String?
    
    @State var chanel : String?

    var agview: AgoraViewer {
        var agoraView = AgoraViewer(
          connectionData: AgoraConnectionData(
            appId: appId,
            rtcToken: token
          ),
          style: .floating
        )
        
        agoraView.viewer.join(channel: chanel ?? "", with: token, uid: id)
        
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
                      }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                      Button(action: {
                          agview.viewer.exit()
                      }, label: {
                          Text("Leave").frame(maxWidth: .infinity, maxHeight: .infinity).foregroundColor(.white)
                      }).background(.red).clipShape(Capsule()).frame(width: 380, height: 40)
                  }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
              }
          }.onAppear(perform: {
              
              Database.shared.db.collection("users").document(self.user!.uid).getDocument { snaphot, error in
                  if let er = error{
                      print(er)
                   
                  }
                  else {
                      let data = snaphot?.data()
                     
                      
                      isActive = data?["video"] as? Bool ?? false
                      print(isActive)
                      if !(isActive ?? false){
                          self.chanel = "\(self.uid)-\(self.user?.uid ?? "")"
                      }else{
                          self.chanel = "\(self.user?.uid ?? "")-\(self.uid)"
                      }
                      let idRandom = UInt.random(in: 0..<1000000)
                      self.id = idRandom
                      
                      let headers = ["accept": "application/json"]
                      
                      
                      
                      print(self.chanel)
                      let url = "http://alexbobr.ru:8080/rtc/\(self.chanel ?? "")/publisher/userAccount/\(String(idRandom))/"

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
      }
}
//
//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        Video()
//    }
//}

