//
//  RandomTeamViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/18.
//

import UIKit

class RandomTeamViewController: UIViewController {

    private var players: [Player] = [
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

    private let playerListTableView = PlayerListTableView(frame: .zero, style: .plain)

    lazy var generateRandomTeamButton: UIButton = {
        let button = UIButton()
        button.setTitle("開始分隊", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(generateRandomTeam), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    let doneRandonTeamLable: UILabel = {
        let label = UILabel()
        label.text = "名單"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(generateRandomTeamButton)
        view.addSubview(doneRandonTeamLable)
        setPlayersTableView()
        setNavBar()
        setLayout()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.randomTeam.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .purple2
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setPlayersTableView() {
        view.addSubview(playerListTableView)
        playerListTableView.translatesAutoresizingMaskIntoConstraints = false
        playerListTableView.players = players
        playerListTableView.canEdit = false
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            playerListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            playerListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: standardMargin),
            playerListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            playerListTableView.heightAnchor.constraint(equalToConstant: 200),

            generateRandomTeamButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            generateRandomTeamButton.topAnchor.constraint(equalTo: playerListTableView.bottomAnchor, constant: standardMargin),
            generateRandomTeamButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            generateRandomTeamButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),

            doneRandonTeamLable.topAnchor.constraint(equalTo: generateRandomTeamButton.bottomAnchor, constant: standardMargin),
            doneRandonTeamLable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    @objc func generateRandomTeam() {
        // Shuffle the players array randomly
        var shuffledPlayers = players.shuffled()
        shuffledPlayers.sort { $0.gender > $1.gender }

        // Create an array to hold the groups
        var groups: [[Player]] = [[], [], []]

        var totalNumber = 0
        var nthTotal = totalNumber % 3

        for player in shuffledPlayers {
            groups[nthTotal].append(player)
            totalNumber += 1
            nthTotal = totalNumber % 3
        }

        var groupNames: [String] = []

        for group in groups {
            var groupName = ""
            for player in group {
                groupName += (player.name + " ")
            }
            groupNames.append(groupName)
        }

        doneRandonTeamLable.text = "A: \(groupNames[0])\n B: \(groupNames[1])\n C: \(groupNames[2])"
        doneRandonTeamLable.isHidden = false
    }

    func didTapProfileButton(for player: Player) {
        print("Tapped on profile button for \(player.name)")
    }
}
