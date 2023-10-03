//
//  AddPlayViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/18.
//

import UIKit

class AddPlayViewController: UIViewController {

    private var playView = PlayInfoView()
    private let playerListTableView = PlayerListTableView(frame: .zero, style: .plain)
    lazy var addPlayerButton: UIButton = {
        let button = UIButton()
        button.setTitle(AddPlayPageEnum.addPlayer.rawValue, for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.purple1.cgColor
        button.addTarget(self, action: #selector(addPlayer), for: .touchUpInside)
        return button
    }()
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.purple1.cgColor
        button.addTarget(self, action: #selector(toggleEditingMode), for: .touchUpInside)
        return button
    }()
    lazy var sendRequestButton: UIButton = {
        let button = UIButton()
        button.setTitle(AddPlayPageEnum.sendRequest.rawValue, for: .normal)
        button.titleLabel?.font =  .semiboldNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .purple1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
        return button
    }()

    var thisPlay: Play? {
        didSet {
            sendDataToPlayView(thisPlay!)
        }
    }

    private var addPlayers: [Player] = []

    var dataManager = RequestDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(playView)
        view.addSubview(addPlayerButton)
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
        backButton.tintColor = .purple2
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setPlayersTableView() {
        view.addSubview(playerListTableView)
        playerListTableView.translatesAutoresizingMaskIntoConstraints = false
        // 第一個永遠是自己
        playerListTableView.players.append(
            Player(name: UserDefaults.standard.string(forKey: UserTitle.name.rawValue)!,
                   gender: UserDefaults.standard.string(forKey: UserTitle.gender.rawValue)!)
        )
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

            addPlayerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            addPlayerButton.topAnchor.constraint(equalTo: playerListTableView.bottomAnchor, constant: standardMargin),
            addPlayerButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            addPlayerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -standardMargin/2),

            sendRequestButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: standardMargin/2),
            sendRequestButton.topAnchor.constraint(equalTo: playerListTableView.bottomAnchor, constant: standardMargin),
            sendRequestButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            sendRequestButton.heightAnchor.constraint(equalToConstant: standardButtonHeight)
        ])
    }

    func sendDataToPlayView(_ data: Play) {
        playView.play = thisPlay
        playView.setUI()
    }

    @objc func sendRequest() {
        addPlayers = playerListTableView.players
        print(addPlayers)
        dataManager.saveRequest(thisPlay!, playerList: addPlayers)
        print("request sent")
        navigationController?.popToRootViewController(animated: true)
    }

    @objc func toggleEditingMode() {
        playerListTableView.toggleEditing()
        let buttonText = playerListTableView.isEditing ? "Done" : "Delete"
        deleteButton.setTitle(buttonText, for: .normal)
    }
    @objc func addPlayer() {
        let newPlayer = Player(name: "", gender: "") // Customize as needed
        playerListTableView.addNewPlayer(newPlayer)
    }
}
