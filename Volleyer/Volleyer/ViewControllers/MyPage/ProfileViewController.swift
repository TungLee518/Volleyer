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
        imageView.image = UIImage(named: "placeholder")
        imageView.layer.cornerRadius = photoHeight / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let accountLable: UILabel = {
        let label = UILabel()
        label.text = "id"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let nameLable: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
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
    private let levelLable: UILabel = {
        let label = UILabel()
        label.text = "level"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let setLable: UILabel = {
        let label = UILabel()
        label.text = "set: S"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let spikeLable: UILabel = {
        let label = UILabel()
        label.text = "spike: S"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let digLable: UILabel = {
        let label = UILabel()
        label.text = "dig: S"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let blockLable: UILabel = {
        let label = UILabel()
        label.text = "block: S"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let sumLable: UILabel = {
        let label = UILabel()
        label.text = "sum: S"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(photoImageView)
        view.addSubview(accountLable)
        view.addSubview(nameLable)
        view.addSubview(genderLable)
        view.addSubview(levelLable)
        view.addSubview(setLable)
        view.addSubview(spikeLable)
        view.addSubview(digLable)
        view.addSubview(blockLable)
        view.addSubview(sumLable)
        setNavBar()
        setLayout()
    }

    func setContent() {
//        accountLable.text = 
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.myProfile.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor.black
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: standardMargin),
            photoImageView.heightAnchor.constraint(equalToConstant: photoHeight),
            photoImageView.widthAnchor.constraint(equalToConstant: photoHeight),

            accountLable.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: standardMargin),
            accountLable.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),

            nameLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            nameLable.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: standardMargin),

            genderLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            genderLable.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: standardMargin),

            levelLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            levelLable.topAnchor.constraint(equalTo: genderLable.bottomAnchor, constant: standardMargin),

            setLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            setLable.topAnchor.constraint(equalTo: levelLable.bottomAnchor, constant: standardMargin),

            spikeLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            spikeLable.topAnchor.constraint(equalTo: setLable.bottomAnchor, constant: standardMargin),

            digLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            digLable.topAnchor.constraint(equalTo: spikeLable.bottomAnchor, constant: standardMargin),

            blockLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            blockLable.topAnchor.constraint(equalTo: digLable.bottomAnchor, constant: standardMargin),

            sumLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            sumLable.topAnchor.constraint(equalTo: blockLable.bottomAnchor, constant: standardMargin)
        ])
    }
}
