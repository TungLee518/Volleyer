//
//  ProfileViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/22.
//

import UIKit

class ProfileViewController: UIViewController {

    var thisUser: User?

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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(photoImageView)
        view.addSubview(accountLable)
//        view.addSubview(nameLable)
//        view.addSubview(genderLable)
//        view.addSubview(levelLable)
        view.addSubview(setLable)
        view.addSubview(setLevelLable)
        view.addSubview(spikeLable)
        view.addSubview(spikeLevelLable)
        view.addSubview(digLable)
        view.addSubview(digLevelLable)
        view.addSubview(blockLable)
        view.addSubview(blockLevelLable)
        view.addSubview(sumLable)
        view.addSubview(sumLevelLable)
        setNavBar()
        setLayout()
        setContent()
    }

    func setContent() {
        if let thisUser = thisUser {
            accountLable.text = thisUser.id
            nameLable.text = thisUser.name
            genderLable.text = genderList[thisUser.gender]
            setLevelLable.text = "  \(levelList[thisUser.level.setBall])  "
            spikeLevelLable.text = "  \(levelList[thisUser.level.spike])  "
            digLevelLable.text = "  \(levelList[thisUser.level.dig])  "
            blockLevelLable.text = "  \(levelList[thisUser.level.block])  "
            sumLevelLable.text = "  \(levelList[thisUser.level.sum])  "
        }
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.myProfile.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .purple2
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            photoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: standardMargin),
            photoImageView.heightAnchor.constraint(equalToConstant: photoHeight*2),
            photoImageView.widthAnchor.constraint(equalToConstant: photoHeight*2),

            accountLable.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: standardMargin),
            accountLable.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),

//            nameLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
//            nameLable.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: standardMargin),
//
//            genderLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
//            genderLable.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: standardMargin),

//            levelLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
//            levelLable.topAnchor.constraint(equalTo: genderLable.bottomAnchor, constant: standardMargin),

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
