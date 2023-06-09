//
//  NoteRowViewModel.swift
//  OpenControl
//
//  Created by Александр Алексеев on 28.05.2023.
//

import Foundation


class NoteRowViewModel: ObservableObject {
    @Published  var organ = 0
    @Published  var id = ""
    //@Published var  app : AppointmentView
    
//    init(){
//        fetchData()
//    }
//    func fetchData (id : String) {
//        print(id)
//        Database.shared.kno(path: "/appointments?appointmentId=\(id)") { (value : AppointmentDetail) in
//            DispatchQueue.main.async {
//                print(value.businessID)
//                
//            }
//            
//        }
//    }
    
    func delete (id : String) {
        let params : [String: Any] = [
            "appointmentId": id
        ]
        
        Database.shared.saveApp(path: "/appointments/cancel", parameters: params) { (value : Welcome) in
            
            
        }
    }
    
    func approve (id : String) {
        let uid = UserRole.uid
        let params : [String: Any] = [
            "userId": uid,
            "appointmentId": id
        ]
        
        Database.shared.saveApp(path: "/inspection-user/appointments/agree", parameters: params) { (value : Welcome) in
            
        }
    }
    
    
    
}
