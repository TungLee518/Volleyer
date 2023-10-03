//
//  UIImage+Extension.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/26.
//

import Foundation

import UIKit

// swiftlint:disable identifier_name
enum ImageAsset: String {

    // Tab Bar
    case ball
    case ball_selected
    case profile
    case profile_selected
    case score
    case score_selected
    case spike
    case spike_selected

}
// swiftlint:enable identifier_name

extension UIImage {
    static func asset(_ asset: ImageAsset) -> UIImage? {
        return UIImage(named: asset.rawValue)
    }
}
