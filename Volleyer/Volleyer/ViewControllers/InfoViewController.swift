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
    lazy var cancelRequestButton: UIButton = {
        let button = UIButton()
        button.setTitle(RequestEnum.cancelRequest.rawValue, for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelRequest), for: .touchUpInside)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.purple1.cgColor
        button.clipsToBounds = true
        button.isHidden = true
        return button
    }()

    var thisPlay: Play? {
        didSet {
            sendDataToPlayView(thisPlay!)
        }
    }
    var thisUser: User? {
        didSet {
            sendDataToProfileView(thisUser!)
        }
    }
    var thisPlayId: String?
    var thisUserId: String?
    var thisRequest: PlayRequest? {
        didSet {
            if thisRequest?.status == -1 {
                cancelRequestButton.isEnabled = false
                cancelRequestButton.setTitle(RequestEnum.canceled.rawValue, for: .normal)
            }
        }
    }
    let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(playView)
        view.addSubview(profileView)
        view.addSubview(cancelRequestButton)
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
        backButton.tintColor = .purple2
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
            playView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            cancelRequestButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            cancelRequestButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            cancelRequestButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),
            cancelRequestButton.heightAnchor.constraint(equalToConstant: standardButtonHeight)
        ])
    }

    func sendDataToPlayView(_ data: Play) {
        playView.play = thisPlay
        playView.setUI()
    }

    func sendDataToProfileView(_ data: User) {
        profileView.thisUser = thisUser
        profileView.setContent()
    }

    func manager(_ manager: DataManager, thisPlay play: Play) {
        thisPlay = play
    }

    func manager(_ manager: DataManager, thisUser user: User) {
        thisUser = user
    }

    @objc func cancelRequest() {
        if let thisRequest = thisRequest {
            RequestDataManager.sharedDataMenager.cancelRequest(thisRequest)
        }
        navigationController?.popViewController(animated: true)
    }
    @objc func cancelAddPlay() {
        cancelRequestButton.isEnabled = false
        cancelRequestButton.setTitle(RequestEnum.canceled.rawValue, for: .normal)
    }
}
