//
//  NoteSheet.swift
//  OpenControl
//
//  Created by Александр Алексеев on 09.05.2023.
//

import SwiftUI

struct NoteSheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var detail : InventoryItem
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Выберите вид:").foregroundColor(Color(hex: "666666"))
            HStack{
                 
                
                    if detail.type1{
                        Button {
                            detail.type1.toggle()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 12).frame(width: 173.44, height: 34).foregroundColor(.white).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "E0E0E0") ?? .black, lineWidth: 1))
                                Text("Консультация").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.gray)
                            }
                        }
                    }else{
                        ZStack{
                            RoundedRectangle(cornerRadius: 12).frame(width: 173.44, height: 34).foregroundColor(mainColorOrange1)
                            Text("Консультация").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.white)
                        }
                    }
                
                Spacer()
                ZStack{
                    if detail.type1 {
                        ZStack{
                            RoundedRectangle(cornerRadius: 12).frame(width: 173.44, height: 34).foregroundColor(mainColorOrange1)
                            Text("Проверка").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.white)
                        }
                    }else{
                        Button {
                            detail.type1.toggle()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 12).frame(width: 173.44, height: 34).foregroundColor(.white).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "E0E0E0") ?? .black, lineWidth: 1))
                                Text("Проверка").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            Text("Выберите тип: ").foregroundColor(Color(hex: "666666"))
            HStack{
                 
                
                if detail.type2{
                        Button {
                            detail.type2.toggle()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 12).frame(width: 173.44, height: 34).foregroundColor(.white).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "E0E0E0") ?? .black, lineWidth: 1))
                                Text("Видео-конференция").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.gray)
                            }
                        }
                    }else{
                        ZStack{
                            RoundedRectangle(cornerRadius: 12).frame(width: 173.44, height: 34).foregroundColor(mainColorOrange1)
                            Text("Видео-конференция").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.white)
                        }
                    }
                
                Spacer()
                
                    if detail.type2 {
                        ZStack{
                            RoundedRectangle(cornerRadius: 12).frame(width: 173.44, height: 34).foregroundColor(mainColorOrange1)
                            Text("Визит").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.white)
                        }
                    }else{
                        Button {
                            detail.type2.toggle()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 12).frame(width: 173.44, height: 34).foregroundColor(.white).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "E0E0E0") ?? .black, lineWidth: 1))
                                Text("Визит").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(mainColorOrange1)
                            }
                        }
                    }
                
            }
            Text("Выберите период:").foregroundColor(Color(hex: "666666"))
            HStack{
                DatePicker(
                        "От:",
                        selection: $detail.from,
                        displayedComponents: [.date]
                    )
                
                DatePicker(
                        "До:",
                        selection: $detail.to,
                        displayedComponents: [.date]
                    )
            }
            
            Spacer()
            
               
            
            VStack{
                HStack{
                    Button{
                        detail.accept = false
                            dismiss()
                    }label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 12).foregroundColor(Color(hex: "DADADA")).frame(width: 162.41, height: 50)
                            Text("Отмена").foregroundColor(Color(hex: "E93535"))
                            
                        }
                    }
                    
                    Spacer()
                    
                    Button{
                        detail.accept = true
                            dismiss()
                    }label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 12).foregroundColor(mainColorOrange1).frame(width: 162.41, height: 50)
                            Text("Применить").foregroundColor(.white)
                            
                        }
                    }
                }
            }
            
        }.padding(.horizontal)
    }
}

//struct NoteSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteSheet()
//    }
//}
