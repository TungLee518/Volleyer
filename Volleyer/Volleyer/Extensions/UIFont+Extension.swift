//
//  UIFont+Extension.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/26.
//

import Foundation
import UIKit

private enum FontName: String {
    case regular = "Nunito-Regular"
    case semibold = "Nunito-SemiBold"
}

extension UIFont {

    static func medium(size: CGFloat) -> UIFont? {
        var descriptor = UIFontDescriptor(name: FontName.regular.rawValue, size: size)
        descriptor = descriptor.addingAttributes(
            [UIFontDescriptor.AttributeName.traits: [UIFontDescriptor.TraitKey.weight: UIFont.Weight.medium]]
        )
        return UIFont(descriptor: descriptor, size: size)
    }

    static func regularNunito(size: CGFloat) -> UIFont? {
        return UIFont(name: FontName.regular.rawValue, size: size)
    }
    static func semiboldNunito(size: CGFloat) -> UIFont? {
        return UIFont(name: FontName.semibold.rawValue, size: size)
    }
}
