//
//  Habit.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 05.12.2021.
//

import Foundation

struct HabitItem: Codable, Identifiable, Equatable {
    var id = UUID()
    
    let name: String
    let actionPlan: String
    
    var dailyCounter = 0
    let amountPerDay: Int
    
    let iconColor: String
    var iconName: String
    
    
    static let example = HabitItem( name: "example", actionPlan: "your goal", dailyCounter: 0, amountPerDay: 1, iconColor: "book", iconName: "book")

}
