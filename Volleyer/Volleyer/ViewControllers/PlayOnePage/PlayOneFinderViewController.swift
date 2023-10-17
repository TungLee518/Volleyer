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

    @IBOutlet weak var player1ImageView: UIImageView! {
        didSet {
            self.player1ImageView.tappable = true
        }
    }
    @IBOutlet weak var player2ImageView: UIImageView! {
        didSet {
            self.player2ImageView.tappable = true
        }
    }
    @IBOutlet weak var player3ImageView: UIImageView! {
        didSet {
            self.player3ImageView.tappable = true
        }
    }
    @IBOutlet weak var player4ImageView: UIImageView! {
        didSet {
            self.player4ImageView.tappable = true
        }
    }
    @IBOutlet weak var player5ImageView: UIImageView! {
        didSet {
            self.player5ImageView.tappable = true
        }
    }

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
        LKProgressHUD.show()
        titleLabel.text = court
        if let finderInfo = finderInfo {
            finderAccountLabel.text = finderInfo.id
            finderImageView.kf.setImage(with: URL(string: finderInfo.image))
            finderImageView.layer.cornerRadius = 35
            if finderInfo.firebaseId != UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) {
                takePlayer1PhotoButton.isHidden = true
                takePlayer2PhotoButton.isHidden = true
                takePlayer3PhotoButton.isHidden = true
                takePlayer4PhotoButton.isHidden = true
                takePlayer5PhotoButton.isHidden = true
            }
        }
        changeButtonUI(takePlayer1PhotoButton)
        changeButtonUI(takePlayer2PhotoButton)
        changeButtonUI(takePlayer3PhotoButton)
        changeButtonUI(takePlayer4PhotoButton)
        changeButtonUI(takePlayer5PhotoButton)
        dataManager.playOneFinderDataDelegate = self
        setNavBar()
        self.player1ImageView.callback = {
            self.enlargeImage(self.player1ImageView)
        }
        self.player2ImageView.callback = {
            self.enlargeImage(self.player2ImageView)
        }
        self.player3ImageView.callback = {
            self.enlargeImage(self.player3ImageView)
        }
        self.player4ImageView.callback = {
            self.enlargeImage(self.player4ImageView)
        }
        self.player5ImageView.callback = {
            self.enlargeImage(self.player5ImageView)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataManager.getPlayOneFinderData(finder: finderInfo?.firebaseId ?? "")
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

    func enlargeImage(_ imageView: UIImageView) {
        view.bringSubviewToFront(imageView)
        if imageView.frame.size.width == self.view.frame.size.width {
            // If the image is already enlarged, shrink it back to its original size
            UIView.animate(withDuration: 0.3) {
//                imageView.transform = CGAffineTransform.identity
                let translation = CGPoint(x: 0, y: -0)
                let scaledTransform = CGAffineTransform.identity
                let translatedTransform = scaledTransform.translatedBy(x: translation.x, y: translation.y)
                imageView.transform = translatedTransform
            }
        } else {
            // If the image is not enlarged, make it larger
            UIView.animate(withDuration: 0.3) {
                let scale = self.view.frame.size.width / imageView.frame.size.width
                let goToCenterX = (self.view.frame.midX - imageView.frame.midX)/scale
                let goToCenterY = (self.view.frame.midY - imageView.frame.midY)/scale
                let translation = CGPoint(x: goToCenterX, y: goToCenterY) // Adjust these values as needed
                let scaledTransform = CGAffineTransform(scaleX: scale, y: scale)
                let translatedTransform = scaledTransform.translatedBy(x: translation.x, y: translation.y)
                imageView.transform = translatedTransform
            }
        }
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
        LKProgressHUD.dismiss()
    }
}
