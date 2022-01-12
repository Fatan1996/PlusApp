//
//  LandingViewController.swift
//  MyFinalPlusApp
//
//  Created by Faten Abdullh salem on 20/05/1443 AH.
//

import UIKit

class LandingViewController: UIViewController {
@IBOutlet weak var WelcomeLabel: UILabel! {
    didSet {
        WelcomeLabel.text = "WelcomeTo THE PLUS APP".localized
    }
}
@IBOutlet weak var RegisterButton: UIButton!{
    didSet {
        RegisterButton.setTitle("Register".localized, for: .normal)
    }
}
@IBOutlet weak var LoginButton: UIButton!{
    didSet {
        LoginButton.setTitle("Sign in".localized, for: .normal)
    }
}
    

    @IBOutlet weak var languageSegmentControl: UISegmentedControl!{
       didSet {

            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch lang {
                case "ar":
                    languageSegmentControl.selectedSegmentIndex = 0
                    UIView.appearance().semanticContentAttribute = .forceRightToLeft
                case "en":
                    languageSegmentControl.selectedSegmentIndex = 1
                    UIView.appearance().semanticContentAttribute = .forceLeftToRight
                default:
                    let localLang =  Locale.current.languageCode
                     if localLang == "ar" {
                         languageSegmentControl.selectedSegmentIndex = 0
                     }else {
                         languageSegmentControl.selectedSegmentIndex = 1
                     }
                }
            }else {
                let localLang =  Locale.current.languageCode
                 if localLang == "ar" {
                     languageSegmentControl.selectedSegmentIndex = 0
                 }else {
                     languageSegmentControl.selectedSegmentIndex = 1
                 }
            }
        }
    }
            
override func viewDidLoad() {
        super.viewDidLoad()

}
    @IBAction func languageChanged(_ sender: UISegmentedControl) {
        if let lang = sender.titleForSegment(at:sender.selectedSegmentIndex)?.lowercased() {
            UserDefaults.standard.set(lang, forKey: "currentLanguage")
            Bundle.setLanguage(lang)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
                print(lang)
            }
        }
    }}
extension String {
var localized: String {
    return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
}
}
