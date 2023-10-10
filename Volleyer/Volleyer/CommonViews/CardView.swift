//
//  CardView.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/7.
//

import Foundation
import UIKit

class CardView: UIView {
    let thisImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "kick")
        imageView.tintColor = .gray5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let thisLable: UILabel = {
        let label = UILabel()
        label.text = MyPageEnum.requestIReceive.rawValue
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var thisCardLabel: String? {
        didSet {
            thisLable.text = thisCardLabel
        }
    }
    var thisCardImage: String? {
        didSet {
            setLayout()
        }
    }
    func setLayout() {
        addSubview(thisImageView)
        addSubview(thisLable)
        thisImageView.image = UIImage(named: thisCardImage ?? "volleyball")
        thisImageView.translatesAutoresizingMaskIntoConstraints = false
        thisLable.translatesAutoresizingMaskIntoConstraints = false
//        self.layer.cornerRadius = 10
//        self.layer.borderColor = UIColor.gray4.cgColor
//        self.layer.borderWidth = 1
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.2),
            thisImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            thisImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin*1.5),
            thisImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin*1.5),
            thisImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin*1.5),
            thisImageView.widthAnchor.constraint(equalTo: thisImageView.heightAnchor, multiplier: 1),
            thisLable.topAnchor.constraint(equalTo: thisImageView.bottomAnchor, constant: standardMargin/2),
            thisLable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin/3),
            thisLable.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
