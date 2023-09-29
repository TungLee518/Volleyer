//
//  PlayOneFinderViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/25.
//

import UIKit
import Kingfisher

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
        changeButtonUI(takePlayer2PhotoButton)
        changeButtonUI(takePlayer3PhotoButton)
        changeButtonUI(takePlayer4PhotoButton)
        changeButtonUI(takePlayer5PhotoButton)
        dataManager.playOneFinderDataDelegate = self
        setNavBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataManager.getPlayOneFinderData(finder: finderInfo?.id ?? "")
    }

    @IBAction func inputPlayer1Info(_ sender: Any) {
        let nextVC = CameraViewController()
        nextVC.playerN = "player1"
        nextVC.finderInfo = finderInfo
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @IBAction func inputPlayer2Info(_ sender: Any) {
        let nextVC = CameraViewController()
        nextVC.playerN = "player2"
        nextVC.finderInfo = finderInfo
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @IBAction func inputPlayer3Info(_ sender: Any) {
        let nextVC = CameraViewController()
        nextVC.playerN = "player3"
        nextVC.finderInfo = finderInfo
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @IBAction func inputPlayer4Info(_ sender: Any) {
        let nextVC = CameraViewController()
        nextVC.playerN = "player4"
        nextVC.finderInfo = finderInfo
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @IBAction func inputPlayer5Info(_ sender: Any) {
        let nextVC = CameraViewController()
        nextVC.playerN = "player5"
        nextVC.finderInfo = finderInfo
        navigationController?.pushViewController(nextVC, animated: true)
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        navigationItem.title = ""
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .purple2
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
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
        print("----", fivePlayersData)
        let fiveImageView = [player1ImageView, player2ImageView, player3ImageView, player4ImageView, player5ImageView]
        let fiveNameLabel = [player1NameLabel, player2NameLabel, player3NameLabel, player4NameLabel, player5NameLabel]
        var imageUrls: [URL?] = []
        for i in 0..<5 {
            if fivePlayersData[i].name == "" {
                fiveNameLabel[i]?.text = "目前沒人"
            } else {
                fiveNameLabel[i]?.text = fivePlayersData[i].name
            }
            if let playerImageUrl = URL(string: fivePlayersData[i].image) {
                print("第\(i)個有照片:", playerImageUrl)
                imageUrls.append(playerImageUrl)
                fiveImageView[i]?.kf.setImage(with: playerImageUrl)
            } else {
                imageUrls.append(nil)
            }
        }
        
        

//        if let imageUrl = imageUrls[1] {
//            let request = URLRequest(url: imageUrl)
//            let task = URLSession.shared.dataTask(with: request) { [weak self] (imageData, _, err) in
//                guard let imageData = imageData, err == nil else {
//                    print("image error: ", err)
//                    return
//                }
//                DispatchQueue.main.async {
//                    self?.player2ImageView.image = UIImage(data: imageData)
//                }
//            }
//            task.resume()
//        }
    }
}
