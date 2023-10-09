//
//  RandomTeamViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/18.
//

import UIKit
import Lottie

class RandomTeamViewController: UIViewController {

    @IBOutlet weak var shadowView: UIView!

    @IBOutlet weak var aTeam1: UILabel!
    @IBOutlet weak var aTeam2: UILabel!
    @IBOutlet weak var aTeam3: UILabel!
    @IBOutlet weak var aTeam4: UILabel!
    @IBOutlet weak var aTeam5: UILabel!
    @IBOutlet weak var aTeam6: UILabel!

    @IBOutlet weak var bTeam1: UILabel!
    @IBOutlet weak var bTeam2: UILabel!
    @IBOutlet weak var bTeam3: UILabel!
    @IBOutlet weak var bTeam4: UILabel!
    @IBOutlet weak var bTeam5: UILabel!
    @IBOutlet weak var bTeam6: UILabel!

    @IBOutlet weak var cTeam1: UILabel!
    @IBOutlet weak var cTeam2: UILabel!
    @IBOutlet weak var cTeam3: UILabel!
    @IBOutlet weak var cTeam4: UILabel!
    @IBOutlet weak var cTeam5: UILabel!
    @IBOutlet weak var cTeam6: UILabel!

    @IBOutlet weak var takeARestLabel: UILabel!

    lazy var aTeam: [UILabel] = [aTeam1, aTeam2, aTeam3, aTeam4, aTeam5, aTeam6]
    lazy var bTeam: [UILabel] = [bTeam1, bTeam2, bTeam3, bTeam4, bTeam5, bTeam6]
    lazy var cTeam: [UILabel] = [cTeam1, cTeam2, cTeam3, cTeam4, cTeam5, cTeam6]
    lazy var teams = [aTeam, bTeam, cTeam]

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
        Player(name: "Angus", gender: "Male"),
        Player(name: "Aaron", gender: "Male"),
        Player(name: "Steven", gender: "Male"),
        Player(name: "Jimmy", gender: "Male"),
        Player(name: "品芸", gender: "Female"),
        Player(name: "Jason", gender: "Male"),
        Player(name: "Tim", gender: "Male"),
        Player(name: "Roland", gender: "Male"),
        Player(name: "Elven", gender: "Male")
    ]

    private let playerListTableView = PlayerListTableView(frame: .zero, style: .plain)

    lazy var generateRandomTeamButton: UIButton = {
        let button = UIButton()
        button.setTitle("開始分隊", for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.purple1.cgColor
        button.addTarget(self, action: #selector(generateRandomTeam), for: .touchUpInside)
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

    private var animationView: LottieAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(generateRandomTeamButton)
//        view.addSubview(doneRandonTeamLable)
//        setPlayersTableView()
        shadowView.applyShadow()
        setNavBar()
//        setLayout()
        setAnimate()
        generateRandomTeam()
//        playAnimate()
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

    func setAnimate() {
        animationView = .init(name: "paper_scissor_stone")
        animationView?.frame = view.bounds
        animationView?.backgroundColor = .gray7
        animationView?.contentMode = .scaleAspectFit
        animationView?.isHidden = true
        view.addSubview(animationView!)
    }
    func playAnimate() {
        UIView.transition(with: animationView!, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            self.animationView?.isHidden = false
            self.animationView?.loopMode = .playOnce
            self.animationView?.animationSpeed = 1.0
            self.animationView?.play()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            // Put your code which should be executed with a delay here
            UIView.transition(with: self.animationView!, duration: 0.4,
                              options: .transitionCrossDissolve,
                              animations: {
                self.animationView?.isHidden = true
            })
        }
    }

    @objc func generateRandomTeam() {
        playAnimate()
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

        for i in 0...2 {
            for j in 0...5 {
                teams[i][j].text = groups[i][j].name
                if groups[i][j].gender == "Male" {
                    teams[i][j].textColor = .gray1
                } else {
                    teams[i][j].textColor = .gray2
                }
            }
        }
        let abc = ["A", "B", "C"]
        takeARestLabel.text = "\(abc.shuffled()[0]) 隊先休息"
    }

    func didTapProfileButton(for player: Player) {
        print("Tapped on profile button for \(player.name)")
    }
}
