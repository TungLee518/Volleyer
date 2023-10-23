//
//  MyFinderInfoViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/18.
//

import UIKit

class MyFinderInfoViewController: UIViewController {
    private var playView = PlayInfoView()
    let playersTableViewLable: UILabel = {
        let label = UILabel()
        label.text = "打場名單"
        label.textColor = .gray2
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let playerListTableView = PlayerListTableView(frame: .zero, style: .plain)
    lazy var randomTeamButton: UIButton = {
        let button = UIButton()
        button.setTitle("幫我分隊", for: .normal)
        button.whiteButton()
        button.addTarget(self, action: #selector(randomTeamPage), for: .touchUpInside)
        return button
    }()
    lazy var changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("我要更改", for: .normal)
        button.whiteButton()
        button.addTarget(self, action: #selector(pushToEstablishVC), for: .touchUpInside)
        return button
    }()

    var thisPlay: Play? {
        didSet {
            playView.thisPlay = thisPlay
        }
    }

    private var addPlayers = fakeUsers

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(playView)
        view.addSubview(randomTeamButton)
        view.addSubview(playersTableViewLable)
        setPlayersTableView()
        setLayout()
        setNavBar()
//        playersTableViewLable.isHidden = true
//        playerListTableView.isHidden = true
//        randomTeamButton.isHidden = true
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
        playerListTableView.layer.cornerRadius = 20
        playerListTableView.layer.borderColor = UIColor.gray4.cgColor
        playerListTableView.layer.borderWidth = 0.7
        playerListTableView.backgroundColor = .white
        playerListTableView.sectionHeaderTopPadding = 0
        playerListTableView.separatorStyle = .none
    }

    private func setLayout() {
        playView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            playView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            playersTableViewLable.topAnchor.constraint(equalTo: playView.bottomAnchor),
            playersTableViewLable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            playerListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            playerListTableView.topAnchor.constraint(equalTo: playersTableViewLable.bottomAnchor, constant: standardMargin/2),
            playerListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),

            changeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            changeButton.topAnchor.constraint(equalTo: playerListTableView.bottomAnchor, constant: standardMargin),
            changeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -standardMargin/2),
            changeButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            changeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),

            randomTeamButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: standardMargin/2),
            randomTeamButton.topAnchor.constraint(equalTo: playerListTableView.bottomAnchor, constant: standardMargin),
            randomTeamButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            randomTeamButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            randomTeamButton.centerYAnchor.constraint(equalTo: changeButton.centerYAnchor)
        ])
    }

    func didTapProfileButton(for player: Player) {
        // Handle profile button tap for the selected player
        print("Tapped on profile button for \(player.name)")
        // Navigate to the player's profile view or perform any other action
    }

    @objc func pushToEstablishVC() {
        let nextVC = EstablishFinderViewController()
        if let thisPlay = thisPlay {
            nextVC.thisPlay = thisPlay
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @objc func randomTeamPage() {
        print("go to random team page")
        let storyboard = UIStoryboard(name: "RandomTeam", bundle: nil)
        if let nextVC = storyboard.instantiateViewController(withIdentifier: "RandomTeamViewController") as? RandomTeamViewController {
            nextVC.hidesBottomBarWhenPushed = true
            nextVC.playerUsers = addPlayers
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
