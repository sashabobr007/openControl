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
    @State private var presentAlert = false

    
    var body: some View {
        VStack{
            
            Text("Сведения о пользователе").font(Font.custom("Manrope", size: 22)).fontWeight(.bold).padding(.bottom, 1)
            Capsule().foregroundColor(mainColorOrange1).frame(width: 300, height: 5).padding(.horizontal, 30).padding(.top, 1).padding(.bottom)
            ScrollView{
 
                FieldText(textSelect: $vm.lastName, text: "Фамилия", textHide: "Введите вашу фамилию")
                
                
                FieldText(textSelect: $vm.firstName, text: "Имя", textHide: "Введите ваше имя деятельности")
               
                
                FieldText(textSelect: $vm.surName, text: "Отчетство", textHide: "Введите ваше отчество")
                
                
               // FieldText(textSelect: $organ, text: "Пол", textHide: "Введите юридический адрес")
                
                FieldText(textSelect: $vm.inn, text: "ИНН", textHide: "Введите ваш ИНН")
                FieldText(textSelect: $vm.snils, text: "СНИЛС", textHide: "Введите ваш снилс")
                
                Text("Контактная информация").font(Font.custom("Manrope", size: 18)).fontWeight(.bold).padding(.vertical).padding(.trailing, 130)
                
                VStack{
                    FieldText(textSelect: $vm.mobilePhone, text: "Телефон", textHide: "Введите ваш телефон")
                    
                    FieldText(textSelect: $organ, text: "Почта", textHide: "Введите вашу почту")
                }
                
                
                
                
                
                
            }.padding(.bottom)
            
            HStack{
                Button {
                    vm.fetchCurrentUser()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 12).frame(width: 162, height: 50).foregroundColor(mainColorGray)
                        Text("Отмена").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(mainColorOrange1)
                    }
                }
                
                Button {
                    vm.addCurrentUser()
                    self.presentAlert.toggle()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 12).frame(width: 162, height: 50).foregroundColor(mainColorOrange1)
                        Text("Применить").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.white)
                    }
                }

            }
            
            
        }.alert(isPresented: $presentAlert) {
            Alert(
                title: Text("Данные успешно обновлены!")
            )
        }

    }
}

struct AddProfile_Previews: PreviewProvider {
    static var previews: some View {
        AddProfile()
    }
}
