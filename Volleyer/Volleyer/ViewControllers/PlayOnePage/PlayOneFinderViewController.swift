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
    @IBOutlet weak var playerView: UIView!

    @IBOutlet weak var takePlayer1PhotoButton: UIButton!
    @IBOutlet weak var takePlayer2PhotoButton: UIButton!
    @IBOutlet weak var takePlayer3PhotoButton: UIButton!
    @IBOutlet weak var takePlayer4PhotoButton: UIButton!
    @IBOutlet weak var takePlayer5PhotoButton: UIButton!

    var finderInfo: User?
    var court = "場X play x"

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = court
        finderAccountLabel.text = finderInfo?.id
        finderImageView.image = UIImage(named: finderInfo?.id ?? "placeholder")
        finderImageView.layer.cornerRadius = 35
        changeButtonUI(takePlayer1PhotoButton)
    }

    @IBAction func takePlayer1Photo(_ sender: Any) {
        let nextVC = CameraViewController()
//        nextVC.modalPresentationStyle = .fullScreen
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
