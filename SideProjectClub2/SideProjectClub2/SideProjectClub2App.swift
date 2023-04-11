//
//  SideProjectClub2App.swift
//  SideProjectClub2
//
//  Created by Henry Chen on 4/10/23.
//

import SwiftUI

@main
struct SideProjectClub2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
