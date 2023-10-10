//
//  CompetitionTableViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/18.
//

import Foundation
import UIKit

class CompetitionTableViewCell: UITableViewCell {

    static let identifier = "CompetitionTableViewCell"

    var titleLable: UILabel = {
        let label = UILabel()
        label.text = "No title"
        label.textColor = .gray2
        label.font = .semiboldNunito(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var dateLable: UILabel = {
        let label = UILabel()
        label.text = "No date"
        label.textColor = .gray3
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var countyLable: UILabel = {
        let label = UILabel()
        label.text = "No county"
        label.textColor = .gray3
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var enrollingLabel: UILabel = {
        let label = UILabel()
        label.text = "  報名中  "
        label.textColor = .purple1
        label.backgroundColor = .purple6
        label.layer.cornerRadius = 7
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.isHidden = true
        return label
    }()
    var isEnrolling: Bool? {
        didSet {
            if let isEnrolling {
                if isEnrolling {
                    enrollingLabel.isHidden = false
                    yAnchor.isActive = true
//                    setAnimate()
                }
            }
        }
    }
    var down = true
    lazy var yAnchor = self.enrollingLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: standardMargin)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLable)
        contentView.addSubview(dateLable)
        contentView.addSubview(countyLable)
        contentView.addSubview(enrollingLabel)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setAnimate() {
//        yAnchor.isActive = true
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) { [self] in
        yAnchor.isActive = false
        if self.down {
            yAnchor = self.enrollingLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: standardMargin + 5)
        } else {
            yAnchor = self.enrollingLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: standardMargin)
        }
        yAnchor.isActive = true
        UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 0.3, initialSpringVelocity: 9, options: .curveEaseIn) {
            self.enrollingLabel.layoutIfNeeded()
        } completion: { _ in
            self.down = !self.down
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.setAnimate()
            }
        }
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            titleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            titleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin),

            enrollingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),
            enrollingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin),

            countyLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            countyLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: standardMargin),

            dateLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),
            dateLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin),
            dateLable.centerYAnchor.constraint(equalTo: countyLable.centerYAnchor)
        ])
    }

    @objc func addData() {
    }
}
