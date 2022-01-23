//
//  DetailUserView.swift
//  FriendFace
//
//  Created by Миша Перевозчиков on 23.12.2021.
//
import CoreData
import SwiftUI

struct DetailUserView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    
    let user: CachedUser
    
    var body: some View {
        
        ScrollView {
            VStack {
                Text(user.wrappedName)
                    .padding()
                    .font(.title)
                
                Text(user.wrappedAbout)
                    .padding()
                    .font(.body)
                    .foregroundColor(.secondary)
                Divider()
                
                HStack(alignment: .center, spacing: 40)  {
                    VStack{
                        Text("Age")
                            .padding(.bottom, 5)
                            .font(.title3)
                        Text("\(user.age) y.o.")
                    }
                    VStack{
                        Text("Company")
                            .padding(.bottom, 5)
                            .font(.title3)
                        Text("\(user.wrappedCompany)")
                    }
                    
                }
                .padding()
                
                VStack(alignment: .leading) {
                    HStack{
                        Image(systemName: "envelope")
                        Text(user.wrappedEmail)
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 40)
                    HStack{
                        Image(systemName: "globe.americas")
                        Text(user.wrappedAddress)
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 40)
                    HStack(alignment: .top){
                        Image(systemName: "calendar")
                        

                        Text("Registered \(user.wrappedRegistred.formatted(date: .abbreviated, time: .omitted))")

                        Spacer()
                    }
                    .padding(.leading, 40)
                    .padding(.vertical, 10)
                    
                }
                .font(.subheadline)
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person.2")
                        Text("Friends")
                        Spacer()
                    }
                    .padding()
                    .font(.title2)
                    
                    VStack(alignment: .leading) {
                        ForEach(user.friendsArray) { mate in
                            Text(" - \(mate.wrappedName)")
                            
                        }
                        .padding(.horizontal, 40)
                        .padding(.vertical, 5)
                        
                        .font(.subheadline)
                        ScrollView(.horizontal){
//                            HStack {
//                                ForEach(user.tags, id: \.self) { tag in
//                                    Text("#\(tag)")
//                                        .padding(5)
//                                        .foregroundColor(.blue)
//                                }
//                            }
                        }
                    }
                }
            }
        }
    }
}


//struct DetailUserView_Previews: PreviewProvider {
//    static var friends: [Friend] = [friend, friend2]
//    static let friend = Friend(id: "UUID", name: "Donny")
//    static let friend2 = Friend(id: "@2123", name: "Bonny")
////    static let tag = User.Tag(tag: "lol")
////    static var tags = [tag]
//
//    static var previews: some View {
//        DetailUserView(user: User(id: "UUID()", isActive: false, name: "Jonny", age: 26, company: "Lol", email: "pi@p.r", address: "Nashville", about: "sdfsdf", registered: Date.now, friends: friends, tags: ["Lol", "BOB"]))
//    }
//}
