//
//  MainPage.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 21.11.2021.
//

import SwiftUI

struct HabitItem: Codable, Identifiable, Equatable {
    var id = UUID()
    let name: String
    let actionPlan: String
    var dailyCounter = 0
    let amountPerDay: Int
    let iconColor: String
    
    static let example = HabitItem( name: "example", actionPlan: "your goal", dailyCounter: 0, amountPerDay: 1, iconColor: "book")
    
    //UNAVAILABLE UNTIL ADDIND FUNCTIONALITY TO ICONVIEW
//    let iconName: String
    
    
}
    //ATTEMPTS TO CONNECT DATA WITH STRUCT

//class Icon: ObservableObject {
//
//    @Published var name: String
//
//
//    init(name: String) {
//        self.name = name
//    }
//}


class Habits: ObservableObject {
    
    @Published var items = [HabitItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encode = try? encoder.encode(items) {
                UserDefaults.standard.set(encode, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([HabitItem].self, from: items){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
    
}

struct MainPage: View {
    
    @State private var showAddHabitView = false
    
    
    @ObservedObject var habits: Habits
    var activity: HabitItem
    
    var body: some View {
        NavigationView {
            
            List{
                ForEach(habits.items, id: \.id){ item in
                    HStack {
                        Circle()
                            .fill(Color(item.iconColor))
                            .frame(width: 30, height: 30)
                            .padding(.trailing)
                        
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                                .padding(.bottom, 5)
                            Text(item.actionPlan)
                                .font(.subheadline)
                                .padding(.bottom, 5)
                            HStack {
                                Text("Daily goal:")
                                    .font(.subheadline)
                                Text("\(activity.dailyCounter) / \(item.amountPerDay)")
                                    .font(.subheadline)
                            }
                            
                        }
                        Spacer()
                      
                            Button(action: {
                                //DAILY HABIT COUNTER
                                
                            }) {
                                Image(systemName: "checkmark.circle")
                            }
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(Color.blue)
                            .font(.system(size: 30))
                            .padding(.trailing, 30)
                        
                    }
                }
            }
                
                    .navigationBarTitle("My habits")
                    .navigationBarItems(trailing:
                        Button(action:{
                            showAddHabitView = true
                        }) {
                            VStack{
                                Image(systemName: "plus.circle")
                                    
                                Text("Add new habit")
                            }
                    })
                    .sheet(isPresented: $showAddHabitView) {
                        AddNewHabitView(habits: self.habits)
                    }
            
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage(habits: Habits(), activity: HabitItem.example)
    }
}
