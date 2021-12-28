//
//  DataTVCell.swift
//  MyFinalPlusApp
//
//  Created by Faten Abdullh salem on 24/05/1443 AH.
//

import UIKit

class DataTVCell: UITableViewCell {
    
    @IBOutlet weak var RestaurantImageView:
    UIImageView!
    @IBOutlet weak var ImageViewLogo: UIImageView!
    @IBOutlet weak var RestaurantNameLabel: UILabel!
    @IBOutlet weak var EvaluationLabel: UILabel!
    @IBOutlet weak var DeliveryTimeLabel: UILabel!
    @IBOutlet weak var DeliveryPriceLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
