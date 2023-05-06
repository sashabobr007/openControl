//
//  OpenControlApp.swift
//  OpenControl
//
//  Created by Александр Алексеев on 06.05.2023.
//

import SwiftUI

@main
struct OpenControlApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
