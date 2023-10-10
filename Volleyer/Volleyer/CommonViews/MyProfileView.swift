//
//  MyProfileView.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/5.
//

import Foundation
import UIKit

class MyProfileView: UIView {
    var thisUser: User?

    let dataManager = MyDataManager()

    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: UserDefaults.standard.string(forKey: UserTitle.id.rawValue) ?? "placeholder")
        imageView.layer.cornerRadius = photoHeight
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let accountLable: UILabel = {
        let label = UILabel()
        label.text = "id"
        label.textColor = .gray2
        label.font = .semiboldNunito(size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let nameLable: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.textColor = .gray2
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let genderLable: UILabel = {
        let label = UILabel()
        label.text = "gender"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("更改", for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.purple1.cgColor
//        button.addTarget(self, action: #selector(toggleEditingMode), for: .touchUpInside)
        return button
    }()
    private let levelLable: UILabel = {
        let label = UILabel()
        label.text = "Level"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let setLable: UILabel = {
        let label = UILabel()
        label.text = "舉球"
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let setLevelLable: UILabel = {
        let label = UILabel()
        let padding = 3
        label.text = "No"
        label.textColor = .purple3
        label.backgroundColor = .purple7
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let spikeLable: UILabel = {
        let label = UILabel()
        label.text = "攻擊"
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let spikeLevelLable: UILabel = {
        let label = UILabel()
        let padding = 3
        label.text = "No"
        label.textColor = .purple3
        label.backgroundColor = .purple7
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let digLable: UILabel = {
        let label = UILabel()
        label.text = "接球"
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let digLevelLable: UILabel = {
        let label = UILabel()
        let padding = 3
        label.text = "No"
        label.textColor = .purple3
        label.backgroundColor = .purple7
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let blockLable: UILabel = {
        let label = UILabel()
        label.text = "攔網"
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let blockLevelLable: UILabel = {
        let label = UILabel()
        let padding = 3
        label.text = "No"
        label.textColor = .purple3
        label.backgroundColor = .purple7
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let sumLable: UILabel = {
        let label = UILabel()
        label.text = "綜合"
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let sumLevelLable: UILabel = {
        let label = UILabel()
        let padding = 3
        label.text = "No"
        label.textColor = .purple3
        label.backgroundColor = .purple7
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func setView() {
        addSubview(photoImageView)
        addSubview(accountLable)
        addSubview(setLable)
        addSubview(setLevelLable)
        addSubview(spikeLable)
        addSubview(spikeLevelLable)
        addSubview(digLable)
        addSubview(digLevelLable)
        addSubview(blockLable)
        addSubview(blockLevelLable)
        addSubview(sumLable)
        addSubview(sumLevelLable)
        setContent()
        setLayout()
    }
    func setContent() {
        photoImageView.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: UserTitle.image.rawValue) ?? placeholderImage))
        accountLable.text = UserDefaults.standard.string(forKey: UserTitle.id.rawValue) ?? "No id found"
        nameLable.text = UserDefaults.standard.string(forKey: UserTitle.name.rawValue)
        genderLable.text = genderList[UserDefaults.standard.integer(forKey: UserTitle.gender.rawValue)]
        setLevelLable.text = "  \(levelList[UserDefaults.standard.integer(forKey: Level.setBall.rawValue)])  "
        spikeLevelLable.text = "  \(levelList[UserDefaults.standard.integer(forKey: Level.spike.rawValue)])  "
        digLevelLable.text = "  \(levelList[UserDefaults.standard.integer(forKey: Level.dig.rawValue)])  "
        blockLevelLable.text = "  \(levelList[UserDefaults.standard.integer(forKey: Level.block.rawValue)])  "
        sumLevelLable.text = "  \(levelList[UserDefaults.standard.integer(forKey: Level.sum.rawValue)])  "
    }
    private func setLayout() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 250),
            photoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            photoImageView.heightAnchor.constraint(equalToConstant: photoHeight*2),
            photoImageView.widthAnchor.constraint(equalToConstant: photoHeight*2),

            accountLable.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: standardMargin),
            accountLable.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),

            digLable.centerXAnchor.constraint(equalTo: accountLable.centerXAnchor),
            digLable.topAnchor.constraint(equalTo: accountLable.bottomAnchor, constant: standardMargin),
            digLevelLable.centerXAnchor.constraint(equalTo: digLable.centerXAnchor),
            digLevelLable.topAnchor.constraint(equalTo: digLable.bottomAnchor, constant: standardMargin),

            spikeLable.trailingAnchor.constraint(equalTo: digLable.leadingAnchor, constant: -standardMargin*2),
            spikeLable.centerYAnchor.constraint(equalTo: digLable.centerYAnchor),
            spikeLevelLable.centerXAnchor.constraint(equalTo: spikeLable.centerXAnchor),
            spikeLevelLable.topAnchor.constraint(equalTo: spikeLable.bottomAnchor, constant: standardMargin),

            setLable.trailingAnchor.constraint(equalTo: spikeLable.leadingAnchor, constant: -standardMargin*2),
            setLable.centerYAnchor.constraint(equalTo: digLable.centerYAnchor),
            setLevelLable.centerXAnchor.constraint(equalTo: setLable.centerXAnchor),
            setLevelLable.topAnchor.constraint(equalTo: setLable.bottomAnchor, constant: standardMargin),

            blockLable.leadingAnchor.constraint(equalTo: digLable.trailingAnchor, constant: standardMargin*2),
            blockLable.centerYAnchor.constraint(equalTo: digLable.centerYAnchor),
            blockLevelLable.centerXAnchor.constraint(equalTo: blockLable.centerXAnchor),
            blockLevelLable.topAnchor.constraint(equalTo: blockLable.bottomAnchor, constant: standardMargin),

            sumLable.leadingAnchor.constraint(equalTo: blockLable.trailingAnchor, constant: standardMargin*2),
            sumLable.centerYAnchor.constraint(equalTo: digLable.centerYAnchor),
            sumLevelLable.centerXAnchor.constraint(equalTo: sumLable.centerXAnchor),
            sumLevelLable.topAnchor.constraint(equalTo: sumLable.bottomAnchor, constant: standardMargin)
        ])
    }
}
