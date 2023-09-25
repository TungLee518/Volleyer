//
//  PlayOneTableViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/24.
//

import UIKit

class PlayOneTableViewCell: UITableViewCell {

    @IBOutlet weak var playOneCollectionView: UICollectionView!

    var playOneFinderData: [User] = []
    var playOneData: [PlayOne] = []

    var tapAFinder: ((IndexPath) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        playOneCollectionView.dataSource = self
        playOneCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension PlayOneTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        playOneFinderData.count
        playOneData[playOneCollectionView.tag].finders.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = playOneCollectionView.dequeueReusableCell(withReuseIdentifier: "PlayOneCollectionViewCell", for: indexPath) as! PlayOneCollectionViewCell
//        cell.accountImageView.image = UIImage(named: "placeholder")
        // swiftlint:enable force_cast
        cell.accountLabel.text = playOneData[playOneCollectionView.tag].finders[indexPath.row].id
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapAFinder?(indexPath)
    }
}
