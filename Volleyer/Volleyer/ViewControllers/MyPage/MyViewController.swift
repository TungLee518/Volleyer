//
//  MyPageViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/15.
//

import UIKit

class MyViewController: UIViewController {

    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: UserDefaults.standard.string(forKey: UserTitle.id.rawValue) ?? "placeholder")
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
    lazy var myProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("My Profile", for: .normal)
        button.titleLabel?.font =  .semiboldNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .purple1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(pushToMyProfile), for: .touchUpInside)
        return button
    }()
    lazy var myFinderButton: UIButton = {
        let button = UIButton()
        button.setTitle("我的揪場", for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .purple6
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.purple1.cgColor
        button.addTarget(self, action: #selector(pushToMyFinders), for: .touchUpInside)
        return button
    }()
    lazy var myPlayButton: UIButton = {
        let button = UIButton()
        button.setTitle("我要打的場", for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .purple6
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.purple1.cgColor
        button.addTarget(self, action: #selector(pushToMyPlays), for: .touchUpInside)
        return button
    }()
    lazy var requestsReceiveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Requests I Received", for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.purple1.cgColor
        button.addTarget(self, action: #selector(pushToRequestsReceive), for: .touchUpInside)
        return button
    }()
    lazy var requestsSendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Requests I Sent", for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.purple1.cgColor
        button.addTarget(self, action: #selector(pushToRequestsSend), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

//        view.addSubview(photoImageView)
//        view.addSubview(accountLable)
        view.addSubview(myProfileButton)
        view.addSubview(myFinderButton)
        view.addSubview(myPlayButton)
        view.addSubview(requestsReceiveButton)
        view.addSubview(requestsSendButton)

        setLayout()
        navigationItem.title = NavBarEnum.myPage.rawValue
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
//            photoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
//            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: standardMargin),
//            photoImageView.heightAnchor.constraint(equalToConstant: photoHeight),
//            photoImageView.widthAnchor.constraint(equalToConstant: photoHeight),
//
//            accountLable.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: standardMargin),
//            accountLable.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),

            myProfileButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            myProfileButton.bottomAnchor.constraint(equalTo: myFinderButton.topAnchor, constant: -standardMargin),
            myProfileButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            myProfileButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),

            myFinderButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            myFinderButton.bottomAnchor.constraint(equalTo: myPlayButton.topAnchor, constant: -standardMargin),
            myFinderButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            myFinderButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),

            myPlayButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            myPlayButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            myPlayButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            myPlayButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),

            requestsReceiveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            requestsReceiveButton.topAnchor.constraint(equalTo: myPlayButton.bottomAnchor, constant: standardMargin),
            requestsReceiveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            requestsReceiveButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),

            requestsSendButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            requestsSendButton.topAnchor.constraint(equalTo: requestsReceiveButton.bottomAnchor, constant: standardMargin),
            requestsSendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            requestsSendButton.heightAnchor.constraint(equalToConstant: standardButtonHeight)
        ])
    }

    @objc func pushToMyProfile() {
        let nextVC = ProfileViewController()
        nextVC.thisUser = User(
            id: UserDefaults.standard.string(forKey: UserTitle.id.rawValue) ?? "No id found",
            email: UserDefaults.standard.string(forKey: UserTitle.email.rawValue) ?? "No email found",
            gender: UserDefaults.standard.integer(forKey: UserTitle.gender.rawValue),
            name: UserDefaults.standard.string(forKey: UserTitle.name.rawValue) ?? "No name found",
            level: LevelRange(setBall: UserDefaults.standard.integer(forKey: Level.setBall.rawValue),
                              block: UserDefaults.standard.integer(forKey: Level.block.rawValue),
                              dig: UserDefaults.standard.integer(forKey: Level.dig.rawValue),
                              spike: UserDefaults.standard.integer(forKey: Level.spike.rawValue),
                              sum: UserDefaults.standard.integer(forKey: Level.sum.rawValue)),
            image: UserDefaults.standard.string(forKey: UserTitle.image.rawValue) ?? "https://firebasestorage.googleapis.com/v0/b/volleyer-a15b6.appspot.com/o/defaults%2Fplaceholder.png?alt=media&token=d686707b-7b55-4291-8d67-c809c14f9528&_gl=1*gmtbad*_ga*MTE1Njk3OTU3Ny4xNjkxNjU1MTk0*_ga_CW55HF8NVT*MTY5NjA2MDc1Ni45Mi4xLjE2OTYwNjEwMTguNTQuMC4w"
        )
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @objc func pushToMyFinders() {
        let nextVC = MyFindersViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @objc func pushToMyPlays() {
        let nextVC = MyPlaysViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @objc func pushToRequestsReceive() {
        let nextVC = RequestsReceivedViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @objc func pushToRequestsSend() {
        let nextVC = RequestSentViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
