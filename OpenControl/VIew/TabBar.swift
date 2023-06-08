//
//  TabBar.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 29.04.2023.
//

import SwiftUI

struct TabBar: View {
    @State var selectedTab = "1"
    @Binding var login : String
    var body: some View {
        TabView (selection: $selectedTab){
            
            if UserRole.role == .buisnes{
                
                Home().tag("2").tabItem({
                    Image(systemName: "house")
                    
                    
                })
            }
            Notes().tag("3").tabItem({
                Image(systemName: "square.and.pencil").foregroundColor(.blue)
                

            })
//            MainMessageView().tag("4").tabItem({
//                Image(systemName: "message")
//
//
//            })
            if UserRole.role == .buisnes{
                BotView(chat: BotViewModel()).tag("4").tabItem({
                    Image(systemName: "message")
                    
                    
                })
            }
            if UserRole.role == .inspector{
                ProfileInspector(login: $login).tag("5").tabItem({
                    Image(systemName: "person")
                    
                    
                })
            }else{
                Profile(login: $login).tag("5").tabItem({
                    Image(systemName: "person")
                    
                    
                })
            }
           
        }
        .tint(Color(hex: "DC3C2D"))
    }
}

//struct TabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBar()
//    }
//}
