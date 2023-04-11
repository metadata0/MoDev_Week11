//
//  CommentView.swift
//  SideProjectClub2
//
//  Created by Henry Chen on 4/10/23.
//

import SwiftUI

struct CommentView: View {
    
    
    var body: some View {
        
        VStack {
            GeometryReader { geo in
                
//                let rect = geo.frame()
//
                ZStack {
                    Rectangle()
                        
                }
                Text("yeet")
                    .frame(width: geo.size.width)
                    .background(.red)
                
                Text("lool")
            }
            .background(.white)
            Text("More text")
        }
    }
}


struct ItemDragView: View {
    var item: ItemModel
    
    var body: some View {
        
    }
    
}


struct ItemView: View {
    var item: ItemModel
    var position: CGPoint;
    
    var body: some View {
        ZStack {
            if (item.selected) {
                Rectangle()
                    .stroke(lineWidth: 5)
            }
            Rectangle()
                .fill()
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}
