//
//  UILabel+Extension.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/19.
//

import UIKit

extension UILabel {
    func regularSmallLabel() {
        textColor = .gray2
        font = .regularNunito(size: 16)
        translatesAutoresizingMaskIntoConstraints = false
    }
    func regularMediumLabel() {
        textColor = .gray2
        font = .regularNunito(size: 20)
        translatesAutoresizingMaskIntoConstraints = false
    }
    func regularLargeLabel() {
        textColor = .gray2
        font = .regularNunito(size: 24)
        translatesAutoresizingMaskIntoConstraints = false
    }
    func semiboldSmallLabel() {
        textColor = .gray2
        font = .semiboldNunito(size: 16)
        translatesAutoresizingMaskIntoConstraints = false
    }
    func semiboldMediumLabel() {
        textColor = .gray2
        font = .semiboldNunito(size: 20)
        translatesAutoresizingMaskIntoConstraints = false
    }
    func semiboldLargeLabel() {
        textColor = .gray1
        font = .semiboldNunito(size: 30)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
