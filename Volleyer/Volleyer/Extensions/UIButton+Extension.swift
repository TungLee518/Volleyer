//
//  UIButton+Extension.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/19.
//

import UIKit

extension UIButton {
    func purpleButton() {
        titleLabel?.font =  .semiboldNunito(size: 16)
        titleLabel?.textAlignment = .center
        backgroundColor = .purple2
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    func whiteButton() {
        titleLabel?.font =  .regularNunito(size: 16)
        titleLabel?.textAlignment = .center
        backgroundColor = .clear
        setTitleColor(.purple1, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.purple1.cgColor
        clipsToBounds = true
    }
}
