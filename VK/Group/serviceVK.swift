//
//  serviceVK.swift
//  VK
//
//  Created by Иван Пуриков on 09/06/2019.
//  Copyright © 2019 Иван Пуриков. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherService {
    public func weatherForecast(for city: String, completion: ((Swift.Result<[Weather], Error>) -> Void)? = nil) {
        let baseUrl = "https://api.openweathermap.org"
        let path = "/data/2.5/forecast"
        
        let params: Parameters = [
            "q": city,
            "units": "metric",
            "appId": "8b32f5f2dc7dbd5254ac73d984baf306"
        ]
        
        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let weathers = json["list"].arrayValue.map { Weather($0) }
                
                print(weathers.count)
                completion?(.success(weathers))
            case .failure(let error):
                completion?(.failure(error))
                
                print(error.localizedDescription)
            }
        }
    }
}
