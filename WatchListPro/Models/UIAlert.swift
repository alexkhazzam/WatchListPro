//
//  UIAlert.swift
//  WatchListPro
//
//  Created by Alexander Khazzam on 8/6/22.
//

import UIKit

struct UIAlert {
    let title: String
    let message: String?
    let actionTitle: String
    
    func createAlert() -> UIAlertController {
        let dialogMessage = UIAlertController(title: title, message: message ?? "", preferredStyle: .alert)
        let closeBtn = UIAlertAction(title: actionTitle, style: .default)
        dialogMessage.addAction(closeBtn)
        return dialogMessage
    }
}
