//
//  IconView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 29.11.2021.
//

import SwiftUI

struct IconView: View {
    
    @Environment(\.presentationMode) var presentationMode
   
    //ATTEMPTS TO CONNECT DATA WITH STRUCT
//    @ObservedObject var icon: Icon
//    @ObservedObject var habits: Habits
    
    
    
    let iconNames = ["book", "drop", "heart", "list.bullet.rectangle.portrait", "calendar.badge.clock", "bell", "flag", "bed.double", "lightbulb", "house", "bicycle", "figure.walk","face.smiling", "flame", "pawprint", "leaf", "cart", "alarm", "pills", "globe.americas", "brain.head.profile", "suitcase", "fork.knife", "checklist"]
    
    let columns = [
        GridItem(.adaptive(minimum: 70))
    ]
    
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 40){
            ForEach(iconNames, id: \.self) { iconName in
                Image(systemName: iconName)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 40))
                    .onTapGesture {
                        // HERE SHOULD BE ACTION THAT CHANGE HABIT ICON AND SEND IT'S NAME TO struct HabitItem AND STORE WITH OTHER HABIT ITEM DATA
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
            
        }
        .padding()
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView()
    }
}
