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
            RoundedRectangle(cornerRadius: 12).foregroundColor(.white).frame(width: 368, height: 150)
            VStack{
                VStack{
                    VStack{
                        HStack{
                            
                            Text(app.withWho).font(Font.custom("Manrope", size: 14)).fontWeight(.medium).foregroundColor(.black)
                            Spacer()

                        }
                        HStack{
                            
                            
                            Text(app.status).font(Font.custom("Manrope", size: 14)).fontWeight(.light).foregroundColor(.black).padding(.vertical)
                            Spacer()

                        }
                        }.padding(.leading, 40)
                    }
                    
                    HStack{
                        Text(time).font(Font.custom("Manrope", size: 14)).fontWeight(.light).foregroundColor(.black)
                        Spacer()
                        Text(date).font(Font.custom("Manrope", size: 14)).fontWeight(.light).foregroundColor(.black).padding(.trailing, 20)
                    }.padding(.horizontal, 40)
                    
                }
                
            }
        }
    }


//struct NoteRow_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteRow()
//    }
//}
