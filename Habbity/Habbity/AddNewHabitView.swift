//
//  AddNewHabitView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 21.11.2021.
//

import SwiftUI


struct AddNewHabitView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var habits: Habits
    
    //ATTEMPTS TO CONNECT DATA WITH STRUCT
//    let icon: HabitItem.Icon
//    @ObservedObject var icon: Icon
    
    
    let iconColors = ["green", "mint", "blue", "heaven", "lemon", "pink", "orange", "peach", ]

    
    
    @State private var name = ""
    @State private var actionPlan = ""
    @State private var amountPerDay = 1
    @State private var iconColor = "green"
    @State private var iconName = ""
    @State private var showIconView = false
    
    let columns = [
        GridItem(.adaptive(minimum: 60))
    ]
    
    
    var body: some View {
        NavigationView{
            
            VStack {
                Form {
                    
                    Section(header: Text("Create your own habit")){
                        HStack {
                            Image(systemName: "book")
                                .font(.system(size: 30))
                                .foregroundColor(Color(iconColor))
                                .padding(5)
                                .onTapGesture{
                                    showIconView = true
                                }
                            TextField("Habit name", text: $name)
                                .font(.title2)
                        }
                    }
                    .foregroundColor(.black)
                    
                    Section {
                        TextField("Your action plan", text: $actionPlan)
                        
                        Stepper("\(amountPerDay) times a day", value: $amountPerDay, in: 1...20)
                    }
                    
                    Section(header: Text("Select habit color")) {
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(iconColors, id: \.self) { icon in
                                ZStack{
                                    Circle()
                                        .fill(Color(icon))
                                        .frame(width: 30, height: 30)
                                        .onTapGesture {
                                            iconColor = icon
                                        }
                                        .padding(5)
                                    if iconColor == icon {
                                        Circle()
                                            .stroke(Color(icon), lineWidth: 2)
                                            .frame(width: 37, height: 35)
                                    }
                                }
                            }
                        }
                    }
                    .foregroundColor(.black)
                    
                    Section(header: Text("Or use suggested habits")){
                        
                    }
              
                        
                }
                
                .navigationBarTitle("Add new habit")
                .navigationBarItems(
                    
                    trailing: Button(action: {
                        let habit = HabitItem(name: self.name, actionPlan: self.actionPlan, amountPerDay: self.amountPerDay, iconColor: self.iconColor)
                    
                    self.habits.items.append(habit)
                    self.presentationMode.wrappedValue.dismiss()
                    
                }){
                    
                    HStack {
                        Text("Save")
                        Image(systemName: "plus.circle")
                    }
                  
                })
                .sheet(isPresented: $showIconView ){
//                    IconView(icon: Icon(name: icon.name))
                    IconView()
                }
            }
        }
    }
}


struct AddNewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewHabitView(habits: Habits())
    }
}
