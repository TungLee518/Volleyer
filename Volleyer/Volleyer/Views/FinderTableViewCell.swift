//
//  FindPlayerTableViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/14.
//

import Foundation
import UIKit
import Kingfisher

class FinderTableViewCell: UITableViewCell {

    static let identifier = "PlayInfoTableViewCell"

    weak var parent: FinderViewController?

    lazy var calanderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "calendar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let startTimeLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray2
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let endTimeLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray2
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "location")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let placeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray2
        label.font = .regularNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var maleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "male")
        imageView.tintColor = .gray2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let maleLackLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray2
        label.font = .regularNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var femaleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "female")
        imageView.tintColor = .gray2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let femaleLackLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray2
        label.font = .regularNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var thisPlay: Play? {
        didSet {
            setContent()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        applyShadow()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.addSubview(startTimeLable)
        contentView.addSubview(endTimeLable)
        contentView.addSubview(placeImageView)
        contentView.addSubview(placeLabel)
        contentView.addSubview(maleImageView)
        contentView.addSubview(maleLackLable)
        contentView.addSubview(femaleImageView)
        contentView.addSubview(femaleLackLable)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setContent() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd EE HH:mm"
        if let thisPlay = thisPlay {
            startTimeLable.text = dateFormatter.string(from: thisPlay.startTime)
            endTimeLable.text = dateFormatter.string(from: thisPlay.endTime)
            placeLabel.text = thisPlay.place
            maleLackLable.text = String(thisPlay.lackAmount.male)
            femaleLackLable.text = String(thisPlay.lackAmount.female)
        }
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            startTimeLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin*2),
            startTimeLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin),
            endTimeLable.leadingAnchor.constraint(equalTo: startTimeLable.leadingAnchor),
            endTimeLable.topAnchor.constraint(equalTo: startTimeLable.bottomAnchor, constant: standardMargin/2),
            maleImageView.leadingAnchor.constraint(equalTo: startTimeLable.trailingAnchor, constant: standardMargin*2),
            maleImageView.centerYAnchor.constraint(equalTo: startTimeLable.centerYAnchor),
            maleImageView.heightAnchor.constraint(equalToConstant: 20),
            maleImageView.widthAnchor.constraint(equalTo: placeImageView.heightAnchor, multiplier: 1),
            maleLackLable.leadingAnchor.constraint(equalTo: maleImageView.trailingAnchor, constant: standardMargin),
            maleLackLable.centerYAnchor.constraint(equalTo: maleImageView.centerYAnchor),
            femaleImageView.leadingAnchor.constraint(equalTo: endTimeLable.trailingAnchor, constant: standardMargin*2),
            femaleImageView.centerYAnchor.constraint(equalTo: endTimeLable.centerYAnchor),
            femaleImageView.heightAnchor.constraint(equalToConstant: 20),
            femaleImageView.widthAnchor.constraint(equalTo: placeImageView.heightAnchor, multiplier: 1),
            femaleLackLable.leadingAnchor.constraint(equalTo: femaleImageView.trailingAnchor, constant: standardMargin),
            femaleLackLable.centerYAnchor.constraint(equalTo: femaleImageView.centerYAnchor),
            placeLabel.topAnchor.constraint(equalTo: endTimeLable.bottomAnchor, constant: standardMargin),
            placeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: standardMargin/2),
            placeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin),

            placeImageView.trailingAnchor.constraint(equalTo: placeLabel.leadingAnchor, constant: -standardMargin/2),
            placeImageView.centerYAnchor.constraint(equalTo: placeLabel.centerYAnchor),
            placeImageView.heightAnchor.constraint(equalToConstant: 20),
            placeImageView.widthAnchor.constraint(equalTo: placeImageView.heightAnchor, multiplier: 1)
        ])
    }

    @objc func addPlay() {
        let nextVC = AddPlayViewController()
        nextVC.thisPlay = thisPlay
        parent?.navigationController?.pushViewController(nextVC, animated: true)
    }
}
