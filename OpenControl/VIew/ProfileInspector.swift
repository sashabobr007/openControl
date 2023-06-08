//
//  ProfileInspector.swift
//  OpenControl
//
//  Created by Александр Алексеев on 27.05.2023.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore

struct ProfileInspector: View {
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
                            Text("инспектор").padding(.top, 30)
                            Text(vm.kno)
                            
//                            ZStack{
//                                RoundedRectangle(cornerRadius: 30).frame(width: 194, height: 34).foregroundColor(.white)
//                                Text(vm.email).tint(mainColorOrange1)
//                            }.padding(.top,10)
                        }.padding(.top, 60)
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 660, alignment: .top).ignoresSafeArea()
                    
                    VStack{
                        
                        ScrollView{
                            
                            
 
                            
                            Button {
                                //print("1")
                                presentAlert.toggle()
                                
                            } label: {
                                HStack{
                                    ZStack {
                                        Circle().frame(width: 44, height: 44).foregroundColor(Color(hex: "FAEEEE"))
                                        Image(systemName: "door.left.hand.open").font(.system(size: 24)).foregroundColor(.red)
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
            
            
            
        }
    }
}

//struct ProfileInspector_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileInspector()
//    }
//}
