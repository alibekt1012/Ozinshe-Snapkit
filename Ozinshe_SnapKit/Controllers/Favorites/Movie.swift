//
//  Movie.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 15.11.2023.
//

import Foundation
import SwiftyJSON

struct Movie {
    var id = 0
    var movieType = ""
    var name = ""
    var keyWord = ""
    var description = ""
    var year = 0
    var trend = false
    var timing = 0
    var director = ""
    var producer = ""
    var poster_link = ""
    var video_link = ""
    var watchCount = 0
    var seasonCount = 0
    var seriesCount = 0
    var createdDate = ""
    var lastModifiedDate = ""
    //var categories: [Category] = []
    //var genres: [Genre] = []
    var favorite = false
    //var screenshots: [Screenshot] = []
    
    init() {
        
    }
    
    init(json: JSON) {
        if let temp = json["id"].int {
            id = temp
        }
        if let temp = json["movieType"].string {
            movieType = temp
        }
        if let temp = json["name"].string {
            name = temp
        }
        if let temp = json["keyWord"].string {
            keyWord = temp
        }
        if let temp = json["description"].string {
            description = temp
        }
        if let temp = json["year"].int {
            year = temp
        }
        if let temp = json["trend"].bool {
            trend = temp
        }
        if let temp = json["timing"].int {
            timing = temp
        }
        if let temp = json["director"].string {
            director = temp
        }
        if let temp = json["producer"].string {
            producer = temp
        }
        if json["poster"].exists() {
            if let temp = json["poster"]["link"].string {
                poster_link = temp
            }
        }
        if json["video"].exists() {
            if let temp = json["video"]["link"].string {
                video_link = temp
            }
        }
        if let temp = json["watchCount"].int {
            watchCount = temp
        }
        if let temp = json["seasonCount"].int {
            seasonCount = temp
        }
        if let temp = json["seriesCount"].int {
            seriesCount = temp
        }
        if let temp = json["createdDate"].string {
            createdDate = temp
        }
        if let temp = json["lastModifiedDate"].string {
            lastModifiedDate = temp
        }
//        if let array = json["categories"].array {
//            for item in array {
//                let temp = Category(json: item)
//                categories.append(temp)
//            }
//        }
//        if let array = json["genres"].array {
//            for item in array {
//                let temp = Genre(json: item)
//                genres.append(temp)
//            }
//        }
        if let temp = json["favorite"].bool {
            favorite = temp
        }
//
//        if let array = json["screenshots"].array {
//            for item in array {
//                let temp = Screenshot(json: item)
//                screenshots.append(temp)
//            }
//        }
        
    }
}


