//
//  ContentView.swift
//  SideProjectClub
//
//  Created by Henry Chen on 4/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var longPressPosition: CGPoint = .zero
    @EnvironmentObject var document: Document
    
    var body: some View {
        GeometryReader { geometry in
            let rect = geometry.frame(in: .local)
            ZStack {
                Rectangle()
                    .fill(Color(white: 0.8))
                    .onTapGesture {
                        print("ContentView onTapGesture")
                        document.clearSelection()
                    }
                    .onLongPressGesture(minimumDuration: 0.3) {
                        document.addItem(x: Int(longPressPosition.x), y: Int(longPressPosition.y))
                    }
                    
                                         
                VStack {
                    if document.items.isEmpty {
                        Spacer()
                    }
                    else {
                        ZStack {
                            ForEach(document.items) { item in
                                ItemDragView(item: item)
                            }
                        }
                    }
                    if let item = document.selectedItem {
                        Text("x \(item.x) y \(item.y) color \(item.colorName)")
                        HStack {
                            ColorPicker("Color", selection: $document.itemColor)
                        }
                        .buttonStyle(.bordered)
                        
                    }
                    HStack {
                        Button("Add") {
                            withAnimation {
                                document.addItem(rect: rect)
                            }
                        }
                        Button("Clear") {
                            withAnimation {
                                document.clear();
                            }
                        }
                        Button("Shake") {
                            withAnimation {
                                document.shakeDemo();
                            }
                        }
                        Button("Color") {
                            withAnimation {
                                document.colorDemo();
                            }
                        }
                    }
                    .buttonStyle(.bordered)
                    HStack {
                        Picker("Palette", selection: $document.selectedPalette) {
                            Text("rgb").tag(Palette.rgb)
                            Text("fixed").tag(Palette.fixed)
                        }
                        Button("Move-Back") {
                            withAnimation {
                                document.sendToBack();
                            }
                        }
                        Button("Save") {
                            document.save("chipItems.json");
                        }
                        Button("Restore") {
                            document.restore("chipItems.json");
                        }
                    }
                    .buttonStyle(.bordered)
                    Text("frame \(format(rect))")
                }
                .padding(20)
                .onAppear() {
                    // document.addInitalItem(rect: rect)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let document = Document()
        ContentView()
            .environmentObject(document)
    }
}

