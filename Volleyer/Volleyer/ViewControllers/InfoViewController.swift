//
//  InfoViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/22.
//

import UIKit

class InfoViewController: UIViewController, ThisPlayDataManagerDelegate, ThisUserDataManagerDelegate {

    private var playView = PlayInfoView()
    private var profileView = ProfileView()

    var thisPlay: Play? {
        didSet {
            sendDataToPlayView(thisPlay!)
        }
    }
    var thisUser: UserData? {
        didSet {
            sendDataToProfileView(thisUser!)
        }
    }
    var thisPlayId: String?
    var thisUserId: String?
    let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(playView)
        view.addSubview(profileView)
        dataManager.getPlayById(id: thisPlayId ?? "")
        dataManager.getUserById(id: thisUserId ?? "")
        dataManager.thisPlayDelegate = self
        dataManager.thisUserDelegate = self
        setLayout()
        setNavBar()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.info.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor.black
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setLayout() {
        playView.translatesAutoresizingMaskIntoConstraints = false
        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            playView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            playView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: standardMargin),
            playView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    func sendDataToPlayView(_ data: Play) {
        playView.play = thisPlay
        playView.setUI()
    }

    func sendDataToProfileView(_ data: UserData) {
        profileView.thisUser = thisUser
        profileView.setContent()
    }

    func manager(_ manager: DataManager, thisPlay play: Play) {
        thisPlay = play
    }

    func manager(_ manager: DataManager, thisUser user: UserData) {
        thisUser = user
    }
}
