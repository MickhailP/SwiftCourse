//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Миша Перевозчиков on 23.01.2022.
//

import PhotosUI
import SwiftUI

//CREATING A SwiftUI View from UIKit
// AND USE COORDINATOR TO MANAGE RESULTS AND RESPONSE TO USER'S ACTIONS
struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage? // allows us to create a binding from ImagePicker up to whatever created it
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        
        //That means adding an ImagePicker property and associated initializer to the Coordinator class
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // Tell the picker to go away
            picker.dismiss(animated: true)
            
            // Exit if no selection was made //Pressed Cancel
            guard let provider = results.first?.itemProvider else { return }
            
            // If this has an image we can use, use it
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
    func makeUIViewController(context: Context) -> PHPickerViewController {
        // set configuration to create PHPicker
        var config = PHPickerConfiguration()
        config.filter = .images //Select a type what we are looking for
        
        //Create PICKER ITSELF
        let picker = PHPickerViewController(configuration: config)
        
        //use the coordinator that just got made as the delegate for the PHPickerViewController
        picker.delegate = context.coordinator
        return picker
        
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    //create and configure an instance of our Coordinator class, then send it back.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

//NSObject, PHPickerViewControllerDelegate:

//It makes the class inherit from NSObject, which is the parent class for almost everything in UIKit. NSObject allows Objective-C to ask the object what functionality it supports at runtime, which means the photo picker can say things like “hey, the user selected an image, what do you want to do?”
//It makes the class conform to the PHPickerViewControllerDelegate protocol, which is what adds functionality for detecting when the user selects an image. (NSObject lets Objective-C check for the functionality; this protocol is what actually provides it.)
//It stops our code from compiling, because we’ve said that class conforms to PHPickerViewControllerDelegate but we haven’t implemented the one method required by that protocol.

