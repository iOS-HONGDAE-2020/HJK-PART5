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

struct Comment {
    let movieId     : String
    let id          : String
    let rating      : Double
    let date        : Date
    let writer      : String
    let contents    : String
    
    init(movieId: String, id: String, rating: Double, timestamp: Double, writer: String, contents: String) {
        self.movieId    = movieId
        self.id         = id
        self.rating     = rating
        self.date       = Date(timeIntervalSince1970: timestamp)
        self.writer     = writer
        self.contents   = contents
    }
    
    static func build(json: JSON) -> Comment {
        return Comment(
            movieId: json["movie_id"].string ?? "",
            id: json["id"].string ?? "",
            rating: json["rating"].double ?? 0,
            timestamp: json["timestamp"].double ?? 0,
            writer: json["writer"].string ?? "",
            contents: json["contents"].string ?? ""
        )
    }
    
    static func build(jsonList: [JSON]) -> [Comment] {
        var commentList = [Comment]()
        
        for json in jsonList {
            commentList.append(build(json: json))
        }
        
        return commentList
    }
    
    static func build(jsonList: JSON) -> [Comment] {
        if let jsonList = jsonList["comments"].array {
            return build(jsonList: jsonList)
        } else {
            return [Comment]()
        }
    }
}

struct MovieDetail {
    let id                  : String
    let title               : String
    let audience            : Int
    let grade               : Int
    let actor               : String
    let duration            : Int
    let reservationGrade    : Int
    let reservationRate     : Double
    let userRating          : Double
    let date                : Date
    let director            : String
    let imageURL            : URL
    let synopsis            : String
    let genre               : String
    
    init(id: String, title: String, audience: Int, grade: Int, actor: String, duration: Int, reservationGrade: Int, reservationRate: Double, userRating: Double, date: String, director: String, image: String, synopsis: String, genre: String) {
        self.id                 = id
        self.title              = title
        self.audience           = audience
        self.grade              = grade
        self.actor              = actor
        self.duration           = duration
        self.reservationGrade   = reservationGrade
        self.reservationRate    = reservationRate
        self.userRating         = userRating
        self.date               = formatter.date(from: date) ?? Date()
        self.director           = director
        self.imageURL           = URL(string: image) ?? URL(string: "")!
        self.synopsis           = synopsis
        self.genre              = genre
    }
    
    static func build(json: JSON) -> MovieDetail {
        return MovieDetail(
            id                  : json["id"].string ?? "",
            title               : json["title"].string ?? "",
            audience            : json["audience"].int ?? 0,
            grade               : json["grade"].int ?? 0,
            actor               : json["actor"].string ?? "",
            duration            : json["duration"].int ?? 0,
            reservationGrade    : json["reservation_grade"].int ?? 0,
            reservationRate     : json["reservation_rate"].double ?? 0.0,
            userRating          : json["user_rating"].double ?? 0.0,
            date                : json["date"].string ?? "1970-01-01",
            director            : json["director"].string ?? "",
            image               : json["image"].string ?? "",
            synopsis            : json["synopsis"].string ?? "",
            genre               : json["genre"].string ?? ""
        )
    }
}


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
