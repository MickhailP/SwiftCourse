//
//  DataInitialiser .swift
//  FriendFace
//
//  Created by Миша Перевозчиков on 09.01.2022.
//

import Foundation
import CoreData


extension User {
    
    static func storeData(mocLocal: NSManagedObjectContext, usersLocal: [User]) {
        
//        var tempUsers = [CachedUser]()
        
        for user in usersLocal {
            let newUser = CachedUser(context: mocLocal)
            newUser.id = user.id
            newUser.name = user.name
            newUser.company = user.company
            newUser.age = Int16(user.age)
            newUser.isActive = user.isActive
            newUser.email = user.email
            newUser.address = user.address
            newUser.about = user.about
            newUser.registered = user.registered
            
            
            for friend in user.friends {
                let newFriend = CachedFriend(context: mocLocal)
                newFriend.id = friend.id
                newFriend.name = friend.name
                
                newUser.addToFriend(newFriend)
            }
            
            
            print(newUser.friendsArray.count)
            
        }
        try? mocLocal.save()
    }
    
    static func loadData(with moc: NSManagedObjectContext) async  {
        
        print("Start")
        if let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")  {
            do {
                print("Processing")
                let (data, _)  = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                //              let dateFormatter = DateFormatter()
                
                decoder.dateDecodingStrategy = .iso8601
                
                let decodedUsers = try decoder.decode([User].self, from: data)
                
                await MainActor.run{
                    storeData(mocLocal: moc, usersLocal: decodedUsers)
                    
                    
                }
                
            }
            catch{
                print("Invalid Data")
            }
        }
    }
}


