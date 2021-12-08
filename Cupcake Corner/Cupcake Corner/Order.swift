//
//  Order.swift
//  Cupcake Corner
//
//  Created by Миша Перевозчиков on 03.12.2021.
//

import Foundation

struct DemoOrder: Codable {
    var type = 0
    var quantity = 3
    
    var specialRequest = false {
        didSet{
            if specialRequest == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var validateAddressDemo: Bool {
        
        if  name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        {
            return false
        }
        
        return true
    }
    
    var costDemo: Double {
        //$2 per cake
        var cost = Double(quantity) * 2
        
        //complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1 / cake with extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        //$0.5/ cake with sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }
}

@dynamicMemberLookup
class DemoOrderItem: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var orderD = DemoOrder()
    
    subscript<T>(dynamicMember keyPath: KeyPath<DemoOrder, T>) -> T {
        orderD[keyPath: keyPath]
    }
    subscript<T>(dynamicMember keyPath: WritableKeyPath<DemoOrder, T>) -> T {
        get { orderD[keyPath: keyPath] }
        set { orderD[keyPath: keyPath] = newValue }
    }
}






class Order: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequest = false {
        didSet{
            if specialRequest == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidateAddress: Bool {
        
        if  name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        //$2 per cake
        var cost = Double(quantity) * 2
        
        //complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1 / cake with extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        //$0.5/ cake with sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }
    
    init() {}
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
}
