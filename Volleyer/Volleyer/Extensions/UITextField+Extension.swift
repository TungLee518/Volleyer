//
//  UITextField+Extension.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/19.
//

import UIKit

extension UITextField {
    func regularTextField(placeHolder: String) {
        placeholder = placeHolder
        translatesAutoresizingMaskIntoConstraints = false
        font = .regularNunito(size: 16)
        textColor = .gray2
        textAlignment = .left
        contentVerticalAlignment = .top
        borderStyle = .roundedRect
        autocapitalizationType = .none
    }
}
