//
//  UIImageView+Extension.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/5.
//

import Foundation
import UIKit

public typealias SimpleClosure = (() -> ())
private var tappableKey : UInt8 = 0
private var actionKey : UInt8 = 1

extension UIImageView {

    @objc var callback: SimpleClosure {
        get {
            // swiftlint:disable force_cast
            return objc_getAssociatedObject(self, &actionKey) as! SimpleClosure
            // swiftlint:enable force_cast
        }
        set {
            objc_setAssociatedObject(self, &actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var gesture: UITapGestureRecognizer {
        get {
            return UITapGestureRecognizer(target: self, action: #selector(tapped))
        }
    }

    var tappable: Bool! {
        get {
            return objc_getAssociatedObject(self, &tappableKey) as? Bool
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tappableKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            self.addTapGesture()
        }
    }

    fileprivate func addTapGesture() {
        if (self.tappable) {
            self.gesture.numberOfTapsRequired = 1
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(gesture)
        }
    }

    @objc private func tapped() {
        callback()
    }
}
