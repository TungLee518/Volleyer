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

    @IBOutlet weak var restTeamImageView: UIImageView!
    @IBOutlet weak var takeARestLabel: UILabel!

    lazy var aTeam: [UILabel] = [aTeam1, aTeam2, aTeam3, aTeam4, aTeam5, aTeam6]
    lazy var bTeam: [UILabel] = [bTeam1, bTeam2, bTeam3, bTeam4, bTeam5, bTeam6]
    lazy var cTeam: [UILabel] = [cTeam1, cTeam2, cTeam3, cTeam4, cTeam5, cTeam6]
    lazy var teams = [aTeam, bTeam, cTeam]

    var players: [Player] = []
    var playerUsers: [User] = []
    var shuffledplayerUsers: [[User]] = [[], [], []]

    private var animationView: LottieAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.applyShadow()
        shadowView.backgroundColor = .white
        setNavBar()
        setAnimate()
        playAnimate()
        generateRandomTeamWithLevel()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.randomTeam.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .purple2
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
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

    func generateRandomTeamWithLevel() {
        calculateMaxAverageLevelDifference(players: playerUsers)
        putNameIntoLabels(players: shuffledplayerUsers)
    }
    func calculateMaxAverageLevelDifference(players: [User]) -> Double {
        var groups: [[User]] = [[], [], []]
        while true {
            // Shuffle the players array randomly
            var shuffledPlayers = players.shuffled()
            // 照男女排序
            shuffledPlayers.sort { $0.gender < $1.gender }
            // Create an array to hold the groups
            groups = [[], [], []]
            var levelSum: [Double] = [0, 0, 0]
            var totalNumber = 0
            var nthTotal = totalNumber % 3
            for player in shuffledPlayers {
                groups[nthTotal].append(player)
                let playerAve = (Double(player.level.setBall) + Double(player.level.block) + Double(player.level.dig) + Double(player.level.spike) + Double(player.level.sum)) / 5.0
                print(player.id, playerAve)
                levelSum[nthTotal] += playerAve
                totalNumber += 1
                nthTotal = totalNumber % 3
            }
            // 擺完後計算每對平均程度
            let levelAve = levelSum.map { $0 / 6 }
            print(levelAve)
            let aveDiffs = [abs(levelAve[0]-levelAve[1]), abs(levelAve[2]-levelAve[1]), abs(levelAve[0]-levelAve[2])]
            let maxAveDiff = aveDiffs.max() ?? -1
            shuffledplayerUsers = groups
            // 如果差 0.5 個等級就重分
            if maxAveDiff < 0.5 {
                return maxAveDiff
            }
        }
    }
    func putNameIntoLabels(players: [[User]]) {
        // 完成分隊後放入 labels
        for i in 0...2 {
            for j in 0...5 {
                teams[i][j].text = "  \(players[i][j].name)  "
                if players[i][j].gender == 0 {
                    teams[i][j].textColor = .gray2
                    teams[i][j].backgroundColor = UIColor.hexStringToUIColor(hex: "#D6EAF6")
                    teams[i][j].layer.cornerRadius = 10
                    teams[i][j].layer.borderColor = UIColor.hexStringToUIColor(hex: "#D6EAF6").cgColor
                    teams[i][j].layer.borderWidth = 2
                    teams[i][j].clipsToBounds = true
                } else {
                    teams[i][j].textColor = .gray2
                    teams[i][j].backgroundColor = UIColor.hexStringToUIColor(hex: "#F6DED9")
                    teams[i][j].layer.cornerRadius = 10
                    teams[i][j].layer.borderColor = UIColor.hexStringToUIColor(hex: "#F6DED9").cgColor
                    teams[i][j].layer.borderWidth = 2
                    teams[i][j].clipsToBounds = true
                }
            }
        }
        // 隨機選一隊先休息
        let imageNames = ["a", "b", "c"]
        restTeamImageView.image = UIImage(named: imageNames.shuffled()[0])
    }
}
