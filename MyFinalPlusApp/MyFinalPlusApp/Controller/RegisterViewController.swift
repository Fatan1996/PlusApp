//
//  RegisterViewController.swift
//  MyFinalPlusApp
//
//  Created by Faten Abdullh salem on 20/05/1443 AH.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {
    
let imagePickerController = UIImagePickerController()
var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
//    userImageView.layer.borderColor = UIColor.systemGreen.cgColor
//    userImageView.layer.borderWidth = 3.0
      userImageView.layer.cornerRadius = userImageView.bounds.height / 2
      userImageView.layer.masksToBounds = true
      userImageView.isUserInteractionEnabled = true
       let tabGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        userImageView.addGestureRecognizer(tabGesture)
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var eyePassword: UIButton!
    
    
    @IBOutlet weak var eyeConPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    imagePickerController.delegate = self
        
        
        passwordTextField.rightView = eyePassword
        passwordTextField.rightViewMode = .whileEditing
        
        confirmPasswordTextField.rightView = eyeConPassword
        confirmPasswordTextField.rightViewMode = .whileEditing
    }
    
    @IBAction func eyePas(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
               if passwordTextField.isSecureTextEntry {
                   if let image = UIImage(systemName: "eye.fill") {
                       sender.setImage(image, for: .normal)
                   }
               } else {
                   if let image = UIImage(systemName: "eye.slash.fill"){
                       sender.setImage(image, for: .normal)
                   }
               }
           }
           
           @IBAction func changePasswordVisibility(_ sender: UIButton) {
               confirmPasswordTextField.isSecureTextEntry.toggle()
               if confirmPasswordTextField.isSecureTextEntry {
                   if let image = UIImage(systemName: "eye.fill") {
                       sender.setImage(image, for: .normal)
                   }
               } else {
                   if let image = UIImage(systemName: "eye.slash.fill"){
                       sender.setImage(image, for: .normal)
                   }
               }
           }
    
    
    @IBAction func handleRegister(_ sender: Any) {
        if let image = userImageView.image,
           let imageData = image.jpegData(compressionQuality: 0.75),
           let name = nameTextField.text,
           let email = emailTextField.text,
           let phoneNumber = phoneNumberTextField.text,
           let password = passwordTextField.text,
           let confirmPassword = confirmPasswordTextField.text,
           password == confirmPassword {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
        
                                       Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
                                    Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                                      
                                   
                    print("Registration Auth Error",error.localizedDescription)
                }
                if let authResult = authResult {
                    let storageRef = Storage.storage().reference(withPath: "users/\(authResult.user.uid)")
                    let uploadMeta = StorageMetadata.init()
                    uploadMeta.contentType = "image/jpeg"
                    storageRef.putData(imageData, metadata: uploadMeta) { storageMeta, error in
                        if let error = error {
                         
                                               Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
                                            Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                                          
                                           
                            print("Registration Storage Error",error.localizedDescription)
                        }
                        storageRef.downloadURL { url, error in
                            if let error = error {
                                print("Registration Storage Download Url Error",error.localizedDescription)
                            }
                            if let url = url {
                                print("URL",url.absoluteString)
                                let db = Firestore.firestore()
                                let userData: [String:String] = [
                                    "id":authResult.user.uid,
                                    "name":name,
                                    "email":email,
                                    "imageUrl":url.absoluteString,
                                    "phoneNumber":phoneNumber,
                                ]
                                db.collection("users").document(authResult.user.uid).setData(userData) { error in
                                    if let error = error {
                                        print("Registration Database error",error.localizedDescription)
                                    }else {
                                        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController {
                                            vc.modalPresentationStyle = .fullScreen
                                            Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                                            self.present(vc, animated: true, completion: nil)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    @IBOutlet weak var NameLabel: UILabel! {
        didSet {
        NameLabel.text = "Name".localized
        }
    }
    @IBOutlet weak var EmailLabel: UILabel! {
        didSet {
            EmailLabel.text = "Email".localized
        }
    }
    @IBOutlet weak var PasswordLabel: UILabel! {
        didSet {
        PasswordLabel.text = "Password".localized
        }
    }
    @IBOutlet weak var PasswordComfirmLabel:
    UILabel! {
        didSet {
        PasswordComfirmLabel.text = "PasswordComfirm".localized
        }
    }
    @IBOutlet weak var PhoneNumberLabel: UILabel! {
        didSet {
            PhoneNumberLabel.text = "PhoneNumber".localized
        }
    }
    
    @IBOutlet weak var RegisterButton: UIButton!{
        didSet {
            RegisterButton.setTitle("Register".localized, for: .normal)
        }
    }
    
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @objc func selectImage() {
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "choose Profile Picture", message: "where do you want to pick your image from?", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { Action in
            self.getImage(from: .camera)
        }
        let galaryAction = UIAlertAction(title: "Photo library", style: .default) { Action in
            self.getImage(from: .photoLibrary)
        }
        let dismissAction = UIAlertAction(title: "Cancle", style: .destructive) { Action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cameraAction)
        alert.addAction(galaryAction)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    func getImage( from sourceType: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return}
        userImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

