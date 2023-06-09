//
//  Note.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 25.04.2023.
//

import SwiftUI

struct NoteType: View {
    var text : String?
    init(text: String? = nil) {
        self.text = text
    }
    var body: some View {
        VStack{
            HStack{
                Text(text ?? "").font(Font.custom("Arial", size: 18)).fontWeight(.regular)
                Spacer()
                Text("Тип:").font(Font.custom("Arial", size: 18)).fontWeight(.regular)
                
            }
            Capsule().foregroundColor(Color(hex: "C2C2C2")).frame(width: 380, height: 1).padding(.top, 20)
        }
    }
}



struct Note: View {
    let app : AppointmentView

    @ObservedObject private var vm = NoteRowViewModel()
    
    init(app: AppointmentView, vm: NoteRowViewModel = NoteRowViewModel()) {
        self.app = app
        self.vm = vm
        
        //vm.fetchData(id: app.id)
    }
    @State var showsAlert = false
    @State var text = ""
    @State var text1 = ""
//    let id : String
//
//    init(vm: NoteRowViewModel = NoteRowViewModel(), id: String) {
//        self.vm = vm
//        self.id = id
//        vm.fetchData(id: id)
//    }
    var body: some View {
        
            VStack{
                Text("Информация о записи").font(Font.custom("Manrope", size: 30)).fontWeight(.bold).padding(.bottom, 1)
                Capsule().foregroundColor(mainColorOrange1).frame(width: 330, height: 5).padding(.horizontal, 30).padding(.top, 1)
                ZStack {
                    RoundedRectangle(cornerRadius: 12).foregroundColor(mainColorOrange1?.opacity(0.4)).frame(width: 351, height: 54)
                    
                        VStack{
                            Group{

                                HStack {
                                    NavigationLink {
                                        if UserRole.role == .inspector{
                                            Video(user: User(uid: "U6LIvDgejoR2Pl9OJmx9Fz9mLay2", email: ""))

                                        }else{
                                            Video(user: User(uid: String(app.knoId) , email: ""))
                                        }
                                    } label: {
                                        Group{
                                            Image(systemName: "video.and.waveform")
                                            Text("Начать консультирование").font(Font.custom("Manrope", size: 14)).fontWeight(.bold)
                                        }.foregroundColor(.black)

                                    }


                                }

                            }.padding(.vertical, 10)
                        }
                    

                    
                }.padding(.vertical)

                ScrollView{
                    VStack(spacing: 20){
                        if UserRole.role == .buisnes{
                            HStack{
                                FieldTextNew(text: "Kонтрольно-надзорный орган", textHide: app.knoName).padding(.leading, 20)
                                Spacer()
                            }
                            HStack{
                                FieldTextNew(text: "Вид контроля", textHide: app.measureName).padding(.leading, 20)
                                Spacer()
                            }
                        }else{
                            HStack{
                                FieldTextNew(text: "Фамилия", textHide: app.knoName).padding(.leading, 20)
                            Spacer()
                            }
                            HStack{
                                FieldTextNew(text: "Имя", textHide: app.measureName).padding(.leading, 20)
                                Spacer()
                            }
                            
                        }
                        HStack{
                            FieldTextNew(text: "Тип встречи", textHide: "Видео-конференция").padding(.leading, 20)
                            Spacer()
                        }
                    }
                }
                Button {
                    if UserRole.role == .buisnes{
                        vm.delete(id: app.id)

                    }else{
                        vm.approve(id: app.id)
                    }
                    showsAlert.toggle()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20).frame(width: 165, height: 50).foregroundColor(mainColorOrange1)
                        Text(text).font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.white)
                    }
                }.alert(isPresented: $showsAlert) {
                    Alert(title: Text(text1))
                }.onAppear {
                    if UserRole.role == .inspector{
                        print("ins")
                        self.text = "Подтвердить запись"
                        self.text1 = "Запись успешно подтверждена!"
                    }else{
                        self.text = "Отменить запись"
                        self.text1 = "Запись успешно отменена!"
                    }
                }

            }

        

    }
}

//struct Note_Previews: PreviewProvider {
//    static var previews: some View {
//        Note()
//    }
//}
