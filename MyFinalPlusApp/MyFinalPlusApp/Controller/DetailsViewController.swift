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
 
    @IBOutlet weak var TitleLabel: UILabel!{
        didSet {
            TitleLabel.text = "MealType".localized
        }
    }
    
    @IBOutlet weak var DescriptionLabel: UILabel!{
        didSet {
            DescriptionLabel.text = "Description".localized
        }
    }
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
@IBOutlet weak var PriceLabel: UILabel!{
        didSet {
            PriceLabel.text = "Price".localized
        }
    }
@IBOutlet weak var DeliveryPLabel: UILabel!{
        didSet {
            DeliveryPLabel.text = "DeliveryPrice".localized
        }
    }
    
    @IBOutlet weak var DeliveryTLabel: UILabel!{
        didSet {
            DeliveryTLabel.text = "DeliveryTime".localized
        }
    }
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
    

    @IBOutlet weak var PayingLabel: UILabel!{
        didSet {
        PayingLabel.text = "Paying off".localized
        }
    }
    @IBOutlet weak var CreditcardLabel: UILabel!{
        didSet {
            CreditcardLabel.text = "Creditcard".localized
        }
    }
    @IBOutlet weak var uponreciptLabel: UILabel!{
        didSet {
            uponreciptLabel.text = "Uponreceipt".localized
        }
    }
    @IBOutlet weak var cmmunicationLabel: UILabel!{
        didSet {
            cmmunicationLabel.text = "Communicate with the delegate".localized
        }
    }
    
    
    @IBOutlet weak var BuyButton: UIButton!{
        didSet {
            BuyButton.setTitle("Buy".localized, for: .normal)
        }
    }
    
    
    
}
