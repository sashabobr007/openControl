//
//  AddBuisness.swift
//  OpenControl
//
//  Created by Александр Алексеев on 16.05.2023.
//

import SwiftUI

struct AddBuisness: View {
    
    @State private var organ = ""
    @State private var vid = ""
    @State private var pod = ""
    @State private var dop = ""
    @ObservedObject private var vm = ProfilViewModel()

    
    var body: some View {
        VStack{
            
            Text("Добавить бизнес").font(Font.custom("Manrope", size: 22)).fontWeight(.bold).padding(.bottom, 1)
            Capsule().foregroundColor(mainColorOrange1).frame(width: 200, height: 5).padding(.horizontal, 30).padding(.top, 1)
            ScrollView{
                
                
                
                Text("Добавьте информацию о вашем бизнесе и вы получите доступ ко всем функцциям системы").font(Font.custom("Manrope", size: 12)).fontWeight(.medium).padding(.bottom, 1).padding(.horizontal).padding(.bottom)
                
                FieldText(textSelect: $pod, text: "Наименование бизнеса", textHide: "Введите название бизнеса")
                
                Field(textSelect: $organ, text: "Тип цифрового профиля объекта", textHide: "Выберите тип цифрвого профиля", menu: ["pozhar", "voda"])
                
                FieldText(textSelect: $pod, text: "Вид деятельности", textHide: "Введите вид деятельности")
                
                Field(textSelect: $vid, text: "Классификация объекта", textHide: "выберите орган контроля", menu: ["pozhar", "voda"])
                
                FieldText(textSelect: $organ, text: "Классификация профиля деятельности", textHide: "выберите орган контроля")
                FieldText(textSelect: $organ, text: "Введите адрес ", textHide: "Введите юридический адрес")
                
                
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
                    vm.addBuisness()
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

struct AddBuisness_Previews: PreviewProvider {
    static var previews: some View {
        AddBuisness()
    }
}
