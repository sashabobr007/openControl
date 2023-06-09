//
//  Fields.swift
//  OpenControl
//
//  Created by Александр Алексеев on 16.05.2023.
//

import SwiftUI

struct FieldTextNew: View {
    
    var text : String
    var textHide : String


    var body: some View {
        VStack(alignment: .leading){
            Text(text).font(Font.custom("Manrope", size: 12)).fontWeight(.regular).foregroundColor(Color(hex: "B4B4B4"))
                 Text(textHide).foregroundColor(.black).font(Font.custom("Manrope", size: 14)).fontWeight(.regular).padding(.top, 10)
        }
        }
    }


struct FieldText: View {
    @Binding var textSelect: String
    var text : String
    var textHide : String


    var body: some View {
        VStack(alignment: .leading){
            Text(text).font(Font.custom("Manrope", size: 14)).fontWeight(.regular).fontWeight(.regular)
           
            ZStack{
                RoundedRectangle(cornerRadius: 12).frame(width: 353, height: 29).foregroundColor(.white).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "E0E0E0") ?? .black, lineWidth: 1))
                
                TextField(text: $textSelect, prompt: Text(textHide).foregroundColor(.gray).font(Font.custom("Manrope", size: 10)).fontWeight(.ultraLight)) {
                    
                    
                }.padding(.horizontal)
            }
              //  ZStack{
                    
//                    if textSelect.count == 0{
//
//
//                    }else{
//                        Text(textSelect).foregroundColor(.black).font(Font.custom("Manrope", size: 12)).fontWeight(.bold)
//                    }
                //}
        }.padding(.horizontal)
        }
    }



struct Field: View {
    @Binding var textSelect: String
    var text : String
    var textHide : String
    var menu : [String]
//    init(organ: String!, text: String) {
//        self.organ = organ
//        self.text = text
//    }
    var body: some View {
        VStack(alignment: .leading){
            Text(text).font(Font.custom("Manrope", size: 14)).fontWeight(.regular).fontWeight(.regular)
            Menu{
                ForEach (menu, id: \.self) { item in
                    Button {
                        textSelect = item
                    } label: {
                        Text(item)
                    }
                }
                

                
            }label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 12).frame(width: 353, height: 29).foregroundColor(.white).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "E0E0E0") ?? .black, lineWidth: 1))
                    if textSelect.count == 0{
                        Text(textHide).foregroundColor(.gray).font(Font.custom("Manrope", size: 10)).fontWeight(.ultraLight)

                    }else{
                        Text(textSelect).foregroundColor(.black).font(Font.custom("Manrope", size: 12)).fontWeight(.bold)
                    }
                }
            }
        }
    }
}


struct FieldBin: View {
    @Binding var textSelect: String
    var text : String
    var textHide : String
    @ObservedObject var vm : NewNoteViewModel
    @State var menu = [String]()
    
    //@Binding var menu : [String]
//    init(organ: String!, text: String) {
//        self.organ = organ
//        self.text = text
//    }
    var body: some View {
        VStack(alignment: .leading){
            Text(text).font(Font.custom("Manrope", size: 14)).fontWeight(.regular).fontWeight(.regular)
            
            Menu{
                ForEach (vm.timesStr, id: \.self) { item in
                    Button {
                        textSelect = item
                    } label: {
                        Text(item)
                    }
                }
                

                
            }label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 12).frame(width: 353, height: 29).foregroundColor(.white).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "E0E0E0") ?? .black, lineWidth: 1))
                    if textSelect.count == 0{
                        Text(textHide).foregroundColor(.gray).font(Font.custom("Manrope", size: 10)).fontWeight(.ultraLight)

                    }else{
                        Text(textSelect).foregroundColor(.black).font(Font.custom("Manrope", size: 12)).fontWeight(.bold)
                    }
                }
            }.onAppear {
                menu = vm.timesStr     }
            
            .onChange(of: vm.timesStr) { array in
                menu = array
        }.id(UUID())

        }
    }
}
