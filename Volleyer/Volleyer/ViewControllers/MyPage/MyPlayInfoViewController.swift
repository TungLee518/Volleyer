//
//  MyPlayInfoViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/18.
//

import UIKit

class MyPlayInfoViewController: UIViewController {
    private var playView = PlayInfoView()
    private let playerListTableView = PlayerListTableView(frame: .zero, style: .plain)
    lazy var changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("我要更改", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pushToAddPlayVC), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()

    var thisPlay: Play? {
        didSet {
            sendDataToPlayView(thisPlay!)
        }
    }

    private var addPlayers: [Player] = [
        Player(name: "May Lee", gender: "Female"),
        Player(name: "Mandy", gender: "Female")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(playView)
        view.addSubview(changeButton)
        setPlayersTableView()
        setLayout()
        setNavBar()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.myPlayInfo.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor.black
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setPlayersTableView() {
        view.addSubview(playerListTableView)
        playerListTableView.translatesAutoresizingMaskIntoConstraints = false
        playerListTableView.players = addPlayers
        playerListTableView.canEdit = false
    }

    private func setLayout() {
        playView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            playView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            playerListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            playerListTableView.topAnchor.constraint(equalTo: playView.bottomAnchor, constant: standardMargin),
            playerListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            playerListTableView.heightAnchor.constraint(equalToConstant: 200),

            changeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            changeButton.topAnchor.constraint(equalTo: playerListTableView.bottomAnchor, constant: standardMargin),
            changeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            changeButton.heightAnchor.constraint(equalToConstant: standardButtonHeight)
        ])
    }

    func sendDataToPlayView(_ data: Play) {
        playView.play = thisPlay
        playView.setUI()
    }

    func didTapProfileButton(for player: Player) {
        // Handle profile button tap for the selected player
        print("Tapped on profile button for \(player.name)")
        // Navigate to the player's profile view or perform any other action
    }

    @objc func pushToAddPlayVC() {
        let nextVC = AddPlayViewController()
        nextVC.thisPlay = thisPlay
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
