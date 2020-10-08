//
//  MovieData.swift
//  TheMovie
//
//  Created by 김호종 on 2020/10/05.
//  Copyright © 2020 김호종. All rights reserved.
//

import Foundation

class MovieData {
    static let shared = MovieData()
    
    private var sortOption: SortOption  = .rate
    var movieList                       = [Movie]()
    var movieReloadHandler: (()->Void)?
    var titleHandler: ((String)->Void)?
    
    var sortOpt: SortOption {
        get {
            return sortOption
        }
        
        set(value) {
            sortOption = value
            movieList.sort(by: { one, other in
                switch value {
                case .rate:
                    return one.reservationRate > other.reservationRate
                case .curation:
                    return one.userRate > other.userRate
                case .date:
                    return one.date < other.date
                }
            })
            
            titleHandler?(value.rawValue)
            movieReloadHandler?()
        }
    }
    
    func set(completion: (()->Void)? = nil) {
        formatter.dateFormat = "yyyy-MM-dd"
        APIManager.getMovies(order: .reservationRate, completion: {
            result in
            self.movieList = result
            self.sortOpt = .date
            completion?()
        })
    }
    
    
    enum SortOption: String {
        case rate       = "예매율순"
        case curation   = "큐레이션"
        case date       = "개봉일순"
    }
}
