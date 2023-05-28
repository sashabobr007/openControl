//
//  Enter.swift
//  OpenControl
//
//  Created by Александр Алексеев on 16.05.2023.
//

import SwiftUI

struct Enter: View {
    @Binding var login : String
    var body: some View {
      //  NavigationView {
            
            
            VStack (alignment: .leading){
                HStack{
                    ZStack{
                        Text("открытый").font(Font.custom("Manrope", size: 28)).fontWeight(.regular).padding(.trailing, 18)
                        Text("контроль").font(Font.custom("Manrope", size: 38)).fontWeight(.bold).padding(.top, 45).padding(.leading, 28)
                    }
                    Circle().foregroundColor(mainColorOrange1).frame(width: 10).padding(.top, 60)
                }
      VStack{
                    
                    HStack{
                        ZStack{
                            Image("Vector").resizable().scaledToFit().frame(width: 29, height: 34).padding(.leading, 30)
                            Image("Vector1").resizable().scaledToFit().frame(width: 36, height: 41).padding(.leading, 30)
                        }
                        
                        VStack{
                            Text("При поддержке ").foregroundColor(.black).font(Font.custom("Manrope", size: 14)).fontWeight(.bold).padding(.trailing, 200)
                            Text("Правительства Москвы").foregroundColor(.black).font(Font.custom("Manrope", size: 14)).fontWeight(.bold).frame(minWidth: 0, maxWidth: .infinity).lineLimit(1).padding(.trailing, 145)
                        }
                    }.padding(.top)
                    
                    HStack{
                        NavigationLink {
                            SwiftUIView(email1: $login, inspector: false)
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 12).frame(width: 170, height: 168).foregroundColor(mainColorOrange1)
                                Text("Войти ").font(Font.custom("Manrope", size: 14)).fontWeight(.regular).foregroundColor(.white).padding(.top, 40).padding(.trailing, 30).padding(.trailing, 60)
                                Text("Как бизнес").font(Font.custom("Manrope", size: 20)).fontWeight(.regular).foregroundColor(.white).padding(.top, 80).padding(.trailing, 30)
                                
                            }
                        }
                        
                        NavigationLink {
                            SwiftUIView(email1: $login, inspector: true)
                            
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 12).frame(width: 170, height: 168).foregroundColor(mainColorOrange1)
                                Text("Войти ").font(Font.custom("Manrope", size: 14)).fontWeight(.regular).foregroundColor(.white).padding(.top, 40).padding(.trailing, 90)
                                Text("Как инспектор").font(Font.custom("Manrope", size: 20)).fontWeight(.regular).foregroundColor(.white).padding(.top, 80).padding(.leading,10)
                                
                            }.padding(.leading, 30)
                        }
                        
                    }.padding(.trailing, 5).padding(.top)
                    
                    
                    
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading).background(mainColorOrange2)
                
                
                
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            
            
            
        
    }
}

//struct Enter_Previews: PreviewProvider {
//    static var previews: some View {
//        Enter(login: )
//    }
//}
