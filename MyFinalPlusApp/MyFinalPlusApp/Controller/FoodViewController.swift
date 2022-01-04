//
//  FoodViewController.swift
//  MyFinalPlusApp
//
//  Created by Faten Abdullh salem on 23/05/1443 AH.
//

import UIKit
import Firebase

class FoodViewController: UIViewController {
    var selectedFood:Post?
    var selectedPostImage:UIImage?
    
    @IBOutlet weak var foodImageView: UIImageView! {
        didSet {
        foodImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        foodImageView.addGestureRecognizer(tapGesture)
        }
    }
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var foodPriceTextField: UITextField!
    @IBOutlet weak var foodTitleTextField: UITextField!
    @IBOutlet weak var foodDescriptionTextField: UITextField!
    @IBOutlet weak var RestaurantNameTextField: UITextField!
    @IBOutlet weak var DeliveryTimeTextField: UITextField!
    @IBOutlet weak var DeliveryPriceTextField: UITextField!
    
    let activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedFood = selectedFood,
        let selectedPostImage = selectedPostImage{
        DeliveryPriceTextField.text = selectedFood.price
        DeliveryTimeTextField.text = selectedFood.DeliveryTime
        RestaurantNameTextField.text = selectedFood.restaurantName
        foodPriceTextField.text = selectedFood.price
        foodTitleTextField.text = selectedFood.title
        foodDescriptionTextField.text = selectedFood.description
        foodImageView.image = selectedPostImage
            
            actionButton.setTitle("Update Food".localized, for: .normal)
            let deleteBarButton = UIBarButtonItem(image: UIImage(systemName: "trash.fill"),style: .plain, target: self, action: #selector(handleDelete))
            self.navigationItem.rightBarButtonItem = deleteBarButton
        }else {
            actionButton.setTitle("Add Food".localized, for: .normal)
            self.navigationItem.rightBarButtonItem = nil
            
        }
    }
    @objc func handleDelete (_ sender: UIBarButtonItem) {
        let ref = Firestore.firestore().collection("posts")
        if let selectedFood = selectedFood {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            ref.document(selectedFood.id).delete { error in
                if let error = error {
                    print("Error in db delete",error)
                } else {
            // Create a reference to the file to delete
            let storageRef = Storage.storage().reference(withPath: "posts/\(selectedFood.user.id)/\(selectedFood.id)")
                    // Delete the file
                    storageRef.delete { error in
                        if let error = error {
                            print("Error in storage delete",error)
                        } else {
                            self.activityIndicator.startAnimating()
                            self.navigationController? .popViewController(animated: true)
                        }
                        }
                    
                }
                
        }
        }
    }
    
    
    @IBAction func handleActionTouch(_ sender: Any) {
        if let image = foodImageView.image,
           let imageData = image.jpegData(compressionQuality: 0.75),
           let price = foodPriceTextField.text,
           let title = foodTitleTextField.text,
           let restaurantName = RestaurantNameTextField.text,
           let deliveryTime = DeliveryTimeTextField.text,
           let deliveryPrice = DeliveryPriceTextField.text,
           let description = foodDescriptionTextField.text,
           let currentUser = Auth.auth().currentUser {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
   //         ref.addDocument(data:)
            var foodId = ""
            if let selectedFood = selectedFood {
                foodId = selectedFood.id
            }else {
                foodId = "\(Firebase.UUID())"
            }
            let storageRef = Storage.storage().reference(withPath: "posts/\(currentUser.uid)/\(foodId)")
            let updloadMeta = StorageMetadata.init()
            updloadMeta.contentType = "image/jpeg"
            storageRef.putData(imageData, metadata: updloadMeta) { storageMeta, error in
                if let error = error {
                    print("Upload error",error.localizedDescription)
                }
                storageRef.downloadURL { url, error in
                    var postData = [String:Any]()
                    if let url = url {
                        let db = Firestore.firestore()
                        let ref = db.collection("posts")
                        if let selectedFood = self.selectedFood {
                            postData = [
                                "userId":selectedFood.user.id,
                                "imageUrl":url.absoluteString,
                                "restaurantName":restaurantName,
                                "title":title,
                                "description":description,
                                "price":price,
                                "deliveryTime":deliveryTime,
                                "deliveryPrice":deliveryPrice,
                                "createdAt":selectedFood.createdAt ?? FieldValue.serverTimestamp(),
                                "updatedAt":FieldValue.serverTimestamp()
                        ]
                        }else {
                            postData = [
                                "userId":currentUser.uid,
                                "imageUrl":url.absoluteString,
                                "restaurantName":restaurantName,
                                "title":title,
                                "description":description,
                                "price":price,
                                "deliveryTime":deliveryTime,
                                "deliveryPrice":deliveryPrice,
                                "createdAt":FieldValue.serverTimestamp(),
                                "updatedAt":FieldValue.serverTimestamp()
                            ]
                        }
                        ref.document(foodId).setData(postData) { error in
                            if let error = error {
                                print("FireStore Error",error.localizedDescription)
                            }
                            Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
   }
    
    
    
    @IBOutlet weak var RestaurantNLabel: UILabel!{
        didSet {
            RestaurantNLabel.text = "RestaurantName".localized
        }
    }
    @IBOutlet weak var titleLabel: UILabel!{
        didSet {
            titleLabel.text = "MealType".localized
        }
    }
    @IBOutlet weak var DescriptionLabel: UILabel!{
        didSet {
            DescriptionLabel.text = "Description".localized
        }
    }
    @IBOutlet weak var PriceLabel: UILabel!{
        didSet {
            PriceLabel.text = "Price".localized
        }
    }
    @IBOutlet weak var DeliveryTTLabel: UILabel!{
        didSet {
            DeliveryTTLabel.text = "DeliveryTime".localized
        }
    }
    @IBOutlet weak var DeliveryPPLabel: UILabel!{
        didSet {
            DeliveryPPLabel.text = "DeliveryPrice".localized
        }
    }
    
    
    
    
    
    
    
    
    
    
}

extension FoodViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func chooseImage() {
        self.showAlert()
    }
    private func showAlert() {
        
        let alert = UIAlertController(title: "Choose Profile Picture", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //get image from source type
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        foodImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
