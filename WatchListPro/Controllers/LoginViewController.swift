//
//  LoginViewController.swift
//  WatchListPro
//
//  Created by Alexander Khazzam on 7/14/22.
//

import UIKit

import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailAddressView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailAddressTextField.text = "alex722khazzam@gmail.com"
        passwordTextField.text = "woodpecker1"
        
        emailAddressView.setRoundedBorders()
        passwordView.setRoundedBorders()
    }
    
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        if let safeEmail = emailAddressTextField.text, let safePassword = passwordTextField.text {
            Auth.auth().signIn(withEmail: safeEmail, password: safePassword) { authResult, error in
                if let safeError = error {
                    self.presentAlert(message: safeError.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: K.Segues.loginToHome, sender: self)
                }
            }
        } else {
            presentAlert(message: "Passwords must match and all fields are required.")
        }
    }
    
    func presentAlert(message: String) {
        let alert = UIAlert(title: "Error", message: message, actionTitle: "Try Again").createAlert()
        clearPasswordTextFields()
        self.present(alert, animated: true, completion: nil)
    }
    
    func clearPasswordTextFields() {
        passwordTextField.text = ""
    }
    
}
