//
//  File.swift
//  SideProjectClub
//
//  Created by Henry Chen on 5/2/23.
//

import SwiftUI

//struct Documents: Identifiable {
//    var id: ObjectIdentifier
//
//    var documents: [Document]
//
//}

let documents: [Document] = [
    Document(documentId: 1, name: "My document 1"),
    Document(documentId: 2, name: "My document 2"),
    Document(documentId: 3, name: "My document 3")
]

struct MenuView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(documents) { document in
                    NavigationLink(document.name, destination: ContentView().environmentObject(document))
                }
            }
        }
    }
}
