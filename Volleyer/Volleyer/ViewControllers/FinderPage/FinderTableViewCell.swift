//
//  FindPlayerTableViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/14.
//

import Foundation
import UIKit
import Kingfisher

class FinderTableViewCell: UITableViewCell {

    static let identifier = "PlayInfoTableViewCell"

    weak var parent: FinderViewController?

    lazy var courtImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "court")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let lackLable: UILabel = {
        let label = UILabel()
        let padding = 3
        label.textColor = .purple1
        label.backgroundColor = .purple6
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var calanderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "calendar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let startTimeLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray2
        label.font = .semiboldNunito(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let endTimeLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray2
        label.font = .semiboldNunito(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "location")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let placeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray2
        label.font = .regularNunito(size: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let typeLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray2
        label.font = .regularNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let setLevelLable: UILabel = {
        let label = UILabel()
        let padding = 3
        label.text = "No"
        label.textColor = .purple3
        label.backgroundColor = .purple7
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let blockLevelLable: UILabel = {
        let label = UILabel()
        let padding = 3
        label.text = "No"
        label.textColor = .purple3
        label.backgroundColor = .purple6
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let digLevelLable: UILabel = {
        let label = UILabel()
        let padding = 3
        label.text = "No"
        label.textColor = .purple7
        label.backgroundColor = .purple5
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let spikeLevelLable: UILabel = {
        let label = UILabel()
        let padding = 3
        label.text = "No"
        label.textColor = .purple7
        label.backgroundColor = .purple4
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let sumLevelLable: UILabel = {
        let label = UILabel()
        let padding = 3
        label.text = "No"
        label.textColor = .purple7
        label.backgroundColor = .purple3
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let priceLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray1
        label.font = .regularNunito(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var levelButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.orange
        button.setTitleColor(.gray6, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        // button.addTarget(self, action: #selector(showLevelDetail), for: .touchUpInside)
        button.layer.cornerRadius = standardMargin*1.7/2
        button.clipsToBounds = true
        return button
    }()
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.layer.cornerRadius = photoHeight / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let accountLable: UILabel = {
        let label = UILabel()
        label.text = "maymmm518"
        label.textColor = .gray1
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

//    private var playView = PlayInfoView()
    var thisPlay: Play? {
        didSet {
//            sendDataToPlayView(thisPlay!)
            setContent()
            
//            photoImageView.image = UIImage(named: )
            if thisPlay?.finderId == UserDefaults.standard.string(forKey: UserTitle.id.rawValue) {
                wantToAddImageView.isHidden = true
            } else {
                wantToAddImageView.isHidden = false
            }
        }
    }

    lazy var wantToAddButton: UIButton = {
        let button = UIButton()
        button.setTitle("我要加", for: .normal)
        button.titleLabel?.font =  .semiboldNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .purple1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addPlay), for: .touchUpInside)
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        return button
    }()
    lazy var wantToAddImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "invitation")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(courtImageView)
        contentView.addSubview(calanderImageView)
        contentView.addSubview(startTimeLable)
        contentView.addSubview(endTimeLable)
        contentView.addSubview(placeImageView)
        contentView.addSubview(placeLabel)
        contentView.addSubview(typeLable)
        contentView.addSubview(setLevelLable)
        contentView.addSubview(blockLevelLable)
        contentView.addSubview(digLevelLable)
        contentView.addSubview(spikeLevelLable)
        contentView.addSubview(sumLevelLable)
        contentView.addSubview(priceLable)
//        contentView.addSubview(playView)
//        playView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(photoImageView)
        contentView.addSubview(accountLable)
        contentView.addSubview(wantToAddImageView)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setContent() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd EE HH:mm"
        if let thisPlay = thisPlay {
            lackLable.text = "   缺\(thisPlay.lackAmount.female)女\(thisPlay.lackAmount.male)男   "
            startTimeLable.text = dateFormatter.string(from: thisPlay.startTime)
            endTimeLable.text = dateFormatter.string(from: thisPlay.endTime)
            placeLabel.text = thisPlay.place
            typeLable.text = playTypes[thisPlay.type]
            setLevelLable.text = "  \(levelList[thisPlay.levelRange.setBall])  "
            spikeLevelLable.text = "  \(levelList[thisPlay.levelRange.spike])  "
            digLevelLable.text = "  \(levelList[thisPlay.levelRange.dig])  "
            blockLevelLable.text = "  \(levelList[thisPlay.levelRange.block])  "
            sumLevelLable.text = "  \(levelList[thisPlay.levelRange.sum])  "
            priceLable.text = "\(thisPlay.price) 元 /人"
            accountLable.text = thisPlay.finderId
            DataManager.sharedDataMenager.getImageFromUserId(id: thisPlay.finderId) { imageUrl, err in
                if let error = err {
                    // Handle the error
                    print("Error: \(error)")
                } else if let imageUrl = imageUrl {
                    // Use the imageUrl
                    print("Image URL: \(imageUrl)")
                    self.photoImageView.kf.setImage(with: URL(string: imageUrl))
                } else {
                    // Handle the case where no matching document was found
                    print("No matching document found")
                }
            }
        }
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            courtImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            courtImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            courtImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            courtImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            courtImageView.heightAnchor.constraint(equalTo: courtImageView.widthAnchor, multiplier: 1.5),

            calanderImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin*4.2),
            calanderImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin*5),
            calanderImageView.heightAnchor.constraint(equalToConstant: 40),
            calanderImageView.widthAnchor.constraint(equalTo: calanderImageView.heightAnchor, multiplier: 1),
            startTimeLable.centerYAnchor.constraint(equalTo: calanderImageView.topAnchor),
            startTimeLable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: standardMargin*1.2),
            endTimeLable.centerYAnchor.constraint(equalTo: calanderImageView.bottomAnchor),
            endTimeLable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: standardMargin*1.2),
            placeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin*4.2),
            placeImageView.topAnchor.constraint(equalTo: calanderImageView.bottomAnchor, constant: standardMargin*2),
            placeImageView.heightAnchor.constraint(equalToConstant: 40),
            placeImageView.widthAnchor.constraint(equalTo: calanderImageView.heightAnchor, multiplier: 1),
//            placeLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: standardMargin),
            placeLabel.centerXAnchor.constraint(equalTo: endTimeLable.centerXAnchor),
//            placeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin*4.7),
            placeLabel.centerYAnchor.constraint(equalTo: placeImageView.centerYAnchor),
            typeLable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            typeLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -standardMargin*2),
            digLevelLable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            digLevelLable.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: standardMargin*2),

            blockLevelLable.trailingAnchor.constraint(equalTo: digLevelLable.leadingAnchor, constant: -standardMargin),
            blockLevelLable.centerYAnchor.constraint(equalTo: digLevelLable.centerYAnchor),

            setLevelLable.trailingAnchor.constraint(equalTo: blockLevelLable.leadingAnchor, constant: -standardMargin),
            setLevelLable.centerYAnchor.constraint(equalTo: digLevelLable.centerYAnchor),

            spikeLevelLable.leadingAnchor.constraint(equalTo: digLevelLable.trailingAnchor, constant: standardMargin),
            spikeLevelLable.centerYAnchor.constraint(equalTo: digLevelLable.centerYAnchor),

            sumLevelLable.leadingAnchor.constraint(equalTo: spikeLevelLable.trailingAnchor, constant: standardMargin),
            sumLevelLable.centerYAnchor.constraint(equalTo: digLevelLable.centerYAnchor),

            priceLable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            priceLable.bottomAnchor.constraint(equalTo: accountLable.topAnchor, constant: -standardMargin*2),

            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin*4.2),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin*4.5),
            photoImageView.heightAnchor.constraint(equalToConstant: photoHeight),
            photoImageView.widthAnchor.constraint(equalToConstant: photoHeight),

            accountLable.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: standardMargin),
            accountLable.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),

            wantToAddImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin*4.7),
            wantToAddImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin*4.6),
            wantToAddImageView.heightAnchor.constraint(equalToConstant: 40),
            wantToAddImageView.widthAnchor.constraint(equalTo: wantToAddImageView.heightAnchor, multiplier: 1)
        ])
    }

//    func sendDataToPlayView(_ data: Play) {
//        playView.play = thisPlay
//        playView.setUI()
//    }

    @objc func addPlay() {
        let nextVC = AddPlayViewController()
        nextVC.thisPlay = thisPlay
        parent?.navigationController?.pushViewController(nextVC, animated: true)
    }
}
