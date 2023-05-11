//
//  TabBar.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 29.04.2023.
//

import SwiftUI

struct TabBar: View {
    @State var selectedTab = "1"
    

    
    var body: some View {
        TabView (selection: $selectedTab){
            
            
            Home().tag("2").tabItem({
                Image(systemName: "house")
                

            })
            Notes().tag("3").tabItem({
                Image(systemName: "square.and.pencil").foregroundColor(.blue)
                

            })
            MainMessageView().tag("4").tabItem({
                Image(systemName: "message")
                

            })
            Profile().tag("5").tabItem({
                Image(systemName: "person")
                

            })
           
        }
        .tint(Color(hex: "DC3C2D"))
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
