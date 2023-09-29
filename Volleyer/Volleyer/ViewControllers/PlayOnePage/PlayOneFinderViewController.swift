//
//  PlayOneFinderViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/25.
//

import UIKit

class PlayOneFinderViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var finderImageView: UIImageView!
    @IBOutlet weak var finderAccountLabel: UILabel!

    @IBOutlet weak var takePlayer1PhotoButton: UIButton!
    @IBOutlet weak var takePlayer2PhotoButton: UIButton!
    @IBOutlet weak var takePlayer3PhotoButton: UIButton!
    @IBOutlet weak var takePlayer4PhotoButton: UIButton!
    @IBOutlet weak var takePlayer5PhotoButton: UIButton!

    @IBOutlet weak var player1ImageView: UIImageView!
    @IBOutlet weak var player2ImageView: UIImageView!
    @IBOutlet weak var player3ImageView: UIImageView!
    @IBOutlet weak var player4ImageView: UIImageView!
    @IBOutlet weak var player5ImageView: UIImageView!
    
    @IBOutlet weak var player1NameLabel: UILabel!
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var player3NameLabel: UILabel!
    @IBOutlet weak var player4NameLabel: UILabel!
    @IBOutlet weak var player5NameLabel: UILabel!
    
    var finderInfo: User?
    var court = "場X play x"

    var player1Data: PlayerN?
    var player2Data: PlayerN?
    var player3Data: PlayerN?
    var player4Data: PlayerN?
    var player5Data: PlayerN?
    var fivePlayersData: [PlayerN] = []
    let dataManager = PlayOneDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = court
        finderAccountLabel.text = finderInfo?.id
        finderImageView.image = UIImage(named: finderInfo?.id ?? "placeholder")
        finderImageView.layer.cornerRadius = 35
        changeButtonUI(takePlayer1PhotoButton)
        dataManager.playOneFinderDataDelegate = self
        dataManager.getPlayOneFinderData(finder: finderInfo?.id ?? "")
    }

    @IBAction func inputPlayer1Info(_ sender: Any) {
        let nextVC = CameraViewController()
        nextVC.playerN = "player1"
        nextVC.finderInfo = finderInfo
        present(nextVC, animated: true)
    }

    @IBAction func inputPlayer2Info(_ sender: Any) {
        let nextVC = CameraViewController()
        nextVC.playerN = "player2"
        nextVC.finderInfo = finderInfo
        present(nextVC, animated: true)
    }

    @IBAction func inputPlayer3Info(_ sender: Any) {
        let nextVC = CameraViewController()
        nextVC.playerN = "player3"
        nextVC.finderInfo = finderInfo
        present(nextVC, animated: true)
    }

    @IBAction func inputPlayer4Info(_ sender: Any) {
        let nextVC = CameraViewController()
        nextVC.playerN = "player4"
        nextVC.finderInfo = finderInfo
        present(nextVC, animated: true)
    }

    @IBAction func inputPlayer5Info(_ sender: Any) {
        let nextVC = CameraViewController()
        nextVC.playerN = "player5"
        nextVC.finderInfo = finderInfo
        present(nextVC, animated: true)
    }

    func changeButtonUI(_ button: UIButton) {
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .purple6
        button.setTitleColor(.purple1, for: .normal)
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
    }
}

extension PlayOneFinderViewController: PlayOneFinderDataManagerDelegate {
    func manager(_ manager: PlayOneDataManager, didget playerN: [PlayerN]) {
        fivePlayersData = playerN
        guard let player3ImageUrl = URL(string: fivePlayersData[3].image) else {
            return
        }
        URLSession.shared.dataTask(with: player3ImageUrl) { imageData, _, err in
            guard let image3Data = imageData, err == nil else {
                return
            }
            DispatchQueue.main.async {
                self.player3ImageView.image = UIImage(data: image3Data)
            }
        }
    }
}
