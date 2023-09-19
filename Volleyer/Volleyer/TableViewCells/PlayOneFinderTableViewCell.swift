//
//  PlayOneFinderTableViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/18.
//

import UIKit

class PlayOneFinderTableViewCell: UITableViewCell {

    static let identifier = "PlayOneFinderTableViewCell"
    
    weak var parent: PlayOneCourtViewController?

    private let playNLable: UILabel = {
        let label = UILabel()
        label.text = "Play 1"
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
    lazy var player1Button: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addOne), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    lazy var player2Button: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addOne), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    lazy var player3Button: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addOne), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    lazy var player4Button: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addOne), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    lazy var player5Button: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addOne), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.addSubview(playNLable)
        contentView.addSubview(photoImageView)
        contentView.addSubview(accountLable)
        contentView.addSubview(player1Button)
        contentView.addSubview(player2Button)
        contentView.addSubview(player3Button)
        contentView.addSubview(player4Button)
        contentView.addSubview(player5Button)
        setLayout()
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            playNLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            playNLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin),
            photoImageView.heightAnchor.constraint(equalToConstant: photoHeight),
            photoImageView.widthAnchor.constraint(equalToConstant: photoHeight),

            accountLable.leadingAnchor.constraint(equalTo: playNLable.trailingAnchor, constant: standardMargin),
            accountLable.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: standardMargin),
            accountLable.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            accountLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin),

            player1Button.leadingAnchor.constraint(equalTo: accountLable.trailingAnchor, constant: standardMargin),
            player1Button.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -standardMargin/2),
            player1Button.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            player1Button.widthAnchor.constraint(equalToConstant: 50),
            player2Button.leadingAnchor.constraint(equalTo: player1Button.trailingAnchor, constant: standardMargin/2),
            player2Button.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -standardMargin/2),
            player2Button.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            player2Button.widthAnchor.constraint(equalToConstant: 50),
            player3Button.leadingAnchor.constraint(equalTo: player2Button.trailingAnchor, constant: standardMargin/2),
            player3Button.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -standardMargin/2),
            player3Button.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            player3Button.widthAnchor.constraint(equalToConstant: 50),
            player4Button.leadingAnchor.constraint(equalTo: accountLable.trailingAnchor, constant: standardMargin),
            player4Button.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: standardMargin/2),
            player4Button.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            player4Button.widthAnchor.constraint(equalToConstant: 50),
            player5Button.leadingAnchor.constraint(equalTo: player4Button.trailingAnchor, constant: standardMargin/2),
            player5Button.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: standardMargin/2),
            player5Button.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            player5Button.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func addOne() {
        let nextVC = CameraViewController()
        parent?.navigationController?.pushViewController(nextVC, animated: true)
    }
}
