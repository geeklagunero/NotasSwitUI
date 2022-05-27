//
//  NotasSwitUISIApp.swift
//  NotasSwitUISI
//
//  Created by Ricardo Roman Landeros on 25/05/22.
//

import SwiftUI

@main
struct NotasSwitUISIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
