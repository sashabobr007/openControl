//
//  OpenControlApp.swift
//  OpenControl
//
//  Created by Александр Алексеев on 06.05.2023.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct OpenControlApp: App {
    let persistenceController = PersistenceController.shared

  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

@State private var login = ""
   
  var body: some Scene {
    WindowGroup {
        MainView()
//      NavigationView {
//          if login.count != 0{
//              TabBar()
//          }else{
//              //SwiftUIView(email1: $login)
//              Enter(login: $login)
//          }
//
//
//          //TabBar()
//
//          //PickerNew()
//      }.onAppear {
//          login = Auth.auth().currentUser?.uid ?? ""
//          print(login)
//      }
    }
  }
}
