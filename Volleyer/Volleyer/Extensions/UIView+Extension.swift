//
//  UIView+Extension.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/6.
//

import Foundation
import UIKit

extension UIView {
    func applyShadow() {
        layer.cornerRadius = 10
        layer.borderColor = UIColor.gray3.cgColor
        layer.borderWidth = 2
//        layer.masksToBounds = false
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.gray2.cgColor
    }
}
