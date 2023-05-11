//
//  Home.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 02.05.2023.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView{
            ScrollView{
                ZStack {
                   
                    Rectangle().frame(width: 395, height: 84).foregroundColor(mainColorOrange3)
                    HStack{
                        Image(systemName: "fish").foregroundColor(.blue).padding(.leading, 30)
//                        Spacer()
                        Text("При поддержке Правительства Москвы").foregroundColor(.black).frame(minWidth: 0, maxWidth: .infinity).lineLimit(1)
                    }
                }
                
                HStack{
                    Text("открытый")
                    Text("контроль")
                    Circle().frame(width: 10).foregroundColor(mainColorRed2).padding(.top)
                }.padding(.vertical)
                
                ZStack {
                    Ellipse().frame(width: 438, height: 222).foregroundColor(mainColorRed2).padding(.top)
                    VStack{
                        Text("Одна платформа").foregroundColor(Color(hex: "E6FDFD"))
                        Text("для решения вопросов").foregroundColor(Color(hex: "FDEAA8"))
                        Text("с проверками бизнеса").foregroundColor(Color(hex: "E6FDFD"))

                    }

                }
                
                Image("person")
                
                RoundedRectangle(cornerRadius: 15).frame(width: 360, height: 272).foregroundColor(Color(hex: "F2F2F2")).padding(.vertical)
                
                RoundedRectangle(cornerRadius: 15).frame(width: 360, height: 272).foregroundColor(Color(hex: "F2F2F2"))
                
                
                
            }
            
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
