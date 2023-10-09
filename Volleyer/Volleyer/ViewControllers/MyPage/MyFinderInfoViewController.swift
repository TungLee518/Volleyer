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
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.purple1.cgColor
        button.addTarget(self, action: #selector(randomTeamPage), for: .touchUpInside)
        return button
    }()
    lazy var changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("我要更改", for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.purple1.cgColor
        button.addTarget(self, action: #selector(pushToEstablishVC), for: .touchUpInside)
        return button
    }()

    var thisPlay: Play? {
        didSet {
            playView.thisPlay = thisPlay
        }
    }

    private var addPlayers: [Player] = [
        Player(name: "May", gender: "Female"),
        Player(name: "Mandy", gender: "Female"),
        Player(name: "Iris", gender: "Female"),
        Player(name: "Ruby", gender: "Female"),
        Player(name: "Shuyu", gender: "Female"),
        Player(name: "Renee", gender: "Female"),
        Player(name: "Finn", gender: "Female"),
        Player(name: "Jenny", gender: "Female"),
        Player(name: "Bonnie", gender: "Female"),
        Player(name: "Angus", gender: "Female"),
        Player(name: "Aaron", gender: "Male"),
        Player(name: "Steven", gender: "Female"),
        Player(name: "Jimmy", gender: "Male"),
        Player(name: "Brain", gender: "Male"),
        Player(name: "Jason", gender: "Male"),
        Player(name: "Tim", gender: "Male"),
        Player(name: "Roland", gender: "Male"),
        Player(name: "Elven", gender: "Male")
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
        let storyboard = UIStoryboard(name: "RandomTeam", bundle: nil)
        if let nextVC = storyboard.instantiateViewController(withIdentifier: "RandomTeamViewController") as? RandomTeamViewController {
            nextVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(nextVC, animated: true)
        }
//        let nextVC = RandomTeamViewController()
//        navigationController?.pushViewController(nextVC, animated: true)
    }
}
