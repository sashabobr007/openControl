//
//  BotView.swift
//  OpenControl
//
//  Created by Александр Алексеев on 16.05.2023.
//

import SwiftUI

struct BotView: View {
    @ObservedObject private var chat : BotViewModel
    init(chat: BotViewModel) {
        self.chat = chat
    }
    
    var body: some View {
        VStack{
            HStack{            
                Text("бот помощник").padding(.leading, 50)
                Spacer()
                           Button {
                               chat.restart()
                           } label: {
                               Image(systemName: "power")
                           }.padding(.trailing, 50)
           
           
           
                       }
            ScrollView{
                ScrollViewReader{ scrollViewProxy in
                    VStack{
                        
                        ForEach(chat.chatMessages){ message in
                            VStack{
                                if !message.bot{
                                    HStack{
                                        Spacer()
                                        VStack(alignment: .trailing){
                                            
                                            HStack{
                                                
                                                
                                                Text(message.text).foregroundColor(.white)
                                            }.padding().background(mainColorBlue1).cornerRadius(27, corners: [.bottomLeft, .topLeft, .topRight]).cornerRadius(2, corners: .bottomRight)
                                            
                                            //Text(message.text).foregroundColor(mainColorBlue1)
                                            
                                            
                                            
                                        }
                                        
                                    }.padding(.horizontal).padding(.top, 8)
                                }else{
                                    
                                    HStack{
                                        VStack(alignment: .leading){
                                            
                                            HStack{
                                                
                                                Text(message.text).foregroundColor(Color(hex: "3A3A41"))
                                            }.padding().background(Color(hex: "F0F0F5")).cornerRadius(27, corners: [.bottomRight, .topLeft, .topRight]).cornerRadius(2, corners: .bottomLeft)
                                            
                                            if chat.count == 0{
                                                HStack{
                                                    NavigationLink {
                                                        NewNote()
                                                    } label: {
                                                        ZStack{
                                                            RoundedRectangle(cornerRadius: 15).foregroundColor(mainColorBlue1).frame(width: 111, height: 92)
                                                            VStack{
                                                                Text("записаться на ").font(.system(size: 12)).foregroundColor(.white)
                                                                
                                                                
                                                                Text("косультацию").font(.system(size: 12)).foregroundColor(.white)
                                                            }
                                                            
                                                        }
                                                    }
                                                    
                                                    NavigationLink {
                                                        Notes()
                                                    } label: {
                                                        ZStack{
                                                            RoundedRectangle(cornerRadius: 15).foregroundColor(mainColorBlue1).frame(width: 111, height: 92)
                                                            VStack{
                                                                Text("Ближайшая запись  ").font(.system(size: 12)).foregroundColor(.white)
                                                                
                                                                
                                                                Text("на консультацию").font(.system(size: 12)).foregroundColor(.white)
                                                            }
                                                            
                                                        }
                                                    }
                                                    
                                                }
                                                
                                            }
                                            //
                                            //                                    Text(message.timeHM)
                                            
                                            
                                            
                                        }
                                        Spacer()
                                        
                                    }.padding(.horizontal).padding(.top, 8)
                                }
                            }
                        }
                        
                        
                        
                        HStack{
                            Spacer()
                        }
                       
                        .onReceive(chat.$count){_ in
                            withAnimation(.easeOut(duration: 0.5)){
                                scrollViewProxy.scrollTo("Empty", anchor: .bottom)
                            }
                            withAnimation(.easeOut(duration: 0.5)){
                                scrollViewProxy.scrollTo("Empty1", anchor: .bottom)
                            }
                        }
                        .id("Empty")
                        

                        
                    }
                    .id("Empty1")
                }.background(Color(hex: "FCFCFD")).clipped()
            }
            
            VStack{
                
                
                VStack(spacing: 10){
                    
                    
//                         TextField("Написать сообщение", text: $chat.text).textFieldStyle(.roundedBorder).clipShape(Capsule())
                    
                    ZStack{
                        TextField("Написать сообщение", text: $chat.text).textFieldStyle(.roundedBorder).clipShape(Capsule())
                       
                        HStack{
                            Spacer()
                            Button {
                                
                                if chat.text.count != 0{
                                    chat.handleSend()
                                }
                                
                            } label: {
                                Image(systemName: "paperplane.fill").font(.system(size: 24)).foregroundColor(mainColorBlue1)
                            }.padding(.horizontal).padding(.vertical, 8).cornerRadius(4).padding(.top, 5)
                            
                            
                        }
                    }
                        
//                        VStack{
//                            ScrollView{
//                                ForEach(chat.chatMessages.last!.answers, id: \.self) {answ in
//                                    Button {
//                                        chat.handleSend(an: answ)
//                                    } label: {
//                                        ZStack{
//                                            RoundedRectangle(cornerRadius: 20).foregroundColor(.white)
//                                            Text(answ.an)
//                                        }
//                                    }.frame(height: 50).padding(.vertical)
//
//                                }
//                            }
//                        }
                    
                    
                    
                }.padding(.horizontal).padding(.bottom, 5).background(Color(hex: "D9D9D9"))
            }
            
        }
        
//        .toolbar(content: {
//            HStack{
//                VStack(alignment: .leading){
//                    Text("бот помощник")
//                }
//                Text("                     ")
//                Spacer()
//                Button {
//                    chat.restart()
//                } label: {
//                    Image(systemName: "power")
//                }
//
//
//
//            }
//
//        })
        
        
    }
}
        
    
//struct BotView_Previews: PreviewProvider {
//    static var previews: some View {
//        BotView()
//    }
//}
