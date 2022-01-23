//
//  User.swift
//  FriendFace
//
//  Created by Миша Перевозчиков on 22.12.2021.
//

import Foundation


struct User: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case id, isActive, name, age, company, email, address, about, registered, friends, tags
    }
    
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var friends: [Friend]
    var tags: [String]

}

