//
//  NewNote.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 04.05.2023.
//

import SwiftUI

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

class TimeNote : Identifiable, Comparable{
    static func < (lhs: TimeNote, rhs: TimeNote) -> Bool {
        return true
    }
    
    static func == (lhs: TimeNote, rhs: TimeNote) -> Bool {
        if lhs.id == rhs.id{
            return true
        }else{
            return false
        }
            
    }
    
    var id = UUID()
    let from : String
    let to : String
    var selected : Bool
    init(id: UUID = UUID(), from: String, to: String, selected: Bool) {
        self.id = id
        self.from = from
        self.to = to
        self.selected = selected
    }
}


struct TimeView: View {
    @Binding var selected : Bool
    var from : String
    var to : String
    
    var body: some View {
        
        Button {
            selected.toggle()
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 15).frame(width: 109, height: 31).foregroundColor(selected ? mainColorPurple : mainColorPurple1)
                
                Text("\(from)-\(to)").foregroundColor(.black)
            }
        }
        
    }
        
    }


struct NewNote: View {
    @State private var times = [TimeNote(from: "10:00", to: "11:00", selected: true), TimeNote(from: "12:00", to: "13:00", selected: false)]
    @State private var organ = ""
    @State private var vid = ""
    @State private var pod = ""
    @State private var dop = ""
    @State private var type = false
    
    @State private var image : UIImage?
    @State private var videoURL: URL?
    @State private var documentURL: URL?


    @State private var showSheet = false
    @State private var showingVideoPicker = false
    @State private var showingDocumentPicker = false


    var body: some View {
        NavigationView{
            
            VStack{
                Text("Новая запись").font(Font.custom("Manrope", size: 22)).fontWeight(.bold).padding(.bottom, 1)
                Capsule().foregroundColor(mainColorPurple).frame(width: 150, height: 5).padding(.horizontal, 30).padding(.top, 1)
                
                ScrollView {
                    Field(textSelect: $organ, text: "Kонтрольно-надзорный орган", textHide: "выберите орган контроля", menu: ["pozhar", "voda"])
                    
                    Field(textSelect: $vid, text: "Вид контроля", textHide: "выберите вид контроля", menu: ["pozhar", "voda"])
                    
                    Field(textSelect: $pod, text: "Подразделение", textHide: "выберите подразделение", menu: ["pozhar", "voda"])
                    
                    HStack{
                        Text("Выберите тип встречи").font(Font.custom("Manrope", size: 14)).fontWeight(.regular).fontWeight(.regular).padding(.leading, 20)
                        Spacer()
                    }
                    
                    HStack{
                         
                        
                        if type{
                                Button {
                                    type.toggle()
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 12).frame(width: 173.44, height: 34).foregroundColor(.white).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "E0E0E0") ?? .black, lineWidth: 1))
                                        Text("видео-конференция").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.gray)
                                    }
                                }
                            }else{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 12).frame(width: 173.44, height: 34).foregroundColor(mainColorPurple)
                                    Text("видео-конференция").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.white)
                                }
                            }
                        
                        Spacer()
                        
                            if type {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 12).frame(width: 173.44, height: 34).foregroundColor(mainColorPurple)
                                    Text("личный визит").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.white)
                                }
                            }else{
                                Button {
                                    type.toggle()
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 12).frame(width: 173.44, height: 34).foregroundColor(.white).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "E0E0E0") ?? .black, lineWidth: 1))
                                        Text("личный визит").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(mainColorPurple)
                                    }
                                }
                            }
                        
                    }.padding(.horizontal)
                    
                    Field(textSelect: $dop, text: "Дополнительная информация", textHide: "Комментарий к проверке", menu: ["pozhar", "voda"])
                    
                    Menu {
                        
                        
                        
                        Button {
                            showSheet = true
                        } label: {
                            Image(systemName: "photo")
                        }
                        
                        Button {
                            self.showingDocumentPicker = true

                        } label: {
                            Image(systemName: "doc.fill.badge.plus")
                        }
                        
                        Button {
                            self.showingVideoPicker = true

                        } label: {
                            Image(systemName: "video.and.waveform")
                            
                        }

                        
                    } label: {
                        HStack{
                            Image(systemName: "plus").padding(.leading, 20)
                            Text("Добавить фото или документ")
                            Spacer()
                        }
                    }
                    
                    Text("calendar")

                    HStack{
                        Text("Среда (20.09.23)").padding(.leading)
                        Spacer()
                    }

                                        ScrollView(.horizontal){
                    
                                            HStack{
                                                ForEach(times) { time in
                                                    
                                                    
                                                    // TimeView(selected: time.$selected, from: time.from, to: time.to)
                                                    
                                                    VStack{
                                                        Button {
                                                            for i in 0..<times.count{
                                                                if times[i] == time{
                                                                    times[i].selected.toggle()
                                                                }
                                                            }
                                                            //  time.selected.toggle()
                                                            
                                                        } label: {
                                                            ZStack{
                                                                RoundedRectangle(cornerRadius: 15).frame(width: 109, height: 31).foregroundColor(time.selected ? mainColorPurple : mainColorPurple1)
                                                                
                                                                Text("\(time.from)-\(time.to)").foregroundColor(.black)
                                                            }
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                            }
                                            
                                        }.padding(.horizontal)
                                        
                    
                }
                .sheet(isPresented: $showSheet) {
                            
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)

                            
                            
                    }.sheet(isPresented: $showingVideoPicker) {
                        VideoPicker(videoURL: self.$videoURL)
                      }
            
                    .sheet(isPresented: $showingDocumentPicker) {
                      DocumentPicker(documentURL: self.$documentURL)
                    }
                
//                VStack{
//                   // InformationWithSelectionView()
//
//
//                }
                
                Button {
                    print(organ)
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20).frame(width: 165, height: 50).foregroundColor(mainColorPurple)
                        Text("Записаться").font(Font.custom("Manrope", size: 16)).fontWeight(.bold).foregroundColor(.white)
                    }
                }
                
            }
        }
    }
}

struct NewNote_Previews: PreviewProvider {
    static var previews: some View {
        NewNote()
    }
}
