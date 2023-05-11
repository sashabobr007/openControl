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
    var body: some View {
        
        NavigationView{
            VStack{
                Text("Информация о записи").font(Font.custom("Manrope", size: 30)).fontWeight(.bold).padding(.bottom, 1)
                Capsule().foregroundColor(mainColorPurple).frame(width: 330, height: 5).padding(.horizontal, 30).padding(.top, 1)
                ZStack {
                    RoundedRectangle(cornerRadius: 30).foregroundColor(mainColorPurple?.opacity(0.4)).frame(width: 396, height: 88)
                    VStack{
                        Group{
                            HStack {
                                Button {

                                } label: {
                                    Group{
                                        Image(systemName: "message")
                                        Text("Чат с инспектором").font(Font.custom("Manrope", size: 14)).fontWeight(.bold)
                                    }.foregroundColor(.black)
                                }


                            }

                            HStack {
                                Button {

                                } label: {
                                    Group{
                                        Image(systemName: "video.and.waveform")
                                        Text("Видео-конференция").font(Font.custom("Manrope", size: 14)).fontWeight(.bold)
                                    }.foregroundColor(.black)

                                }


                            }

                        }.padding(.vertical, 10)
                    }
                }.padding(.vertical)

                ScrollView{
                    Group{
                        
                        NoteType(text: "Тип:")
                        NoteType(text: "Дата:").padding(.top, 25)
                        NoteType(text: "Время:").padding(.top, 25)
                        NoteType(text: "Формат:").padding(.top, 25)

                        NoteType(text: "Номер объекта:").padding(.top, 25)
                        NoteType(text: "Инспектор:").padding(.top, 25)
                        NoteType(text: "Дополнительно:").padding(.top, 25)
                        
                    }.padding(.horizontal, 20)

                }
                Button {

                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20).frame(width: 165, height: 50).foregroundColor(mainColorPurple)
                        Text("Отменить запись").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.white)
                    }
                }

            }

        }
        
       
        
        
            
        
    }
}

struct Note_Previews: PreviewProvider {
    static var previews: some View {
        Note()
    }
}
