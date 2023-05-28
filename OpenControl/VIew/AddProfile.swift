//
//  AddProfile.swift
//  OpenControl
//
//  Created by Александр Алексеев on 23.05.2023.
//

import SwiftUI

struct AddProfile: View {
    
    @State private var organ = ""
    @State private var vid = ""
    @State private var pod = ""
    @State private var dop = ""
    
    @ObservedObject private var vm = ProfilViewModel()

    
    var body: some View {
        VStack{
            
            
            ScrollView{
                
                Text("Сведения о пользователе").font(Font.custom("Manrope", size: 22)).fontWeight(.bold).padding(.bottom, 1)
                Capsule().foregroundColor(mainColorOrange1).frame(width: 300, height: 5).padding(.horizontal, 30).padding(.top, 1).padding(.bottom)
                
                
                
                FieldText(textSelect: $vm.lastName, text: "Фамилия", textHide: "Введите название бизнеса")
                
                
                FieldText(textSelect: $vm.firstName, text: "Имя", textHide: "Введите вид деятельности")
               
                
                FieldText(textSelect: $vm.surName, text: "Отчетство", textHide: "выберите орган контроля")
                
                
                FieldText(textSelect: $organ, text: "Пол", textHide: "Введите юридический адрес")
                
                FieldText(textSelect: $vm.inn, text: "ИНН", textHide: "выберите орган контроля")
                FieldText(textSelect: $vm.snils, text: "СНИЛС", textHide: "Введите юридический адрес")
                
                Text("Контактная информация").font(Font.custom("Manrope", size: 18)).fontWeight(.bold).padding(.vertical).padding(.trailing, 130)
                
                VStack{
                    FieldText(textSelect: $organ, text: "Телефон", textHide: "выберите орган контроля")
                    
                    FieldText(textSelect: $organ, text: "Почта", textHide: "Введите юридический адрес")
                }
                
                
                
                
                
                
            }.padding(.bottom)
            
            HStack{
                Button {
                    
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 12).frame(width: 162, height: 50).foregroundColor(mainColorGray)
                        Text("Отмена").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(mainColorOrange1)
                    }
                }
                
                Button {
                    vm.addCurrentUser()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 12).frame(width: 162, height: 50).foregroundColor(mainColorOrange1)
                        Text("Применить").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.white)
                    }
                }

            }
            
            
        }
    }
}

struct AddProfile_Previews: PreviewProvider {
    static var previews: some View {
        AddProfile()
    }
}
