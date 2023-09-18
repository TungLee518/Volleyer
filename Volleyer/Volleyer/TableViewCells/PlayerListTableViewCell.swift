//
//  PlayerListTableViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/16.
//

import UIKit

struct Player {
    let name: String
    let gender: String
    // Add more properties as needed
}

class PlayerTableViewCell: UITableViewCell {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "gender"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    private lazy var profileButton: UIButton = {
        let button = UIButton()
        button.setTitle("view", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.gray, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        // Configure the appearance of nameLabel, genderLabel, and profileButton
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        profileButton.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(nameLabel)
        contentView.addSubview(genderLabel)
        contentView.addSubview(profileButton)

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            genderLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: standardMargin),
            genderLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            genderLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            profileButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin/4),
            profileButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),
            profileButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin/4),
            profileButton.heightAnchor.constraint(equalToConstant: 20),
            profileButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configure(with player: Player) {
        nameLabel.text = player.name
        genderLabel.text = player.gender
        // Customize the cell's appearance as needed
    }
}
