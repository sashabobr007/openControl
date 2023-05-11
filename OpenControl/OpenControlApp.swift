//
//  OpenControlApp.swift
//  OpenControl
//
//  Created by Александр Алексеев on 06.05.2023.
//

import SwiftUI
import FirebaseCore


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


  var body: some Scene {
    WindowGroup {
      NavigationView {
        //SwiftUIView()
          TabBar()
          //PickerNew()
      }
    }
  }
}
