//
//  Post.swift
//  MyFinalPlusApp
//
//  Created by Faten Abdullh salem on 25/05/1443 AH.
//

import UIKit
import Firebase
struct Post {
    var id = ""
    var user:User
    var restaurantName = ""
    var DeliveryTime = ""
    var DeliveryPrice = ""
    var title = ""
    var description = ""
    var price = ""
    var imageUrl = ""
    var createdAt:Timestamp?

    init(dict:[String:Any],id:String,user:User) {
        print("POST",dict)
        if let title = dict["title"] as? String,
        let restaurantName = dict["restaurantName"] as? String,
        let DeliveryTime = dict["deliveryTime"] as? String,
        let DeliveryPrice = dict["deliveryPrice"] as? String,
        let description = dict["description"] as? String,
        let price = dict["price"] as? String,
        let imageUrl = dict["imageUrl"] as? String,
        let createdAt = dict["createdAt"] as? Timestamp{
            
            self.restaurantName = restaurantName
            self.DeliveryTime = DeliveryTime
            self.DeliveryPrice = DeliveryPrice
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

