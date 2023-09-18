//
//  AddPlayViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/18.
//

import UIKit

class AddPlayViewController: UIViewController, PlayerListTableViewDelegate {

    private var playView = PlayInfoView()
    private let playerListTableView = PlayerListTableView(frame: .zero, style: .plain)
    lazy var sendRequestButton: UIButton = {
        let button = UIButton()
        button.setTitle("send request", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()

    var thisPlay: Play? {
        didSet {
            sendData(thisPlay!)
        }
    }

    private var addPlayers: [Player] = [
        Player(name: "May Lee", gender: "Female"),
        Player(name: "Mandy", gender: "Female")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(playView)
        view.addSubview(sendRequestButton)
        setPlayersTableView()
        setLayout()
        setNavBar()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.addOnePage.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor.white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setPlayersTableView() {
        view.addSubview(playerListTableView)
        playerListTableView.translatesAutoresizingMaskIntoConstraints = false
        playerListTableView.playerListDelegate = self
        playerListTableView.players = addPlayers
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

            sendRequestButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            sendRequestButton.topAnchor.constraint(equalTo: playerListTableView.bottomAnchor, constant: standardMargin),
            sendRequestButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            sendRequestButton.heightAnchor.constraint(equalToConstant: standardButtonHeight)
        ])
    }

    func sendData(_ data: Play) {
        playView.play = thisPlay
        playView.setUI()
    }

    func didTapProfileButton(for player: Player) {
        // Handle profile button tap for the selected player
        print("Tapped on profile button for \(player.name)")
        // Navigate to the player's profile view or perform any other action
    }
    
    @objc func sendRequest() {
        print("request sent")
        navigationController?.popToRootViewController(animated: true)
    }
}
