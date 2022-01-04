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
    
    //commint
    
    @IBOutlet weak var ResLabel: UILabel!{
        didSet {
            ResLabel.text = "RestaurantName".localized
        }
    }
    
    
    
@IBOutlet weak var MealTypeLabel: UILabel!{
        didSet {
            MealTypeLabel.text = "MealType".localized
            
        }
    }
    
    @IBOutlet weak var DescriptioonLabel: UILabel!{
        didSet {
        DescriptioonLabel.text = "Description".localized
        }
    }
    
    @IBOutlet weak var PriceMealLabel: UILabel!{
        didSet {
            PriceMealLabel.text = "Price".localized
        }
    }
    
    @IBOutlet weak var DeliveryTLabel: UILabel!{
        didSet {
        DeliveryTLabel.text = "DeliveryTime".localized
        }
    }
    
    @IBOutlet weak var DeliveryPLabel: UILabel!{
        didSet {
            DeliveryPLabel.text = "DeliveryPrice".localized
        }
    }
    
    @IBOutlet weak var EvaluationLabel: UILabel!{
        didSet {
            EvaluationLabel.text = "Evaluation".localized
        }
    }
    
    



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
