//
//  NoteRow.swift
//  OpenControl
//
//  Created by Александр Алексеев on 08.05.2023.
//

import SwiftUI

struct NoteRow: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12).foregroundColor(.white).frame(width: 368, height: 128)
            VStack{
                VStack{
                    VStack{
                        HStack{
                            
                            Text("Запись на пожарную консультацию").font(Font.custom("Manrope", size: 14)).fontWeight(.medium).foregroundColor(.black)
                            Spacer()

                        }
                        HStack{
                            
                            
                            Text("Инспектор: Васильев Александ Ильич").font(Font.custom("Manrope", size: 14)).fontWeight(.light).foregroundColor(.black).padding(.vertical)
                            Spacer()

                        }
                        }.padding(.leading, 40)
                    }
                    
                    HStack{
                        Text("8:30-9:00").font(Font.custom("Manrope", size: 14)).fontWeight(.light).foregroundColor(.black)
                        Spacer()
                        Text("16 августа 2023").font(Font.custom("Manrope", size: 14)).fontWeight(.light).foregroundColor(.black).padding(.trailing, 20)
                    }.padding(.horizontal, 40)
                    
                }
                
            }
        }
    }


struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        NoteRow()
    }
}
