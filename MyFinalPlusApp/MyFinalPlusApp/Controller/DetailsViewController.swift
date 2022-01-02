//
//  DetailsViewController.swift
//  MyFinalPlusApp
//
//  Created by Faten Abdullh salem on 23/05/1443 AH.
//

import UIKit

class DetailsViewController: UIViewController {
    var selectedFood:Post?
    var selectedPostImage:UIImage?
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var postPriceLabel: UILabel!
    @IBOutlet weak var DeliveryTimeLabel: UILabel!
    @IBOutlet weak var DeliveryPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedFood = selectedFood,
           let selectedImage = selectedPostImage{
            postImageView.image = selectedImage
            postTitleLabel.text = selectedFood.title
            postDescriptionLabel.text = selectedFood.description
            postPriceLabel.text = selectedFood.price
            DeliveryTimeLabel.text = selectedFood.DeliveryTime
            DeliveryPriceLabel.text = selectedFood.DeliveryPrice
            
        }
    
    }
    

    

}
