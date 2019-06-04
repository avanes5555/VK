//
//  NetworkingService.swift
//  VK
//
//  Created by Иван Пуриков on 27/05/2019.
//  Copyright © 2019 Иван Пуриков. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingService {
    
    
    
    private let baseUrl = "https://api.vk.com/method"
    
    
    static let session: SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 40
        let session = SessionManager(configuration: config)
        return session
    }()
    
    
    
    public func loadGroups(token: String) {
        
        
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.get"
        
        
        
        let params: Parameters =
        [
        "access_token": token,
        "extended": 1,
        "v": "5.92"
        ]
        //let session = SessionManager()
        NetworkingService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            guard let json = response.value else { return }
            
            
            print(json)
        }
        
        print("end")
    }
}

