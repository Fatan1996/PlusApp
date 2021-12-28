//
//  Food.swift
//  MyFinalPlusApp
//
//  Created by Faten Abdullh salem on 23/05/1443 AH.
//

import UIKit
import Firebase
struct Food {
    var id = ""
    var user:User
    var title = ""
    var description = ""
    var price:String
    var imageUrl = ""
    var createdAt:Timestamp?

    init(dict:[String:Any],id:String,user:User) {
        if let title = dict["title"] as? String,
           let description = dict["description"] as? String,
            let price = dict["price"] as? String,
            let imageUrl = dict["imageUrl"] as? String,
            let createdAt = dict["createdAt"] as? Timestamp {
            
            self.title = title
            self.description = description
            self.price = price
            self.imageUrl = imageUrl
            self.createdAt = createdAt
        }
             self.id = id
             self.user = user
    }

}
