//
//  LevelView.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/6.
//

import Foundation
import UIKit

class LevelView: UIView {
    let levelLabel: UILabel = {
        let label = UILabel()
//        label.textColor = .gray2
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let markLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray3
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var thisLevel: Int? {
        didSet {
            setLayout()
        }
    }
    func setLayout() {
        addSubview(levelLabel)
        addSubview(markLabel)
        markLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        if let thisLevel = thisLevel {
            levelLabel.text = levelList[thisLevel]
        }
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            levelLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            levelLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -standardMargin/3),
            markLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin/3),
            markLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
