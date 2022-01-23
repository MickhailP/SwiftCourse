//
//  ContentView.swift
//  FriendFace
//
//  Created by Миша Перевозчиков on 22.12.2021.
//

import SwiftUI
import CoreData


struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name )])  var cachedUsers: FetchedResults<CachedUser>
    
    //    @State private var users = [User]()
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                
                List{
                    ForEach(cachedUsers) { user in
                        NavigationLink {
                            DetailUserView(user: user)
                        } label: {
                            HStack {
                                Image(systemName: user.isActive ? "person.crop.circle.fill.badge.checkmark" : "person.crop.circle.badge.xmark")
                                    .font(.title)
                                    .foregroundColor(user.isActive ? Color.green : Color.red)
                                
                                VStack(alignment: .leading){
                                    Text(user.wrappedName)
                                    Text("Friends: \(user.friendsArray.count)")
                                }
                            }
                        }
                    }
                }
                
                
//V.01
//                List{
//                    ForEach(users) { user in
//                        NavigationLink {
//                            DetailUserView(user: user)
//                        } label: {
//                            HStack {
//                                Image(systemName: user.isActive ? "person.crop.circle.fill.badge.checkmark" : "person.crop.circle.badge.xmark")
//                                    .font(.title)
//                                    .foregroundColor(user.isActive ? Color.green : Color.red)
//
//                                VStack{
//                                    Text(user.name)
//                                    Text("\(user.friends.count)")
//                                }
//                            }
//                        }
//                    }
//                }
                .task {
                    if cachedUsers.isEmpty {
                        //CORE DATA PARSING
                        await User.loadData(with: moc)
                    }
                }
            }
            .navigationBarTitle("Friendface")
            .toolbar{
                
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Delete all") {
                        deleteItems()
                    }
                }
            }
        }
    }
    
    func deleteItems() {
        for user in cachedUsers {
            
            moc.delete(user)
        }
        
        // save the context
        try? moc.save()
    }
    
}


//    func loadData() async {
//        print("Start")
//        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
//            print("Invalid URL")
//            return
//        }
//
//        do {
//            print("Processing")
//            let (data, _)  = try await URLSession.shared.data(from: url)
//            let decoder = JSONDecoder()
//            let dateFormatter = DateFormatter()
//
//            decoder.dateDecodingStrategy = .iso8601
//
//            if let decodedUsers = try? decoder.decode([User].self, from: data){
//                print("In")
//                users = decodedUsers
//                print(users.count)
//            }
//        }
//        catch{
//            print("Invalid Data")
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
