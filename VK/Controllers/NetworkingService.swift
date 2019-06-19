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
    
    func exampleOfCodeble()  {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "jsonplaceholder.typicode.com"
        urlComponents.path = "/users"
        
        guard let url = urlComponents.url else { fatalError("URL is badly formatted.")}
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else { return }
            let decoder = JSONDecoder()
            
            do {
                let users = try decoder.decode([User].self, from: data)
                print(users.count)
            } catch {
                print(error.localizedDescription)
            }
        }
            task.resume()
    }
}

