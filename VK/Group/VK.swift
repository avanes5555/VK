//
//  VK.swift
//  VK
//
//  Created by Иван Пуриков on 09/06/2019.
//  Copyright © 2019 Иван Пуриков. All rights reserved.
//

import Foundation
import SwiftyJSON

class Weather {
    let data: Date
    let tempreture: Double
    let presure : Double
    
    let icon: String
    let desc: String
    
    init(_ json: JSON) {
        
        let date = json["dt"].doubleValue
        
        self.data = Date(timeIntervalSince1970: date)
        
        self.tempreture = json["main"]["tmp"].doubleValue
        self.presure = json["main"]["tmp"].doubleValue
        
        self.icon = json["weather"][0]["icon"].stringValue
        self.desc = json["weather"][0]["description"].stringValue
        
    }
}
