//
//  Profile.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 10.11.2023.
//

import Foundation
import SwiftyJSON

struct Profile {
    
    var id = 0
    var user_email = "qwe"
    var name = ""
    var phoneNumber = ""
    var birthDate = ""
    var language = ""
    
    init() {
        
    }

    init(json: JSON) {
        if let temp = json["id"].int {
            id = temp
        }
        
        if json["user"].exists() {
            if let temp = json["user"]["email"].string {
                user_email = temp
            }
        }
        if let temp = json["name"].string {
            name = temp
        }
        if let temp = json["phoneNumber"].string {
            phoneNumber = temp
        }
        if let temp = json["birthDate"].string {
            birthDate = temp
        }
        if let temp = json["language"].string {
            language = temp
        }
    }

    
}
