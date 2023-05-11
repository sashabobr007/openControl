//
//  Notes.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 04.05.2023.
//

import SwiftUI
import SwiftUICalendar

let weekText = [
    "Sun" : "pn"

]


struct InformationWithSelectionView: View {
   // let controller = CalendarController()
    
    @ObservedObject var controller: CalendarController = CalendarController()
    var informations = [YearMonthDay: [(String, Color)]]()
    @State var focusDate: YearMonthDay? = nil
    @State var focusInfo: [(String, Color)]? = nil

    init() {
        var date = YearMonthDay(year: 2023, month: 5, day: 10)
        informations[date] = []
        informations[date]?.append(("Hello", Color.orange))
        informations[date]?.append(("World", Color.blue))

        date = date.addDay(value: 3)
        informations[date] = []
        informations[date]?.append(("Test", Color.pink))

        date = date.addDay(value: 8)
        informations[date] = []
        informations[date]?.append(("Jack", Color.green))

        date = date.addDay(value: 5)
        informations[date] = []
        informations[date]?.append(("Home", Color.red))

        date = date.addDay(value: -23)
        informations[date] = []
        informations[date]?.append(("Meet at 8, Home", Color.purple))

        date = date.addDay(value: -5)
        informations[date] = []
        informations[date]?.append(("Home", Color.yellow))

        date = date.addDay(value: -10)
        informations[date] = []
        informations[date]?.append(("Baseball", Color.green))
    }

    var body: some View {
        GeometryReader { reader in
            VStack {
                HStack(alignment: .center, spacing: 0) {
                    Button {
                        controller.scrollTo(controller.yearMonth.addMonth(value: -1), isAnimate: true)
                    } label: {
                        Image(systemName: "chevron.left")
                    }.padding(8)


                    Spacer()
                    
                    Text("\(controller.yearMonth.monthShortString), \(String(controller.yearMonth.year))")
                        .font(.title)
                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    Spacer()
                    Button {
                        controller.scrollTo(controller.yearMonth.addMonth(value: 1), isAnimate: true)
                    } label: {
                        Image(systemName: "chevron.right")
                    }.padding(8)
                }

                
                CalendarView(controller, header: { week in
                    GeometryReader { geometry in
                        Text(week.shortString(locale: locale))
                            .font(.subheadline)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    }
                }, component: { date in
                    GeometryReader { geometry in
                        VStack(alignment: .leading, spacing: 2) {
                            if date.isToday {
                                ZStack{
                                    Circle().strokeBorder(mainColorPurple ?? .black, lineWidth: 1).padding(.leading, 2)
                                    
                                    
                                    Text("\(date.day)")
                                        .font(Font.custom("Manrope", size: 14)).fontWeight(.regular).padding(.leading, 5)
                                    
                                    
                                }
                                .padding(.bottom, 20)
                                    
                            } else {
                                ZStack{
                                    if focusDate == date {
                                        Circle().foregroundColor(mainColorPurple)
                                    }
                                    Text("\(date.day)")
                                        .font(Font.custom("Manrope", size: 14)).fontWeight(.regular)
                                        .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                                        .foregroundColor(focusDate == date ? .white : .black)
                                }
                                
                                    .padding(.leading, 25)
                            }
                            if let infos = informations[date] {
                                ForEach(infos.indices) { index in
                                    let info = infos[index]
                                    if focusInfo != nil {
                                        Rectangle()
                                            .fill(info.1.opacity(0.75))
                                            .frame(width: geometry.size.width, height: 4, alignment: .center)
                                            .cornerRadius(2)
                                            .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                                    } else {
                                        Text(info.0)
                                            .lineLimit(1)
                                            .foregroundColor(.white)
                                            .font(.system(size: 8, weight: .bold, design: .default))
                                            .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                                            .frame(width: geometry.size.width, alignment: .center)
                                            .background(info.1.opacity(0.75))
                                            .cornerRadius(4)
                                            .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                                    }
                                }
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
                        
                        .onTapGesture {
                            
                            withAnimation() {
                                if focusDate == date {
                                    focusDate = nil
                                    focusInfo = nil
                                } else {
                                    focusDate = date
                                    focusInfo = informations[date]
                                }
                            }
                        }
                    }
                })
                if let infos = focusInfo {
                    List(infos.indices, id: \.self) { index in
                        let info = infos[index]
                        HStack(alignment: .center, spacing: 0) {
                            Circle()
                                .fill(info.1.opacity(0.75))
                                .frame(width: 12, height: 12)
                            Text(info.0)
                                .padding(.leading, 8)
                        }
                    }
                    .frame(width: reader.size.width, height: 160, alignment: .center)
                }
            }
        }
    }

    private func getColor(_ date: YearMonthDay) -> Color {
        if date.dayOfWeek == .sun {
            return Color.red
        } else if date.dayOfWeek == .sat {
            return Color.blue
        } else {
            return Color.black
        }
    }
}


struct EmbedHeaderView: View {

    @ObservedObject var controller: CalendarController = CalendarController()

    var body: some View {
        GeometryReader { reader in
            VStack {
                HStack(alignment: .center, spacing: 0) {
                    Button {
                        controller.scrollTo(controller.yearMonth.addMonth(value: -1), isAnimate: true)
                    } label: {
                        Image(systemName: "chevron.left")
                    }.padding(8)


                    Spacer()
                    Text("\(controller.yearMonth.monthShortString), \(String(controller.yearMonth.year))")
                        .font(.title)
                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    Spacer()
                    Button {
                        controller.scrollTo(controller.yearMonth.addMonth(value: 1), isAnimate: true)
                    } label: {
                        Image(systemName: "chevron.right")
                    }.padding(8)
                }
                CalendarView(controller, header: { week in
                    GeometryReader { geometry in
                        Text(week.shortString)
                            .font(.subheadline)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    }
                }, component: { date in
                    GeometryReader { geometry in
                        Text("\(date.day)")
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                            .font(.system(size: 14, weight: .regular, design: .default))
                            .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                    }
                })
            }
        }
    }
}

struct InventoryItem: Identifiable {
    var id: String
    var type1: Bool
    var type2: Bool
    var to = Date()
    var from = Date()
    var accept = false

    
}

struct Notes: View {
    let n = [1, 2, 3]
    @State var sheetDetail = InventoryItem(id: UUID().description, type1: true, type2: true)
    @State var showFilter : Bool = false


    var body: some View {
        NavigationView{
            ZStack{
                
                Color(hex: "EFF0F4").ignoresSafeArea()
                VStack{
                    
                    
//                    CalendarView() { date in
//                        Text("\(date.day)")
//                    }
                    
                 //   EmbedHeaderView()
                    
                    InformationWithSelectionView()
                    
                    
                    HStack {
                        
                        Text("Мои записи").font(Font.custom("Manrope", size: 16)).fontWeight(.bold).padding(.bottom, 1).padding(.leading, 30)
                        
                        Spacer()
                        
                        Button {
                           // sheetDetail = InventoryItem(id: UUID().description, type1: true, type2: true, ot: nil, from: nil)
                            showFilter = true
                            
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 12).frame(width: 86, height: 28).foregroundColor(.white)
                                Text("фильтр").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(mainColorPurple)
                            }
                        }
                        .sheet( isPresented: $showFilter, onDismiss: dismiss) {
                            NoteSheet(detail: $sheetDetail)
//                            .onTapGesture {
//                                sheetDetail = nil
//                            }
                        }
                    
                        
                        NavigationLink {
                            NewNote()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 12).frame(width: 129, height: 28).foregroundColor(mainColorPurple)
                                Text("новая запись").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.white)
                            }.padding(.trailing, 30)
                        }
                        
                       
                    }
                    
                    ScrollView{
                        ForEach(n,  id: \.self){_ in
                            NavigationLink {
                                Note()
                            } label: {
                                NoteRow()

                            }

                        }.padding(.vertical)
                        
                    }
                    
                    
                }
                
            }
            
        }

    }
    func dismiss(){
        print(sheetDetail.from)
    }
}

struct Notes_Previews: PreviewProvider {
    static var previews: some View {
        Notes(sheetDetail: InventoryItem(id: "dc", type1: false, type2: false))
    }
}
