//
//  NoteRow.swift
//  OpenControl
//
//  Created by Александр Алексеев on 08.05.2023.
//

import SwiftUI

struct NoteRow: View {
    let app : AppointmentView
    var time = ""
    var date = ""
    init(app: AppointmentView, time: String = "", date: String = "") {
        self.app = app
        self.time = app.time.split(separator: "T").last?.description.split(separator: ".").first?.description ?? ""
        self.date = app.time.split(separator: "T").first?.description ?? ""
        //self.time = time.split(separator: ".").first?.description ?? ""
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12).foregroundColor(.white).frame(width: 368, height: 170)
            VStack{
                VStack{
                    VStack (spacing: 15){
                        HStack{
                            Text("Запись на консультацию").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.black)
                            Spacer()
                        }
                        HStack{
                            
                            Text(app.knoName).font(Font.custom("Manrope", size: 14)).fontWeight(.ultraLight).foregroundColor(.black)
                            Spacer()

                        }
                        HStack{
                            
                            
                            Text(date).font(Font.custom("Manrope", size: 14)).fontWeight(.light).foregroundColor(.black)
                            
                            Text(time).font(Font.custom("Manrope", size: 14)).fontWeight(.light).foregroundColor(.black).padding(.leading, 20)
                            
                            Spacer()

                        }
                        
                        HStack{
                            if app.status == "AGREED"{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 50).frame(width: 190, height: 24).foregroundColor(Color(hex: "44C863"))
                                    Text("Запись подтверждена").foregroundColor(.white)
                                }
                            }else{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 50).frame(width: 210, height: 24).foregroundColor(Color(hex: "FFBF41"))
                                    Text("Ожидает подтверждения").foregroundColor(.white)
                                }
                            }
                            
                            Spacer()
                        }
                        
                        }.padding(.leading, 40)
                    }
                    
//                    HStack{
//                        Text(time).font(Font.custom("Manrope", size: 14)).fontWeight(.light).foregroundColor(.black)
//                        Spacer()
//                        Text(date).font(Font.custom("Manrope", size: 14)).fontWeight(.light).foregroundColor(.black).padding(.trailing, 20)
//                    }.padding(.horizontal, 40)
                    
                }
                
            }
        }
    }


//struct NoteRow_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteRow()
//    }
//}
