//
//  ContentView.swift
//  SideProjectClub
//
//  Created by Henry Chen on 4/10/23.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @State private var location: CGPoint = .zero
    @EnvironmentObject var document: Document
    @State private var showComment = false;
    @State private var showImagePicker = false;
    
    @State private var image = UIImage()
    
    var body: some View {
        
//        let location = LongPressGesture(minimumDuration: 0.3)
////                    .onEnded { value in
////                        self.longPressPosition = value.location
////                        print("x: \(self.location.x), y: \(self.location.y)")
////                    }
        
        GeometryReader { geometry in
            let rect = geometry.frame(in: .local)
            ZStack {
                //check if the image is loaded
                if let image = document.documentImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: rect.width, height: rect.height)
                        .clipped()
                } else {
                    Rectangle()
                        .fill(Color(white: 0.9))
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(selectedImage: self.$image, sourceType: .photoLibrary)
                                .onDisappear {
                                    document.updateImg(image: self.image)
                                }
                        }
                    
                    
                }
                
                Rectangle()
                    .fill(Color(white: 0.9))
                    .onTapGesture { location in
                        self.location = location
//                        print("ContentView onTapGesture")
                        document.clearSelection()
                    }
//                    .onLongPressGesture(minimumDuration: 0.3){
//                        document.addItem(x: Int(location.x), y: Int(location.y))
//                    }
                    .gesture(LongPressGesture(minimumDuration: 0.3).sequenced(before: DragGesture(minimumDistance: 0, coordinateSpace: .local))
                        .onEnded { value in
                            switch value {
                            case .second(true, let drag):
                                location = drag?.location ?? .zero   // capture location !!
                                document.addItem(x: Int(location.x), y: Int(location.y))
                            default:
                                break
                            }
                        })
                
                //https://stackoverflow.com/questions/62837754/capture-touchdown-location-of-onlongpressgesture-in-swiftui
                                                             
                VStack {
                    
                    
                        Button(action: {
                            showImagePicker = true
                        }) {
                            HStack {
                                Text("Load Image")
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(20)
                                            .padding(.horizontal)
                        }
                    
                    
                    if document.items.isEmpty {
                        Spacer()
                    }
                    else {
                        ZStack {
                            ForEach(document.items) { item in
                                ItemDragView(item: item)
                            }
                        }
                        //https://www.hackingwithswift.com/quick-start/swiftui/how-to-present-a-new-view-using-sheets
                        //https://www.hackingwithswift.com/quick-start/swiftui/how-to-display-a-bottom-sheet
                        .sheet(isPresented: $document.selectionState){
                 CommentView(selectedId:document.selectedId, selectedText: $document.selectedCommentText)   
                                .onDisappear {
                                    if (document.selectedAction == "delete note") {
                                        //reset action
                                        document.selectedAction = ""
//                                        print("yeet")
                                        document.deleteItems()
                                        }
                                }
                        }
                    }
                    
                    //if item is selected
                    if let item = document.selectedItem {
//                        CommentView(selectedId:document.selectedId, selectedText: $document.selectedCommentText)
                            
                            
                        Text("x \(item.x) y \(item.y) color \(item.colorName)")
                        HStack {
                            ColorPicker("Color", selection: $document.itemColor)
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding(20)
                
                
            }
        }
    }
}


//imagepicker
//https://www.appcoda.com/swiftui-camera-photo-library/

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
        var parent: ImagePicker
     
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
     
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
     
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
 
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
 
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
 
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
 
        return imagePicker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
 
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let document = Document()
//        ContentView()
//            .environmentObject(document)
//    }
//}

