//
//  ProfileViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/22.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {

    var thisUserId: String? {
        didSet {
            getUserData()
        }
    }
    var thisUser: User? {
        didSet {
            profileView.thisUser = thisUser
            profileView.parent = self
        }
    }

    private var profileView = ProfileView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileView)
        setNavBar()
        setLayout()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.profile.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .purple2
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.purple2], for: .normal)

    }

    private func setLayout() {
        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    func getUserData() {
        FinderDataManager.sharedDataMenager.getUserByFirebaseId(id: thisUserId ?? "No User") { gotUser, err in
            self.profileView.thisUser = gotUser
            self.profileView.parent = self
        }
    }
}
