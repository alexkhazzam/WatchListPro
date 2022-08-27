//
//  UIViewExtension.swift
//  WatchListPro
//
//  Created by Alexander Khazzam on 7/14/22.
//

import UIKit

extension UIView {
    func setRoundedBorders() {
        return self.layer.cornerRadius = self.frame.size.height / 5
    }
}
