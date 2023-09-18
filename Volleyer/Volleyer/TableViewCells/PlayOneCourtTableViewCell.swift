//
//  PlayOneCourtsTableViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/18.
//

import UIKit

class PlayOneCourtTableViewCell: UITableViewCell {

    static let identifier = "PlayOneCourtTableViewCell"

    private let courtLable: UILabel = {
        let label = UILabel()
        label.text = "場五"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.layer.cornerRadius = photoHeight / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let accountLable: UILabel = {
        let label = UILabel()
        label.text = "maymmm518"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.addSubview(courtLable)
        contentView.addSubview(photoImageView)
        contentView.addSubview(accountLable)
        setLayout()
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            courtLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            courtLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin),
            photoImageView.heightAnchor.constraint(equalToConstant: photoHeight),
            photoImageView.widthAnchor.constraint(equalToConstant: photoHeight),

            accountLable.leadingAnchor.constraint(equalTo: courtLable.trailingAnchor, constant: standardMargin),
            accountLable.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: standardMargin),
            accountLable.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            accountLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin)
        ])
    }
}
