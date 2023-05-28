//
//  MainMessageView.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 19.04.2023.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore




struct MainMessageView: View {
    @State var show : Bool = false

    
    @ObservedObject private var firebase = MainMessagesViewModel()
    
    @State var empty = false
        private var customNavBar : some View{
    //        HStack(spacing: 16){
    //            Image(systemName: "person.fill")
    //
    //            VStack (alignment: .leading){
    //                Text(firebase.email).font(.system(size: 24, weight: .semibold))
    //                HStack{
    //                    Circle().foregroundColor(.green).frame(width: 14, height: 14)
    //                    Text("Online").font(.system(size: 12, weight: .semibold)).foregroundColor(.gray)
    //                }
    //
    //            }
    //            Spacer()
    //            Button {
    //                shoLog.toggle()
    //            } label: {
    //                Image(systemName: "gear").font(.system(size: 24, weight: .bold))
    //            }
    //
    //
    //        }
           
                ZStack{
                    Rectangle().frame(width: 500, height: 150).foregroundColor(mainColorBlue)
                    HStack{
                        Text("Чаты").font(.largeTitle).padding(.leading, 80)
                        Spacer()
                    }
                }.frame(maxWidth: 200)
            
    
        }
    var body: some View {
        if empty{
            ZStack{
                Rectangle().frame(maxWidth: .infinity, maxHeight: .infinity).foregroundColor(mainColorBlue)
                VStack{
                    Image("illustration")
                    Text("Нет доступных чатов").font(.largeTitle)
                }
            }.ignoresSafeArea()
        }else{
            NavigationView {
                //
                VStack {
                    //
                    customNavBar.ignoresSafeArea()
                    
                    ScrollView {
                        NavigationLink(destination: {
                            BotView(chat: BotViewModel())
                        }, label: {
                            VStack{
                                HStack(spacing: 16) {
                                    //Image(systemName: "person.fill").font(.system(size: 32)).foregroundColor(.black).padding(8).overlay(RoundedRectangle(cornerRadius: 44).stroke(.black, lineWidth: 1))
                                    
                                    VStack(alignment: .leading){
                                        Text("Bot").font(.system(size: 16, weight: .bold)).foregroundColor(.blue)
                                        
                                        Text("Message sent to user").font(.system(size: 14)).foregroundColor(.gray)
                                    }
                                    Spacer()
                                    
                                    
                                    
                                }
                                
                                Divider().padding(.vertical)
                            }.padding(.horizontal)
                            //.navigationTitle( "Main Messages View")
                        })
                        ForEach(firebase.users) { user in
                            NavigationLink(destination: {
                               // ChatView(user: user)
                                ChatView(user: user, chat: ChatViewModel(user: user), show : $show)
                            }, label: {
                                VStack{
                                    HStack(spacing: 16) {
                                        //Image(systemName: "person.fill").font(.system(size: 32)).foregroundColor(.black).padding(8).overlay(RoundedRectangle(cornerRadius: 44).stroke(.black, lineWidth: 1))
                                        
                                        VStack(alignment: .leading){
                                            Text(user.email).font(.system(size: 16, weight: .bold)).foregroundColor(.blue)
                                            
                                            Text("Message sent to user").font(.system(size: 14)).foregroundColor(.gray)
                                        }
                                        Spacer()
                                        
                                        
                                        
                                    }
                                    
                                    Divider().padding(.vertical)
                                }.padding(.horizontal)
                                //.navigationTitle( "Main Messages View")
                            })
                            
                            
                        }
                    }
                    
                }
                
                //                .overlay(alignment: .bottom, content: {
                //                        Button(action: {
                //
                //                        }, label: {
                //                            HStack{
                //                                Spacer()
                //                                Text("+ New Messege").font(.system(size: 16, weight: .bold))
                //
                //                                Spacer()
                //                            }.foregroundColor(.white).background(.blue).cornerRadius(32).padding(.horizontal).padding(.vertical).shadow(radius: 15)
                //                        })
                //                    })
                
                
                //  }
                
                
                //.navigationTitle(Text("dfa"))
                
                
                
            }.toolbar(.hidden)
        }
    }
        
        
    }


struct MainMessageView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessageView()
    }
}
