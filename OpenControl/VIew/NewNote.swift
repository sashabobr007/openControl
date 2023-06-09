//
//  NewNote.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 04.05.2023.
//

import SwiftUI



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
    @Binding var timeSelct : String
    @Binding var time : String
    @State var selected : Bool = false
    
    var body: some View {
        Button {
           timeSelct = time
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 15).frame(width: 109, height: 31).foregroundColor(selected ? mainColorOrange1 : mainColorOrange3)
                
                Text("\(time)").foregroundColor(.black).font(Font.custom("Manrope", size: 10)).fontWeight(.bold)
            }
        }.onAppear {
            if time == timeSelct{
                selected.toggle()
            }else{
                selected = false
            }
        }.onChange(of: timeSelct) { newValue in
            if time == timeSelct{
                selected.toggle()
            }else{
                selected = false
            }
        }
        
    }
        
    }


struct NewNote: View {
    
    @State private var pod = ""
    @State private var dop = ""
    @State private var type = false
    
    @State private var image : UIImage?
    @State private var videoURL: URL?
    @State private var documentURL: URL?


    @State private var showSheet = false
    @State private var showingVideoPicker = false
    @State private var showingDocumentPicker = false
    @ObservedObject private var vm = NewNoteViewModel()
    @State var showsAlert = false


    @State private var timeSelect = ""


    var body: some View {
        NavigationView{
            
            VStack{
                Text("Новая запись").font(Font.custom("Manrope", size: 22)).fontWeight(.bold).padding(.bottom, 1)
                Capsule().foregroundColor(mainColorOrange1).frame(width: 150, height: 5).padding(.horizontal, 30).padding(.top, 1)
                
                ScrollView {
                    Field(textSelect: $vm.organ, text: "Kонтрольно-надзорный орган", textHide: "выберите орган контроля", menu: vm.knoStr).onChange(of: vm.organ) { newValue in
                        vm.fetchMeasure()
                    }
                    
                    Field(textSelect: $vm.vid, text: "Вид контроля", textHide: "выберите вид контроля", menu: vm.mStr).onChange(of: vm.vid) { newValue in
                        vm.fetchList()
                    }
                    
//                    Field(textSelect: $pod, text: "Подразделение", textHide: "выберите подразделение", menu: ["pozhar", "voda"])
                    
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
                                    RoundedRectangle(cornerRadius: 12).frame(width: 173.44, height: 34).foregroundColor(mainColorOrange1)
                                    Text("видео-конференция").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.white)
                                }
                            }
                        
                        Spacer()
                        
                            if type {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 12).frame(width: 173.44, height: 34).foregroundColor(mainColorOrange1)
                                    Text("личный визит").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.white)
                                }
                            }else{
                                Button {
                                    type.toggle()
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 12).frame(width: 173.44, height: 34).foregroundColor(.white).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "E0E0E0") ?? .black, lineWidth: 1))
                                        Text("личный визит").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(mainColorOrange1)
                                    }
                                }
                            }
                        
                    }.padding(.horizontal)
                    
//                    Field(textSelect: $dop, text: "Дополнительная информация", textHide: "Комментарий к проверке", menu: ["pozhar", "voda"])
                    
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
                    
                    DatePicker(
                            "Выберите день :",
                            selection: $vm.dateSelect,
                            displayedComponents: [.date]
                    ).onChange(of: vm.dateSelect) { newValue in
                        vm.fetchDateList()
                    }.padding(.horizontal)
                    
//                    FieldBin(textSelect: $vm.timeSelect, text: "Время", textHide: "выберите время", vm: vm )
//                    HStack{
//                        Text("Среда (20.09.23)").padding(.leading)
//                        Spacer()
//                    }
//
                                        ScrollView(.horizontal){

                                            HStack{
                                                ForEach($vm.timesStr, id: \.self) { time in
                                                    
                                                    TimeView(timeSelct: $vm.timeSelect, time: time)

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
                    //print(organ)
                    vm.addNote()
                    showsAlert.toggle()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20).frame(width: 165, height: 50).foregroundColor(mainColorOrange1)
                        Text("Записаться").font(Font.custom("Manrope", size: 16)).fontWeight(.bold).foregroundColor(.white)
                    }
                }.alert(isPresented: $showsAlert) {
                    Alert(title: Text("Запись успешно создана!"))
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
