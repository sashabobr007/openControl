//
//  BotView.swift
//  OpenControl
//
//  Created by Александр Алексеев on 16.05.2023.
//

import SwiftUI
import HalfASheet

struct BotView: View {
    @ObservedObject private var chat : BotViewModel
    init(chat: BotViewModel) {
        self.chat = chat
    }
    @State private var isShowing = false
    @State private var zapis = false
    @State private var hasTimeElapsed = false


    @State private var text = "Довольны ли Вы общением с чат-ботом?"
    
    var body: some View {
        NavigationView {
            
            
            ZStack{
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
                        
                        Button {
                            isShowing.toggle()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 12).frame(width: 283, height: 47).foregroundColor(mainColorBlue1)
                                Text("Завершить консультацию").foregroundColor(.white).font(Font.custom("Manrope", size: 14)).fontWeight(.regular).fontWeight(.semibold)
                            }
                        }
                        
                        
                        VStack(spacing: 10){
                            
                            
                            //                         TextField("Написать сообщение", text: $chat.text).textFieldStyle(.roundedBorder).clipShape(Capsule())
                            
                            ZStack{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 30).frame(width: 327, height: 58).foregroundColor(.white)
                                    TextField("Написать сообщение", text: $chat.text)
                                    
                                    
                                    
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
                            
                            
                            
                        }.padding(.horizontal).padding(.bottom, 5).background(.white)
                    }
                    
                }
                HalfASheet(isPresented: $isShowing, title: "") {
                    VStack() {
                        Text(text).foregroundColor(.black).font(Font.custom("Manrope", size: 16)).fontWeight(.bold).padding(.bottom, 40)
                        
                        if self.zapis{
                            Button {
                                self.isShowing = false
                                self.zapis.toggle()
                                self.text = "Довольны ли Вы общением с чат-ботом?"
                                Task{
                                    do {
                                        try await delayText()
                                    }catch{
                                        
                                    }
                                }
                                
                            } label: {
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 12).foregroundColor(mainColorBlue1).frame(width: 304, height: 50)
                                    Text("Записаться").foregroundColor(.white).font(Font.custom("Manrope", size: 14)).fontWeight(.regular).fontWeight(.bold)

                                }
                                
//                                NavigationLink {
//                                    NewNote()
//                                } label: {
                                   
//                                }
                            }

                            
                            
                            
                        }else{
                            HStack{
                                Button{
                                    self.text = "Для получения более детальной информации вы можете записаться на консультацию с контрольно надзорным органом"
                                    self.zapis.toggle()
                                }label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 12).foregroundColor(Color(hex: "DADADA")).frame(width: 162.41, height: 50)
                                        Text("нет").foregroundColor(Color(hex: "E93535"))
                                        
                                    }
                                }
                                
                                Spacer()
                                
                                Button{
                                    self.isShowing.toggle()
                                }label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 12).foregroundColor(mainColorBlue1).frame(width: 162.41, height: 50)
                                        Text("Да").foregroundColor(.white)
                                        
                                    }
                                }
                            }
                        }
                        
                    }
                    .padding()
                }
                .height(.proportional(0.40))
                .closeButtonColor(UIColor.white)
                .backgroundColor(.white)
                .contentInsets(EdgeInsets(top: 30, leading: 10, bottom: 30, trailing: 10))
            }
        }.background(
            NavigationLink(destination: NewNote(),
                              isActive: $hasTimeElapsed) {  }
        )
        }
    
    private func delayText() async {
            // Delay of 7.5 seconds (1 second = 1_000_000_000 nanoseconds)
            try? await Task.sleep(nanoseconds: 500_000_000)
            hasTimeElapsed = true
        }
}
        
    
//struct BotView_Previews: PreviewProvider {
//    static var previews: some View {
//        BotView()
//    }
//}
