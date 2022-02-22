//
//  Unit.swift
//  RememberMe
//
//  Created by Миша Перевозчиков on 06.02.2022.
//

import Foundation
import SwiftUI
import CoreLocation

struct Unit: Codable, Identifiable, Equatable, Comparable {
    enum CodingKeys: CodingKey {
        case id, name, picture, latitude, longitude
    }
    var id: UUID
    var name: String
    var image: UIImage
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var latitude: Double
    
    var longitude: Double
    
    
    
    init(id: UUID, name: String, picture: UIImage, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.image = picture
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        
        let pictureData = try container.decode(Data.self, forKey: .picture)
        let decodedPicture = UIImage(data: pictureData)
        self.image = decodedPicture ?? UIImage()
        
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)

    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        
        if let pictureData = image.jpegData(compressionQuality: 0.5){
            try container.encode(pictureData, forKey: .picture)
        }
        
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    static func ==(lhs: Unit, rhs: Unit) -> Bool {
        lhs.id == rhs.id
    }
    
    static func <(lhs: Unit, rhs: Unit) -> Bool {
        lhs.name < rhs.name
    }
    
    static var example = Unit(id: UUID(), name: "Example", picture: UIImage(named: "example")!, latitude: 50.0, longitude: 30.0)
}
