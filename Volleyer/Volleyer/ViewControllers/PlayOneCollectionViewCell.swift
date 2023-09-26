//
//  PlayOneCollectionViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/24.
//

import UIKit

class PlayOneCollectionViewCell: UICollectionViewCell {

    var thisFinder: User?

    @IBOutlet weak var accountImageView: UIImageView!
    @IBOutlet weak var accountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        accountImageView.layer.cornerRadius = accountImageView.frame.height / 2
        accountLabel.font = .regularNunito(size: 16)
    }
}
