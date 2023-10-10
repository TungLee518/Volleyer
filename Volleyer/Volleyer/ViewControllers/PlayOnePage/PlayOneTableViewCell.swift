//
//  PlayOneTableViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/24.
//

import UIKit
import Kingfisher

class PlayOneTableViewCell: UITableViewCell {
    lazy var photoImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "blow")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    private let noDataLabel: UILabel = {
        let label = UILabel()
        label.text = "目前沒有 play"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    @IBOutlet weak var playOneCollectionView: UICollectionView!

    var playOneFinderData: [User] = []
    var playOneData: [PlayOne] = [] {
        didSet {
            if playOneFinderData.count == 0 {
                photoImageView.isHidden = false
                noDataLabel.isHidden = false
                playOneCollectionView.isHidden = true
            } else {
                photoImageView.isHidden = true
                noDataLabel.isHidden = true
                playOneCollectionView.isHidden = false
                playOneCollectionView.reloadData()
            }
        }
    }

    var tapAFinder: ((IndexPath) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        playOneCollectionView.dataSource = self
        playOneCollectionView.delegate = self
        setImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setImageView() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(noDataLabel)
        NSLayoutConstraint.activate([
            photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 50),
            photoImageView.heightAnchor.constraint(equalToConstant: 50),
            noDataLabel.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            noDataLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: standardMargin)
        ])
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
        // swiftlint:enable force_cast
        cell.accountLabel.text = playOneData[playOneCollectionView.tag].finders[indexPath.row].id
        cell.accountImageView.kf.setImage(with: URL(string: playOneFinderData[indexPath.row].image))
        cell.thisFinder = playOneFinderData[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapAFinder?(indexPath)
    }
}
