//
//  BotViewModel.swift
//  OpenControl
//
//  Created by Александр Алексеев on 16.05.2023.
//

import Foundation

//struct Answer : Hashable{
//    static func == (lhs: Answer, rhs: Answer) -> Bool {
//        if lhs.an == rhs.an{
//            return true
//        }else {
//            return false
//        }
//    }
//
//    let an :String
//    let i : Int
//}
//
//struct Message : Identifiable {
//    let answers : [Answer]
//    let id = UUID()
//    let text : String
//    let bot : Bool
//    init(answers: [Answer], text: String, bot : Bool) {
//        self.answers = answers
//        self.text = text
//        self.bot = bot
//    }
//}
//
//let bot = [
//    0 : ("Some Q???", [("yeees", 1), ("nooo", 2)]),
//    1 : ("first", [("yeees", 1), ("nooo", 2)]),
//    2 : ("Second", [("yeees", 1), ("nooo", 2)])
//
//]


struct Mes : Identifiable{
    let id = UUID()
    let text : String
    let bot : Bool
    init(text: String, bot: Bool) {
        self.text = text
        self.bot = bot
    }
}


class BotViewModel : ObservableObject {
    
    @Published var text = ""
    
    
    @Published var chatMessages : [Mes] = [Mes(text: "Здравствуйте, я бот-помощник\n Чем могу помочь?", bot: true)]
    
    @Published var count = 0
        
    func restart(){
        self.count = 0
        self.chatMessages.removeAll()
        chatMessages.append(Mes(text: "Здравствуйте, я бот-помощник\n Чем могу помочь?", bot: true))
        
    }
    
    func handleSend(){
        
        self.chatMessages.append(Mes(text: text, bot: false))
        self.count += 1
        
        //print(count)

        var new = false
        if count == 1{
            new = true
        }
        
        //print(new)

        let params : [String : Any] = [
            "id": 12345,
            "question": text,
            "new_chat": new
        
        ]
        
            Database.shared.bot(parameters: params) { (value : BotJson) in
                //print(value.answer)
                DispatchQueue.main.async {
                    self.text = ""
                    self.chatMessages.append(Mes(text: value.answer, bot: true))
                    self.count += 1

                }
            }
        

        
        
        

                
    }
    
}
