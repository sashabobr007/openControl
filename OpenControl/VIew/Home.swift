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
                HStack{
                    ZStack{
                        Text("открытый").font(Font.custom("Manrope", size: 28)).fontWeight(.regular).padding(.trailing, 18)
                        Text("контроль").font(Font.custom("Manrope", size: 38)).fontWeight(.bold).padding(.top, 45).padding(.leading, 28)
                    }.padding(.leading)
                    Circle().foregroundColor(mainColorOrange1).frame(width: 10).padding(.top, 60)
                    Spacer()
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

                            BotView(chat: BotViewModel())
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 15).frame(width: 170, height: 168).foregroundColor(Color(hex: "D9D9D9")).padding(.trailing)
                                Text("Чат-бот").foregroundColor(.black)
                            }
                        }
                      
                        NavigationLink {
                            Notes()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 15).frame(width: 170, height: 168).foregroundColor(Color(hex: "D9D9D9"))
                                Image("Combined-Shape").resizable().frame(width: 42, height: 47).padding(.bottom, 100).padding(.leading, 90)
                                Text("Ближайшая запись:").font(Font.custom("Manrope", size: 14)).fontWeight(.regular).foregroundColor(.black)
                            }
                        }
                    }
                    HStack{
                        VStack{
                            
                            Text("Одна платформа").foregroundColor(.black).font(Font.custom("Manrope", size: 23)).fontWeight(.regular).padding(.trailing, 65)
                            Text("для решения вопросов").foregroundColor(.black).font(Font.custom("Manrope", size: 23)).fontWeight(.regular)
                            Text("с проверками бизнеса").foregroundColor(.black).font(Font.custom("Manrope", size: 23)).fontWeight(.regular)
                            
                            Text("Сервис взаимодействия  бизнеса ").foregroundColor(.black).font(Font.custom("Manrope", size: 14)).fontWeight(.regular).padding(.top)
                            Text("с органами контроля").foregroundColor(.black).font(Font.custom("Manrope", size: 14)).fontWeight(.regular).padding(.trailing, 75)
                            
                        }.padding(.leading)
                     Spacer()
                    }.padding(.top)
                    
                    ZStack {
                        Circle().frame(width: 290, height: 293).foregroundColor(mainColorRed2).padding(.top)
                        Image("person").resizable().frame(width: 225, height: 329)

                        
                    }
                    
                    
                   
                    
                }.background(mainColorOrange2)
                
            }
            
            
        }.onAppear {
           // Database.shared.kno { (value : Measurements) in
              //  print(value.measures[0].name)
          //  }
            
//            let params : [String : Any] = [
//                "id": 12345,
//                "question": "какие требования есть к вывескам",
//                "new_chat": true
//            
//            ]
            
//            Database.shared.bot(parameters: params) { (value : BotJson) in
//                print(value.answer)
//            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
