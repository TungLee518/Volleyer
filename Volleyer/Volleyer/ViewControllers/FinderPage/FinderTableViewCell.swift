//
//  FindPlayerTableViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/14.
//

import Foundation
import UIKit

class FinderTableViewCell: UITableViewCell {

    static let identifier = "PlayInfoTableViewCell"

    weak var parent: FinderViewController?

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
        label.textColor = .gray1
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var playView = PlayInfoView()
    var thisPlay: Play? {
        didSet {
            sendDataToPlayView(thisPlay!)
            accountLable.text = thisPlay?.finderId
            photoImageView.image = UIImage(named: thisPlay?.finderId ?? "placeholder")
            if thisPlay?.finderId == UserDefaults.standard.string(forKey: UserTitle.id.rawValue) {
                wantToAddButton.isHidden = true
            } else {
                wantToAddButton.isHidden = false
            }
        }
    }

    lazy var wantToAddButton: UIButton = {
        let button = UIButton()
        button.setTitle("我要加", for: .normal)
        button.titleLabel?.font =  .semiboldNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .purple1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addPlay), for: .touchUpInside)
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(photoImageView)
        contentView.addSubview(accountLable)
        contentView.addSubview(playView)
        playView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(wantToAddButton)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin),
            photoImageView.heightAnchor.constraint(equalToConstant: photoHeight),
            photoImageView.widthAnchor.constraint(equalToConstant: photoHeight),

            accountLable.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: standardMargin),
            accountLable.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),

            playView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            playView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            playView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            wantToAddButton.topAnchor.constraint(equalTo: playView.bottomAnchor, constant: standardMargin),
            wantToAddButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),
            wantToAddButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin),
            wantToAddButton.heightAnchor.constraint(equalToConstant: 40),
            wantToAddButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin)
        ])
    }

    func sendDataToPlayView(_ data: Play) {
        playView.play = thisPlay
        playView.setUI()
    }

    @objc func addPlay() {
        let nextVC = AddPlayViewController()
        nextVC.thisPlay = thisPlay
        parent?.navigationController?.pushViewController(nextVC, animated: true)
    }
}
