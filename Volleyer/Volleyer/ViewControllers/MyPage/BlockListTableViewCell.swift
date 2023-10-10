//
//  BlockListTableViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/8.
//

import UIKit

class BlockListTableViewCell: UITableViewCell {

    static let identifier = "BlockListTableViewCell"

    var accountIdLable: UILabel = {
        let label = UILabel()
        label.text = "defaultId"
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(accountIdLable)
        NSLayoutConstraint.activate([
            accountIdLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            accountIdLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin),
            accountIdLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),
            accountIdLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
