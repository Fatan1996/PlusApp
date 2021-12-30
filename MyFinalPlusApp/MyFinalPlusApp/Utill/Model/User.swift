//
//  User.swift
//  MyFinalPlusApp
//
//  Created by Faten Abdullh salem on 23/05/1443 AH.
//

import UIKit

struct User {
    var id = ""
    var name = ""
    var email = ""
    var phoneNumber = ""
    var imageUrl = ""
    
    init(dict:[String:Any]) {
        print("USER",dict)
        if let id = dict["id"] as? String,
           let name = dict["name"] as? String,
           let email = dict["email"] as? String,
           let phoneNumber = dict["phoneNumber"] as? String,
           let imageUrl = dict["imageUrl"] as? String {
            self.id = id
            self.name = name
            self.email = email
            self.phoneNumber = phoneNumber
            self.imageUrl = imageUrl
        }
    }
}
