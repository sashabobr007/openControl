//
//  Profile.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 02.05.2023.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        NavigationView {
            VStack{
                VStack{
                    VStack{
                        ZStack{
                            Circle().frame(width: 134, height: 134).foregroundColor(.white)
                            Circle().frame(width: 120, height: 120).foregroundColor(mainColorOrange2)
                            ZStack{
                                Circle().frame(width: 47, height: 47).foregroundColor(.white)
                                Button {
                                    
                                } label: {
                                    
                                    ZStack {
                                        Circle().frame(width: 40, height: 40).foregroundColor(mainColorOrange1)
                                        Image(systemName: "pencil").font(.system(size: 25)).foregroundColor(.white)
                                    }
                                }
                                
                            }.padding(.top, 120)
                        }.padding(.top, 20)
                        Text("Сергей Петров").padding(.top, 30)
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 30).frame(width: 194, height: 34).foregroundColor(.white)
                            Text("dorothyann@gmail.com").tint(mainColorOrange1)
                        }.padding(.top,10)
                    }.padding(.top, 60)
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300, alignment: .top).background(mainColorOrange).ignoresSafeArea()
                
                VStack{
                    Group{
                        NavigationLink(destination: {
                            Note()
                        }, label: {
                            HStack{
                                ZStack {
                                    Circle().frame(width: 44, height: 44).foregroundColor(mainColorOrange)
                                    Image(systemName: "pencil").font(.system(size: 24)).foregroundColor(mainColorOrange1)
                                }.padding(.leading, 25)
                                
                                Text("Изменить профиль").foregroundColor(.black).padding(.leading)
                                Spacer()
                                Image(systemName: "chevron.right").foregroundColor(.black).padding(.trailing, 40)
                            }
                        })
                        
                        NavigationLink(destination: {
                            Note()
                        }, label: {
                            HStack{
                                ZStack {
                                    Circle().frame(width: 44, height: 44).foregroundColor(mainColorOrange)
                                    Image(systemName: "pencil").font(.system(size: 24)).foregroundColor(mainColorOrange1)
                                }.padding(.leading, 25)
                                
                                Text("Статус").foregroundColor(.black).padding(.leading)
                                Spacer()
                                Image(systemName: "chevron.right").foregroundColor(.black).padding(.trailing, 40)
                            }
                        })
                        
                        NavigationLink(destination: {
                            Note()
                        }, label: {
                            HStack{
                                ZStack {
                                    Circle().frame(width: 44, height: 44).foregroundColor(mainColorOrange)
                                    Image(systemName: "pencil").font(.system(size: 24)).foregroundColor(mainColorOrange1)
                                }.padding(.leading, 25)
                                
                                Text("Изменить пароль").foregroundColor(.black).padding(.leading)
                                Spacer()
                                Image(systemName: "chevron.right").foregroundColor(.black).padding(.trailing, 40)
                            }
                        })
                        
                        NavigationLink(destination: {
                            Note()
                        }, label: {
                            HStack{
                                ZStack {
                                    Circle().frame(width: 44, height: 44).foregroundColor(mainColorOrange)
                                    Image(systemName: "pencil").font(.system(size: 24)).foregroundColor(mainColorOrange1)
                                }.padding(.leading, 25)
                                
                                Text("Настройки").foregroundColor(.black).padding(.leading)
                                Spacer()
                                Image(systemName: "chevron.right").foregroundColor(.black).padding(.trailing, 40)
                            }
                        })
                        
                        NavigationLink(destination: {
                            Note()
                        }, label: {
                            HStack{
                                ZStack {
                                    Circle().frame(width: 44, height: 44).foregroundColor(mainColorRed)
                                    Image(systemName: "pencil").font(.system(size: 24)).foregroundColor(mainColorRed1)
                                }.padding(.leading, 25)
                                
                                Text("Выход").foregroundColor(.black).padding(.leading)
                                Spacer()
                                Image(systemName: "chevron.right").foregroundColor(.black).padding(.trailing, 40)
                            }
                        })
                        
                        
                    }.padding(.vertical, 15)
                    
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top).background(.white).ignoresSafeArea()
            }.background(mainColorOrange)
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
