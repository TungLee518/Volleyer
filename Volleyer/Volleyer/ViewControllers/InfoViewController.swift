//
//  InfoViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/22.
//

import UIKit

class InfoViewController: UIViewController {

    private var playView = PlayInfoView()
    private var profileView = ProfileView()
    lazy var cancelRequestButton: UIButton = {
        let button = UIButton()
        button.setTitle(RequestEnum.cancelAddPlay.rawValue, for: .normal)
        button.whiteButton()
        button.addTarget(self, action: #selector(cancelRequest), for: .touchUpInside)
        return button
    }()

    var thisPlay: Play? {
        didSet {
            playView.thisPlay = thisPlay
        }
    }
    var thisUser: User? {
        didSet {
            profileView.thisUser = thisUser
            profileView.parent = self
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
    let dataManager = FinderDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(playView)
        view.addSubview(profileView)
        view.addSubview(cancelRequestButton)
        getUserAndPlayData()
        setLayout()
        setNavBar()
        playView.applyShadow()
        playView.backgroundColor = .white
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
//        self.title = NavBarEnum.info.rawValue
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
//            profileView.heightAnchor.constraint(equalToConstant: 200),
            playView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: standardMargin),
            playView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            playView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            playView.bottomAnchor.constraint(equalTo: cancelRequestButton.topAnchor, constant: -standardMargin),
//            playView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            cancelRequestButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: standardMargin),
            cancelRequestButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
//            cancelRequestButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),
            cancelRequestButton.heightAnchor.constraint(equalToConstant: standardButtonHeight)
        ])
    }

    func getUserAndPlayData() {
        dataManager.getPlayById(id: thisPlayId ?? "") { gotPlay, err in
            if let gotPlay = gotPlay {
                self.thisPlay = gotPlay
            }
        }
        dataManager.getUserByFirebaseId(id: thisUserId ?? "") { gotUser, err in
            if let gotUser = gotUser {
                self.thisUser = gotUser
            }
        }
    }

    @objc func cancelRequest() {
        let controller = UIAlertController(title: "確定？", message: "要刪除加場？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "是", style: .default) { _ in
            print("確定要刪除")
            if let thisRequest = self.thisRequest {
                RequestDataManager.sharedDataMenager.cancelRequest(thisRequest)
            }
            self.navigationController?.popViewController(animated: true)
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        controller.addAction(cancelAction)
        present(controller, animated: true)
    }
}
