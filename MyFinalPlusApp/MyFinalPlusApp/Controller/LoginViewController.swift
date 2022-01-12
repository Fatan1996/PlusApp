//
//  LoginViewController.swift
//  MyFinalPlusApp
//
//  Created by Faten Abdullh salem on 20/05/1443 AH.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {
    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var emailTextField:
       UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleLogin(_ sender: Any) {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
                                Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                                 //  print("Registration Storage Error",error.localizedDescription)
                }
                if let _ = authResult {
                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController {
                        vc.modalPresentationStyle = .fullScreen
                        Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
        }
    }
//}
    
    @IBOutlet weak var EmailLabel: UILabel!{
        didSet {
            EmailLabel.text = "Email".localized
        }
        
    }

    
    @IBOutlet weak var PasswordLabel: UILabel!{
        didSet {
            PasswordLabel.text = "Password".localized
        }
    }
    @IBOutlet weak var LoginButton: UIButton!{
        didSet {
            LoginButton.setTitle("Sign in".localized, for: .normal)
        }
    }
    
    @IBAction func changePasswordVisibility(_ sender: AnyObject) {
    passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry {
            if let image = UIImage(systemName: "eye.fill") {
                sender.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(systemName: "eye.slash.fill") {
                sender.setImage(image, for: .normal)
            }
        }
    }
    
    
}

    


