//
//  MyFinderInfoViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/18.
//

import UIKit

class MyFinderInfoViewController: UIViewController {
    private var playView = PlayInfoView()
    private let playerListTableView = PlayerListTableView(frame: .zero, style: .plain)
    lazy var randomTeamButton: UIButton = {
        let button = UIButton()
        button.setTitle("幫我分隊", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(randomTeamPage), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    lazy var changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("我要更改", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pushToEstablishVC), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()

    var thisPlay: Play? {
        didSet {
            playView.thisPlay = thisPlay
        }
    }

    private var addPlayers: [Player] = [
        Player(name: "May Lee", gender: "Female"),
        Player(name: "Mandy", gender: "Female"),
        Player(name: "May Lee", gender: "Female"),
        Player(name: "Mandy", gender: "Female"),
        Player(name: "May Lee", gender: "Female"),
        Player(name: "Mandy", gender: "Female")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(playView)
        view.addSubview(randomTeamButton)
        setPlayersTableView()
        setLayout()
        setNavBar()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.myFinderInfo.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .purple2
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setPlayersTableView() {
        view.addSubview(playerListTableView)
        view.addSubview(changeButton)
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
            changeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -standardMargin/2),
            changeButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),

            randomTeamButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: standardMargin/2),
            randomTeamButton.topAnchor.constraint(equalTo: playerListTableView.bottomAnchor, constant: standardMargin),
            randomTeamButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            randomTeamButton.heightAnchor.constraint(equalToConstant: standardButtonHeight)
        ])
    }

    func didTapProfileButton(for player: Player) {
        // Handle profile button tap for the selected player
        print("Tapped on profile button for \(player.name)")
        // Navigate to the player's profile view or perform any other action
    }

    @objc func pushToEstablishVC() {
        let nextVC = EstablishFinderViewController()
//        nextVC.startTimeTextField
        if let thisPlay = thisPlay {
            nextVC.thisPlay = thisPlay
        }
//        nextVC.placeTextField.text = thisPlay?.place
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @objc func randomTeamPage() {
        print("go to random team page")
        let nextVC = RandomTeamViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
