//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Миша Перевозчиков on 22.12.2021.
//

import SwiftUI
import CoreData

@main
struct FriendFaceApp: App {
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
