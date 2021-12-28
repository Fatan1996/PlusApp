//
//  ResturantViewController.swift
//  MyFinalPlusApp
//
//  Created by Faten Abdullh salem on 24/05/1443 AH.
//
import UIKit
struct Restaurants {
var restaurantImage:UIImage
var restaurantName:String
var DeliveryTime:String
var DeliveryPrice:String
var Evaluation:String
var Tracking:String
var ImageLogo:UIImage
}

class ResturantViewController: UIViewController {
    var arrayRT:[Restaurants] = []
    var sendResturantImage = UIImage(named: "PH")
    var sendResturantName = ""
    var sendDeliveryTime = ""
    var sendDeliveryPrice = ""
    var sendEvaluation = ""
    var sendTracking = ""
    var sendImageLogo = UIImage(named: "imageLogo")
    
var R1 = Restaurants(restaurantImage: UIImage(named: "PH")!, restaurantName: "PizzaHut", DeliveryTime: "20-40", DeliveryPrice: "10", Evaluation: "3.5", Tracking: "Tracking", ImageLogo: UIImage(named: "imageLogo")!)

@IBOutlet weak var ResturantTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    


        
    }
    

}
