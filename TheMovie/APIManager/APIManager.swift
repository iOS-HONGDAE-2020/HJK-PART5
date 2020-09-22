//
//  APIManager.swift
//  TheMovie
//
//  Created by 김호종 on 2020/09/22.
//  Copyright © 2020 김호종. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    func getMovies(order: MovieOrderType, completion: @escaping (([Movie])->Void)) {
        
        let param: [String : Any] = [
            "order_type": "1"
        ]
        
        
        let request = AF.request(getAPI(.movieList), method: .get, parameters: param)
        
        request.responseString(completionHandler: { response in
            if let resultString: String = response.value {
                let json = JSON.init(parseJSON: resultString)
                let movieList = Movie.build(jsonList: json)
                completion(movieList)
            }
        })
    }
}

var baseURL = "https://connect-boxoffice.run.goorm.io"
enum APIList: String {
    case movieList      = "/movies"
    case movieInfo      = "/movie"
    case commentList    = "/comments"
    case comment        = "/comment"
}

func getAPI(_ api: APIList) -> String {
    return baseURL+api.rawValue
}

enum MovieOrderType: Int {
    case reservationRate    = 0
    case curation           = 1
    case openingDate        = 2
}
