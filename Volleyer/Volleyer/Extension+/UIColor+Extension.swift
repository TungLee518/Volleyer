//
//  UIColor+Extension.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/26.
//

import Foundation
import UIKit

private enum STColor: String {
    // swiftlint:disable identifier_name
    case B1
    case B2
    case B3
    case B4
    case B5
    case B6
    case G1
    // swiftlint:enable identifier_name
}

extension UIColor {

    // swiftlint:disable identifier_name
    static let purple1 = hexStringToUIColor(hex: "#491A85")
    static let purple2 = hexStringToUIColor(hex: "#62339F")
    static let purple3 = hexStringToUIColor(hex: "#7340AE")
    static let purple4 = hexStringToUIColor(hex: "#A16EDD")
    static let purple5 = hexStringToUIColor(hex: "#D8BAFC")
    static let purple6 = hexStringToUIColor(hex: "#E8D8FD")
    static let purple7 = hexStringToUIColor(hex: "#FAF5FF")
    static let gray1 = hexStringToUIColor(hex: "#111011")
    static let gray2 = hexStringToUIColor(hex: "#706E74")
    static let gray3 = hexStringToUIColor(hex: "#A59FAD")
    static let gray4 = hexStringToUIColor(hex: "#D0CCD4")
    static let gray5 = hexStringToUIColor(hex: "#DFDCE2")
    static let gray6 = hexStringToUIColor(hex: "#ECE9EF")
    static let gray7 = hexStringToUIColor(hex: "#F8F6F9")
    // swiftlint:enable identifier_name
    
    private static func STColor(_ color: STColor) -> UIColor? {
        return UIColor(named: color.rawValue)
    }

    static func hexStringToUIColor(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            return .gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
