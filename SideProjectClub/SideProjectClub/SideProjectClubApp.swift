//
//  SideProjectClubApp.swift
//  SideProjectClub
//
//  Created by Henry Chen on 4/10/23.
//

import SwiftUI

@main
struct SideProjectClubApp: App {
    @StateObject var document = Document()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(document)
        }
    }
}
