//
//  File.swift
//  VK
//
//  Created by Иван Пуриков on 08/06/2019.
//  Copyright © 2019 Иван Пуриков. All rights reserved.
//

import Foundation
struct User: Codable {
    
    let id: Int
    let name: String
    let userNameIvan: String
    let email: String
    let phone: String
    let website: String
    let company : Company
}

struct Company : Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
    
    struct Geo: Codable {
        let latitude: String
        let longitude: String
        
        enum CodingKeys: String, CodingKey {
            case latitude = "lat"
            case longitude = "lng"
        }
    }
}
