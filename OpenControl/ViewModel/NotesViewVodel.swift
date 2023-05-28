//
//  NotesViewVodel.swift
//  OpenControl
//
//  Created by Александр Алексеев on 28.05.2023.
//

import Foundation


struct AppointmentView: Identifiable, Hashable {
    let id, time, status, withWho: String
    let uid = UUID()
    init(id: String, time: String, status: String, withWho: String) {
        self.id = id
        self.time = time
        self.status = status
        self.withWho = withWho
    }
}


class NoteViewModel: ObservableObject {
    @Published  var organ = ""
    @Published  var vid = ""
    @Published var  app = [AppointmentView]()
    
    init(){
        if UserRole.role == .inspector{
            fetchDataIns()
        }else
        {fetchData()
         }
    }
    
    func fetchDataIns () {
        let uid = UserRole.uid
        
        Database.shared.kno(path: "/appointments/inspection?knoId=\(uid)&inspectorId=\(uid)") { (value : AppointmentList) in
            DispatchQueue.main.async {
                print(value)
                for item in value.appointments{
                    self.app.append(AppointmentView(id: item.id, time: item.time, status: item.status, withWho: item.withWho))
                    
                }
            }
            
        }
    }
    
    
    func fetchData () {
        let uid = Database.shared.getUuid()
        
        Database.shared.kno(path: "/appointments/business?userId=\(uid)") { (value : AppointmentList) in
            DispatchQueue.main.async {
                print(value)
                for item in value.appointments{
                    self.app.append(AppointmentView(id: item.id, time: item.time, status: item.status, withWho: item.withWho))
                    
                }
            }
            
        }
    }
    
}
