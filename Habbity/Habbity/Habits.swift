//
//  Habits.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 05.12.2021.
//

import Foundation

class Habits: ObservableObject {
    
    @Published var items: [HabitItem] {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let saved = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([HabitItem].self, from: saved){
                items = decoded
                return
            }
        }
        items = []
    }
}
