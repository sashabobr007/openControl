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




struct InventoryItem: Identifiable {
    var id: String
    var type1: Bool
    var type2: Bool
    var to = Date()
    var from = Date()
    var accept = false

    
}

struct Notes: View {
    @ObservedObject private var vm = NoteViewModel()

    @ObservedObject var controller: CalendarController = CalendarController()
    @State var informations = [YearMonthDay: [(String, Color)]]()
    @State var focusDate: YearMonthDay? = nil
    @State var focusInfo: [(String, Color)]? = nil

    init() {
        
//        var date = YearMonthDay(year: 2023, month: 5, day: 10)
//        informations[date] = []
//        informations[date]?.append(("Hello", Color.orange))
//        informations[date]?.append(("World", Color.blue))
//
//        date = date.addDay(value: 3)
//        informations[date] = []
//        informations[date]?.append(("Test", Color.pink))
//
//        date = date.addDay(value: 8)
//        informations[date] = []
//        informations[date]?.append(("Jack", Color.green))

        
    }
    
    
    @State var sheetDetail = InventoryItem(id: UUID().description, type1: true, type2: true)
    @State var showFilter : Bool = false
    
    @State var date : Bool = false
    
    @State var today : Date = Date()

    var body: some View {
        NavigationView{
            ZStack{
                
                Color(hex: "EFF0F4").ignoresSafeArea()
                VStack{
                
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
                                                    Circle().strokeBorder(mainColorOrange1 ?? .black, lineWidth: 1).padding(.leading, 2)
                                                    
                                                    
                                                    Text("\(date.day)")
                                                        .font(Font.custom("Manrope", size: 14)).fontWeight(.regular).padding(.leading, 5)
                                                    
                                                    
                                                }
                                                .padding(.bottom, 20)
                                                    
                                            } else {
                                                ZStack{
                                                    if focusDate == date {
                                                        Circle().foregroundColor(mainColorOrange1)
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
                                                        Circle().foregroundColor(mainColorOrange1).frame(width: 4).padding(.leading, 30)
                                                    } else {
                                                        Circle().foregroundColor(mainColorOrange1).frame(width: 4).padding(.leading, 30)

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
                                                    self.date = true
                                                    
                                                    self.today = date.date ?? Date()
                                                    
                                                    print(self.today)
                                                   // self.date = false
                                                    
                                                } else {
                                                    focusDate = date
                                                    focusInfo = informations[date]
                                                    self.date = true
                                                    
                                                    self.today = date.date ?? Date()
                                                    
                                                    print(self.today)
                                                }
                                            }
                                        }
                                    }
                                })
                                if let infos = focusInfo {
                                   // self.date = true

                                }
                            }
                        }
                    
                    
                    
                    HStack {
                        
                        Text("Мои записи").font(Font.custom("Manrope", size: 16)).fontWeight(.bold).padding(.bottom, 1).padding(.leading, 30)
                        
                        Spacer()
                        
                        Button {
                            // sheetDetail = InventoryItem(id: UUID().description, type1: true, type2: true, ot: nil, from: nil)
                            showFilter = true
                            
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 12).frame(width: 86, height: 28).foregroundColor(.white)
                                Text("фильтр").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(mainColorOrange1)
                            }
                        }
                        .sheet( isPresented: $showFilter, onDismiss: dismiss) {
                            NoteSheet(detail: $sheetDetail)
                            //                            .onTapGesture {
                            //                                sheetDetail = nil
                            //                            }
                        }
                        
                        if UserRole.role == .buisnes{
                            NavigationLink {
                            NewNote()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 12).frame(width: 129, height: 28).foregroundColor(mainColorOrange1)
                                Text("новая запись").font(Font.custom("Manrope", size: 14)).fontWeight(.bold).foregroundColor(.white)
                            }.padding(.trailing, 30)
                        }
                    }
                       
                    }
                    
                    ScrollView{
                        ScrollViewReader { proxy in
                            ForEach(vm.app,  id: \.self){app in
                                NavigationLink {
                                    Note(app: app)
                                } label: {
                                    NoteRow(app: app)
                                    
                                }.id(app.num)
                                
                            }.padding(.vertical).onAppear {
                                var date = YearMonthDay(year: 2023, month: 5, day: 10)
                                var ymd = ""
                                var y = 0
                                var m = 0
                                var d = 0
                                for item in vm.app{
                                    ymd = item.time.split(separator: "T").first?.description ?? ""
                                    y = Int(ymd.split(separator: "-").first?.description ?? "") ?? 0
                                    m = Int(ymd.split(separator: "-")[1].description ) ?? 0
                                    d = Int(ymd.split(separator: "-").last?.description ?? "") ?? 0
                                    
                                    date = YearMonthDay(year: y, month: m, day: d)
                                    print(date)
                                    informations[date] = []
                                    informations[date]?.append(("", Color.orange))
                                }
                            }.onChange(of: date) { newValue in
                                if newValue == true{
                                    date.toggle()
                                    for item in vm.app{
                                        if item.date.formatted(date: .numeric, time: .omitted) == today.formatted(date: .numeric, time: .omitted){
                                            withAnimation(.spring()) {
                                                proxy.scrollTo(item.num, anchor: .top)

                                            }
                                            break
                                        }
                                    }
                                }
                            }
                            
                        }
                    }
                   
                    
                    
                }
                
            }.onAppear {
                vm.fetchData()
            }
            
        }

    }
    func dismiss(){
        print(sheetDetail.from)
    }
}

struct Notes_Previews: PreviewProvider {
    static var previews: some View {
        Notes()
       // Notes(sheetDetail: InventoryItem(id: "dc", type1: false, type2: false))
    }
}
