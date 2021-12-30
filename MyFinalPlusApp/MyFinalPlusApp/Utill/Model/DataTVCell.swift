//
//  DataTVCell.swift
//  MyFinalPlusApp
//
//  Created by Faten Abdullh salem on 24/05/1443 AH.
//

import UIKit
import Firebase
class DataTVCell: UITableViewCell {
@IBOutlet weak var restaurantNameLabel: UILabel!
@IBOutlet weak var DeliveryTimeLabel: UILabel!
@IBOutlet weak var DeliveryPriceLabel: UILabel!
@IBOutlet weak var TitleLabel: UILabel!
@IBOutlet weak var DescriptionLabel: UILabel!
@IBOutlet weak var PriceLabel: UILabel!
@IBOutlet weak var MealImageView: UIImageView!



  override func awakeFromNib() {
    super.awakeFromNib()
}
override func setSelected(_ selected: Bool, animated:Bool) {
    
   // Configure the view for the selected state
}
    func configure(with post:Post ) -> UITableViewCell {
        MealImageView.loadImageUsingCache(with: post.imageUrl)
        restaurantNameLabel.text = post.restaurantName
        DeliveryTimeLabel.text = post.DeliveryTime
        DeliveryPriceLabel.text = post.DeliveryPrice
        TitleLabel.text = post.title
        DescriptionLabel.text = post.description
        PriceLabel.text = post.price
        return self
    }
    override func prepareForReuse() {
        
        MealImageView.image = nil
    }
}
