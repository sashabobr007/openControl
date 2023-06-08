//
//  NotesViewVodel.swift
//  OpenControl
//
//  Created by Александр Алексеев on 28.05.2023.
//

import Foundation


struct AppointmentView: Identifiable, Hashable {
    let id, time, status, knoName, measureName: String
    let knoId, measureId : Int
    let uid = UUID()
    var date = Date()
    var num = 0
    init(id: String, time: String, status: String, knoName: String, measureName: String, knoId: Int, measureId: Int, date : Date, num : Int) {
        self.id = id
        self.time = time
        self.status = status
        self.knoName = knoName
        self.measureName = measureName
        self.knoId = knoId
        self.measureId = measureId
        self.date = date
        self.num = num
    }
}


class NoteViewModel: ObservableObject {
    @Published  var organ = ""
    @Published  var vid = ""
    @Published  var  app = [AppointmentView]()
    
    init(){
        if UserRole.role == .inspector{
            fetchDataIns()
        }else
        {fetchData()
         }
    }
    
    func fetchDataIns () {
        let uid = UserRole.uid
        
//        Database.shared.kno(path: "/appointments/inspection?knoId=\(uid)&inspectorId=\(uid)") { (value : AppointmentList) in
//            DispatchQueue.main.async {
//                print(value)
//                for item in value.appointments{
//                    self.app.append(AppointmentView(id: item.id, time: item.time, status: item.status, withWho: item.withWho))
//
//                }
//            }
//
//        }
    }
    
    
    func fetchData () {
        self.app.removeAll()
        let uid = Database.shared.getUuid()
        
        let dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        //dateFormatter.locale = Locale(identifier: "ru_RU_POSIX")
        
        Database.shared.kno(path: "/business-user/appointments?userId=\(uid)") { (value : AppointmentList) in
            DispatchQueue.main.async {
                //print(value)
                var num = 0
                for item in value.appointments{
                    //print(item.time)
                    let data = item.time.split(separator: ".").first?.description ?? ""

                    
                    let startDate = dateFormatter.date(from: data) ?? Date()
                    print(startDate)
                    
            //        //print(dateSelect)
            //        //let str = dateSelect.formatted(date: .abbreviated, time: .omitted)
                    self.app.append(AppointmentView(id: item.id, time: item.time, status: item.status, knoName: item.knoName, measureName: item.measureName, knoId: item.knoId, measureId: item.measureId, date: startDate, num: num))
                    num += 1
                    
                }
                self.app.sort {
                    $0.date < $1.date
                }
            }
            
        }
    }
    
}
