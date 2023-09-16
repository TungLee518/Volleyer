//
//  FindPlayerTableViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/14.
//

import Foundation
import UIKit

class PlayInfoTableViewCell: UITableViewCell {

    static let identifier = "PlayInfoTableViewCell"
    
    let photoHeight = 50.0

    lazy var photoImageView: UIImageView = {
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

    private let tagLable: UILabel = {
        let label = UILabel()
        let padding = 3
        label.text = String(repeating: " ", count: padding) + "缺3女" + String(repeating: " ", count: padding)
        label.textColor = UIColor.systemBlue
        label.backgroundColor = UIColor.lightGray
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeLable: UILabel = {
        let label = UILabel()
        label.text = "時間：2023/9/20 (三) 18:00-22:00"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let placeLabel: UILabel = {
        let label = UILabel()
        label.text = "地點：三米線球館"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
//        label.lineBreakMode = .byWordWrapping
//        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let typeLable: UILabel = {
        let label = UILabel()
        label.text = "type: 女網混排"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLable: UILabel = {
        let label = UILabel()
        label.text = "price: 250 元 /人"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let levelLable: UILabel = {
        let label = UILabel()
        label.text = "程度："
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var levelButton: UIButton = {
        let button = UIButton()
        button.setTitle("B", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.orange
        button.translatesAutoresizingMaskIntoConstraints = false
        // button.addTarget(self, action: #selector(addData), for: .touchUpInside)
        button.layer.cornerRadius = standardMargin / 2
        button.clipsToBounds = true
        return button
    }()

    lazy var wantToAddButton: UIButton = {
        let button = UIButton()
        button.setTitle("我要加", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addData), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(photoImageView)
        contentView.addSubview(accountLable)
        contentView.addSubview(tagLable)
        contentView.addSubview(timeLable)
        contentView.addSubview(placeLabel)
        contentView.addSubview(priceLable)
        contentView.addSubview(typeLable)
        contentView.addSubview(levelLable)
        contentView.addSubview(levelButton)
        contentView.addSubview(wantToAddButton)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLayout() {
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin),
            photoImageView.heightAnchor.constraint(equalToConstant: photoHeight),
            photoImageView.widthAnchor.constraint(equalToConstant: photoHeight),

            accountLable.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: standardMargin),
            accountLable.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),

            tagLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin),
            tagLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),

            timeLable.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: standardMargin),
            timeLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            timeLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),

            placeLabel.topAnchor.constraint(equalTo: timeLable.bottomAnchor, constant: standardMargin),
            placeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            placeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),

            priceLable.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: standardMargin),
            priceLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),

            typeLable.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: standardMargin),
            typeLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),

            levelLable.topAnchor.constraint(equalTo: priceLable.bottomAnchor, constant: standardMargin),
            levelLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),

            levelButton.centerYAnchor.constraint(equalTo: levelLable.centerYAnchor),
            levelButton.leadingAnchor.constraint(equalTo: levelLable.trailingAnchor),
            levelButton.heightAnchor.constraint(equalToConstant: standardMargin),
            levelButton.widthAnchor.constraint(equalToConstant: standardMargin),

            wantToAddButton.topAnchor.constraint(equalTo: typeLable.bottomAnchor, constant: standardMargin),
            wantToAddButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),
            wantToAddButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin),
            wantToAddButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    @objc func addData() {
    }
}
