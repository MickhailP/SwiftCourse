//
//  ViewModel.swift
//  RememberMe
//
//  Created by Миша Перевозчиков on 07.02.2022.
//

import SwiftUI
import Foundation
import LocalAuthentication

@MainActor class ViewModel: ObservableObject {
    
    @Published var units: [Unit]
    
    //Authentication properties group
    @Published var isUnlock = false
    @Published var showAuthenticationAlert = false
    @Published var authenticationError: Error?
    
    //image properties group
    @Published var image: Image?
    @Published var inputImage: UIImage?
    
    //Showing AddView after ContentView
    @Published var showAddView = false
    
    let savePath = FileManager.documentDirectory.appendingPathComponent("SavedUnits")
    
    //decode data from local storage
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            units = try JSONDecoder().decode([Unit].self, from: data).sorted()
            } catch {
             units = []
            print("Unable to decode Units. \(error.localizedDescription)")
        }
    }
    
    //Encode an save unit instance to file in local storage with protection
    func saveUnit() {
        do {
            let data = try JSONEncoder().encode(units)
            
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            
        } catch {
            print("Unable to encode/save data \(error.localizedDescription)")
        }
    }
    
    //delete Unit instance form array an save new array of Units
    func removeItems(at offsets: IndexSet) {
        units.remove(atOffsets: offsets)
        saveUnit()
    }
    
    //Biometrics authentication on main screen
    func authenticate() {
        
        //add a context of Authentication
        let context = LAContext()
        var error: NSError?
        
        //check possibility to use biometrics
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Unlock to see your photos"
            
            //use authentication
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                if success {
                    //change view
                    Task{ @MainActor in
                        self.isUnlock = true
                    }
                }else {
                    //show an error and Alert
                    Task { @MainActor in
                        self.showAuthenticationAlert = false
                        self.authenticationError = authenticationError
                    }
                    print(authenticationError ?? "Something goes wrong")
                }
            }
        } else {
            // no biometrics
            print("Biometrics unavailable")
        }
        
    }
}
