//
//  ProfileViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/22.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController, ThisUserDataManagerDelegate {

    var thisUserId: String? {
        didSet {
            dataManager.getUserById(id: thisUserId ?? "No User")
        }
    }

    private var profileView = ProfileView()

    let dataManager = FinderDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileView)
        dataManager.thisUserDelegate = self
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

    func manager(_ manager: FinderDataManager, thisUser user: User) {
        profileView.thisUser = user
        profileView.parent = self
    }
}
