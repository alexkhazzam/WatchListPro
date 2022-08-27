//
//  HomeViewController.swift
//  WatchListPro
//
//  Created by Alexander Khazzam on 7/14/22.
//

import UIKit

import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        if let safeEmail = Auth.auth().currentUser?.email {
            welcomeLabel.text = safeEmail
        }
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }

}
 
