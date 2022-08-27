//
//  RegisterViewController.swift
//  WatchListPro
//
//  Created by Alexander Khazzam on 7/14/22.
//

import UIKit

import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailAddressView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailAddressView.setRoundedBorders()
        passwordView.setRoundedBorders()
        confirmPasswordView.setRoundedBorders()
    }
    
    @IBAction func createAccountBtnPressed(_ sender: UIButton) {
        if let safePassword = passwordTextField.text,
            let safeConfirmPassword = confirmPasswordTextField.text,
            let safeEmail = emailAddressTextField.text {
            if safePassword == safeConfirmPassword {
                Auth.auth().createUser(withEmail: safeEmail, password: safePassword) { _, error in
                    if let safeError = error {
                        let alert = UIAlert(title: "Error", message: safeError.localizedDescription, actionTitle: "Try Again").createAlert()
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        self.performSegue(withIdentifier: K.Segues.registerToHome, sender: self)
                    }
                }
            } else {
                presentAlert(message: "Passwords must match.")
            }
        } else {
           presentAlert(message: "All fields are required.")
        }
    }
    
    func presentAlert(message: String) {
        let alert = UIAlert(title: "Error", message: message, actionTitle: "Try Again").createAlert()
        clearPasswordTextFields()
        self.present(alert, animated: true, completion: nil)
    }

    func clearPasswordTextFields() {
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
    }
}
