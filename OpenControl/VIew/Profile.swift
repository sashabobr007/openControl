//
//  Profile.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 02.05.2023.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

struct Profile: View {
    @State private var presentAlert = false
    @Binding var login : String

    @ObservedObject private var vm = ProfilViewModel()
    
    var body: some View {
        ZStack{
            NavigationView {
                VStack{
                    VStack{
                        VStack{
                            ZStack{
                                Circle().frame(width: 134, height: 134).foregroundColor(.white)
                                Circle().frame(width: 120, height: 120).foregroundColor(mainColorOrange)
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
                            Text(vm.firstName + " " + vm.lastName).padding(.top, 30)
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 30).frame(width: 194, height: 34).foregroundColor(.white)
                                Text(vm.email).tint(mainColorOrange1)
                            }.padding(.top,10)
                        }.padding(.top, 60)
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 360, alignment: .top).ignoresSafeArea()
                    
                    VStack{
                        
                        ScrollView{
                            
                            Text("Ваш бизнес:").font(Font.custom("Manrope", size: 21)).fontWeight(.bold)
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 12).foregroundColor(Color(hex: "D9D9D9")).frame(width: 333, height: 128)
                                VStack{
                                    Text("ОА “easy coffee”").font(Font.custom("Manrope", size: 16)).fontWeight(.bold)
                                    Text("ОА “easy coffee”").font(Font.custom("Manrope", size: 14)).fontWeight(.regular)
                                }
                            }
                            
                            
//                            Text("Вероятность нарушений:")
//
//                            ScrollView(.horizontal){
//                                HStack{
//                                    ZStack{
//                                        RoundedRectangle(cornerRadius: 12).foregroundColor(Color(hex: "FAEDDB")).frame(width: 333, height: 128)
//                                        Text("ОА “easy coffee”")
//                                    }
//
//                                    ZStack{
//                                        RoundedRectangle(cornerRadius: 12).foregroundColor(Color(hex: "FAEDDB")).frame(width: 333, height: 128)
//                                        Text("ОА “easy coffee”")
//                                    }
//
//                                }
//                            }.padding(.horizontal)
                            
                            
                            NavigationLink(destination: {
                                AddBuisness()
                            }, label: {
                                HStack{
                                    ZStack {
                                        Circle().frame(width: 44, height: 44).foregroundColor(mainColorRed)
                                        Image(systemName: "plus").font(.system(size: 24)).foregroundColor(mainColorOrange1)
                                    }.padding(.leading, 25)
                                    
                                    Text("Добавить бизнес").foregroundColor(.black).padding(.leading)
                                    Spacer()
                                    Image(systemName: "chevron.right").foregroundColor(.black).padding(.trailing, 40)
                                }
                            }).padding(.top, 15)
                            
                            NavigationLink(destination: {
                                AddProfile()
                            }, label: {
                                HStack{
                                    ZStack {
                                        Circle().frame(width: 44, height: 44).foregroundColor(mainColorRed)
                                        Image(systemName: "pencil").font(.system(size: 24)).foregroundColor(mainColorOrange1)
                                    }.padding(.leading, 25)
                                    
                                    Text("Сведения о пользователе").foregroundColor(.black).padding(.leading)
                                    Spacer()
                                    Image(systemName: "chevron.right").foregroundColor(.black).padding(.trailing, 40)
                                }
                            }).padding(.top, 15)
                            
                            Button {
                                //print("1")
                                presentAlert.toggle()
                                
                            } label: {
                                HStack{
                                    ZStack {
                                        Circle().frame(width: 44, height: 44).foregroundColor(mainColorRed)
                                        Image(systemName: "door.left.hand.open").font(.system(size: 24)).foregroundColor(mainColorOrange1)
                                    }.padding(.leading, 25)
                                    
                                    Text("Выход").foregroundColor(.black).padding(.leading)
                                    Spacer()
                                    Image(systemName: "chevron.right").foregroundColor(.black).padding(.trailing, 40)
                                }
                            }.padding(.top, 15)
                        }
                        
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top).background(.white)
                }.background(mainColorOrange2).ignoresSafeArea().padding(.bottom)
            }.alert(isPresented: $presentAlert) {
                Alert(
                    title: Text("Выход"),
                    message: Text("Вы уверены, что хотите выйти?"),
                    primaryButton: .destructive(Text("Да"), action: {
                        let auth = Auth.auth()
                        try? auth.signOut()
                        login = ""
                        
                    }),
                    secondaryButton: .default(Text("Нет"), action: {
                        
                    })
                )
            }
            
            
            
        }.onAppear {
            vm.fetchCurrentUser()
        }
        
    }
}
//struct Profile_Previews: PreviewProvider {
//    static var previews: some View {
//        Profile()
//    }
//}
