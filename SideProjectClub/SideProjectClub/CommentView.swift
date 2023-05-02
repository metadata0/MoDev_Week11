//
//  File.swift
//  SideProjectClub
//
//  Created by Henry Chen on 4/18/23.
//

import SwiftUI

struct CommentView: View {
//    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var document: Document
    @State private var profileText = ""
//    var selectedItem: ItemModel? { document.model.item(id: document.selectedId)}
    var selectedId: Int
    @Binding var selectedText: String
    
    var body: some View {
//        Button("Press to dismiss") {
//            dismiss()
//        }
        List{
            VStack{
                TextField("Leave your note here", text: $selectedText, axis: .vertical)
                            .lineLimit(12, reservesSpace: true)
                            .textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Button("clear comment") {
                    document.clearComment(id: selectedId)
                }
            }
            HStack {
                Button("delete note") {
                    document.selectedAction = "delete note"
//                    document.selectionState = false

//                    document.deleteItems(id: selectedId)
                    
                }
            }
        }
            .presentationDetents([.large, .medium, .fraction(0.75)])
            .onDisappear {
                //update file
                document.update(id: selectedId, comment: document.selectedCommentText)
                }
        
    }
}
