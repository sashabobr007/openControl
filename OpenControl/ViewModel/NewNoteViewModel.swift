//
//  NewNoteViewModel.swift
//  OpenControl
//
//  Created by Александр Алексеев on 27.05.2023.
//

import Foundation


import Firebase
import FirebaseCore
import FirebaseFirestore



// MARK: - FreeWindow
struct free: Identifiable {
    let id, appointmentTime: String
    let uid = UUID()
}

struct MMeasure: Identifiable {
    let id: Int
    let name: String
    let uid = UUID()
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

struct Knolist: Identifiable {
    let id: Int
    let name: String
    let uid = UUID()
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}


class NewNoteViewModel: ObservableObject {
    @Published  var organ = ""
    @Published  var vid = ""
    @Published var kno = [Knolist]()
    @Published var email = ""
    @Published var knoStr = [String]()
    
    @Published var timeSelect = ""

    
    @Published var dateSelect = Date()
    
    @Published var mes = [MMeasure]()

    @Published var mStr = [String]()
    
    @Published var date = [free]()

    @Published var times = [free]()
    
    @Published var timesStr = [String]()


    
    //@Published var users : [User] = []
    init(){
        fetchData()
    }
    
//
//    func addCurrentUser () {
//
//       guard let uid = Auth.auth().currentUser?.uid else { return }
//        print(uid)
//
//        var params : [String : Any] = [
//
//              "userId": uid,
//              "email": email,
//              "firstName": firstName,
//              "lastName": lastName,
//              "surName": surName,
//              "inn": Int(inn) ?? 0,
//              "snils": Int(snils) ?? 0
//
//        ]
//
//        Database.shared.saveUser(path: "/business-info/update", parameters: params) { (value : Welcome) in
//            print(params)
//        }
//
//
//
//   }
    
    func fetchData () {
        
        
        Database.shared.kno(path: "/info/knos") { (value : Kno) in
            DispatchQueue.main.async {
                for item in value.knoList{
                    self.kno.append(Knolist(id: item.id, name: item.name))
                    self.knoStr.append(item.name)
                    
                }
            }
            
        }
    }
        
         
         func fetchMeasure () {
             vid = ""
             mes.removeAll()
             mStr.removeAll()
            var id = 0
             for item in kno{
                 if item.name == organ{
                     id = item.id
                 }
             }
             Database.shared.kno(path: "/info/measures?knoId=\(id)") { (value : Measurements) in
                 DispatchQueue.main.async {
                     for item in value.measures{
                         self.mes.append(MMeasure(id: item.id, name: item.name))
                         self.mStr.append(item.name)

                     }
                     print("done")
                 }

             }
        
       
    }
    
    func fetchList () {
//        vid = ""
//        mes.removeAll()
//        mStr.removeAll()
        date.removeAll()
        if self.date.isEmpty{
            var id = 0
            for item in kno{
                if item.name == organ{
                    id = item.id
                }
            }
            Database.shared.kno(path: "/appointments/free?knoId=\(id)") { (value : Window) in
                DispatchQueue.main.async {
                    for item in value.freeWindows{
                        self.date.append(free(id: item.id, appointmentTime: item.appointmentTime))
                        
                    }
                }
                
            }
        }
  
}
    
    func fetchDateList(){
        times.removeAll()
        timesStr.removeAll(keepingCapacity: false)
        var data = ""
        var data1 = ""
        
        data = data.split(separator: "T").first?.description ?? ""
        
        let dateFormat = "yyyy-MM-dd"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let startDate = dateFormatter.string(from: dateSelect)
        print(startDate)
        
//        //print(dateSelect)
//        //let str = dateSelect.formatted(date: .abbreviated, time: .omitted)
//        if data == startDate{
//            print("=")
//        }
//        //let dateSel = dateSelect.formatted(date: .numeric, time: .omitted)
//
        for item in date{
            data = item.appointmentTime
            data = data.split(separator: "T").first?.description ?? ""
            if data == startDate{
                //print("=")
                times.append(item)
                data = item.appointmentTime

                data1 = data.split(separator: "T").last?.description ?? ""
                data1 = data1.split(separator: ".").first?.description ?? ""
                print(data1)
                timesStr.append(data1)
            }

        }
        print(timesStr)

        
    }
    
    func addNote(){
        var data = ""
        var id1 = 0
        for item in kno{
            if item.name == organ{
                id1 = item.id
            }
        }
        print(id1)
        var id = 0
        for item in mes{
            if item.name == vid{
                id = item.id
            }
        }
        print(id)
        for item in times{
            data = item.appointmentTime
            data = data.split(separator: "T").last?.description ?? ""
            data = data.split(separator: ".").first?.description ?? ""

            if data == timeSelect{
                print(data)
                print(item)
                
                var params : [String : Any] = [
                    "userId": Database.shared.getUuid(),
                    "appointmentId": item.id,
                      "measureId": id
                ]

                Database.shared.saveApp(path: "/business-user/appointments/select", parameters: params) { (value : Welcome) in
                    DispatchQueue.main.async {
                        params = [

                            "userId": String(id1),
                                                "appointmentId": item.id,
                                                  "measureId": id

                        ]
                        print(params)

//                        Database.shared.saveApp(path: "/appointments/select", parameters: params) { (value : Welcome) in
//
//
//                                     }

                    }

                }
                
                                
            }
        }
    }
   
    
    
}
