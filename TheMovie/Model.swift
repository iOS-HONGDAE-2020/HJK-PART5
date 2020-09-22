//
//  Model.swift
//  TheMovie
//
//  Created by 김호종 on 2020/09/22.
//  Copyright © 2020 김호종. All rights reserved.
//

import Foundation
import SwiftyJSON

let formatter = DateFormatter()


struct Movie {
    let grade: Int
    let thumbURL: URL
    let reservationGrade: Int
    let title: String
    let reservationRate: Double
    let userRate: Double
    let date: Date
    let id: String
    
    init(grade: Int, thumbURLString: String, reservationGrade: Int, title: String, reservationRate: Double, userRate: Double, date: String, id: String) {
        
        self.grade              = grade
        self.thumbURL           = URL(string: thumbURLString) ?? URL(string: "")!
        self.reservationGrade   = reservationGrade
        self.reservationRate    = reservationRate
        self.title              = title
        self.userRate           = userRate
        self.date               = formatter.date(from: date) ?? Date()
        self.id                 = id
    }
    
    static func build(json: JSON) -> Movie {
        return Movie(
            grade           : json["grade"].int ?? 12,
            thumbURLString  : json["thumb"].string ?? "",
            reservationGrade: json["reservation_grade"].int ?? 1,
            title           : json["title"].string ?? "",
            reservationRate : json["reservation_rate"].double ?? 0.0,
            userRate        : json["user_rating"].double ?? 0.0,
            date            : json["date"].string ?? "1970-01-01",
            id              : json["id"].string ?? ""
        )
    }
    
    static func build(jsonList: [JSON]) -> [Movie] {
        var movieList = [Movie]()
        
        for json in jsonList {
            movieList.append(build(json: json))
        }
        
        return movieList
    }
    
    static func build(jsonList: JSON) -> [Movie] {
        if let jsonList = jsonList["movies"].array {
            return build(jsonList: jsonList)
        } else {
            return [Movie]()
        }
    }
}
