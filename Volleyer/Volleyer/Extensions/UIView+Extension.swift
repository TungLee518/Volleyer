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
        layer.cornerRadius = 20
        layer.borderColor = UIColor.gray4.cgColor
        layer.borderWidth = 0.7
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowRadius = 1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.4
        layer.shadowColor = UIColor.gray1.cgColor
    }
}
