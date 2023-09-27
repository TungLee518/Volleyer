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
        label.font = .semiboldNunito(size: 20)
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLable)
        contentView.addSubview(dateLable)
        contentView.addSubview(countyLable)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            titleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            titleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin),

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
