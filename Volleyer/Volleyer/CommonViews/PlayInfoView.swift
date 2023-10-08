//
//  PlayInfoView.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/17.
//

import Foundation
import UIKit

class PlayInfoView: UIView {

    var thisPlay: Play? {
        didSet {
            setUI()
        }
    }

    let typeLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray1
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.layer.cornerRadius = photoHeight / 4
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let accountLable: UILabel = {
        let label = UILabel()
        label.text = "maymmm518"
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let startTimeLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray2
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let endTimeLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray2
        label.font = .semiboldNunito(size: 16)
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
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var priceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dollar")
        imageView.tintColor = .gray2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let priceLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var maleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "male")
        imageView.tintColor = .gray2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let maleLackLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var femaleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "female")
        imageView.tintColor = .gray2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let femaleLackLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let setView: LevelView = {
        let view = LevelView()
        view.markLabel.text = positions[0]
        view.backgroundColor = .purple6
        view.levelLabel.textColor = .gray2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let blockView: LevelView = {
        let view = LevelView()
        view.markLabel.text = positions[1]
        view.backgroundColor = .purple6
        view.levelLabel.textColor = .gray2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let digView: LevelView = {
        let view = LevelView()
        view.markLabel.text = positions[2]
        view.backgroundColor = .purple6
        view.levelLabel.textColor = .gray2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let spikeView: LevelView = {
        let view = LevelView()
        view.markLabel.text = positions[3]
        view.backgroundColor = .purple6
        view.levelLabel.textColor = .gray2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let sumView: LevelView = {
        let view = LevelView()
        view.markLabel.text = positions[4]
        view.backgroundColor = .purple6
        view.levelLabel.textColor = .gray2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    func setUI() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd EE HH:mm"

        if let thisPlay = thisPlay {
            startTimeLable.text = dateFormatter.string(from: thisPlay.startTime)
            endTimeLable.text = dateFormatter.string(from: thisPlay.endTime)
            placeLabel.text = thisPlay.place
            typeLable.text = playTypes[thisPlay.type]
            maleLackLable.text = String(thisPlay.lackAmount.male)
            femaleLackLable.text = String(thisPlay.lackAmount.female)
            setView.thisLevel = thisPlay.levelRange.setBall
            blockView.thisLevel = thisPlay.levelRange.block
            digView.thisLevel = thisPlay.levelRange.dig
            spikeView.thisLevel = thisPlay.levelRange.spike
            sumView.thisLevel = thisPlay.levelRange.sum
            priceLable.text = "\(thisPlay.price) 元 /人"
            accountLable.text = thisPlay.finderId
            FinderDataManager.sharedDataMenager.getImageFromUserId(id: thisPlay.finderId) { imageUrl, err in
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
//        addSubview(photoImageView)
//        addSubview(accountLable)
        addSubview(startTimeLable)
        addSubview(endTimeLable)
        addSubview(placeImageView)
        addSubview(placeLabel)
        addSubview(typeLable)
        addSubview(priceImageView)
        addSubview(priceLable)
        addSubview(maleImageView)
        addSubview(maleLackLable)
        addSubview(femaleImageView)
        addSubview(femaleLackLable)
        addSubview(setView)
        addSubview(blockView)
        addSubview(digView)
        addSubview(spikeView)
        addSubview(sumView)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            typeLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            typeLable.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            startTimeLable.topAnchor.constraint(equalTo: typeLable.bottomAnchor, constant: standardMargin/2),
            startTimeLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            endTimeLable.topAnchor.constraint(equalTo: startTimeLable.bottomAnchor, constant: standardMargin/4),
            endTimeLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            placeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            placeImageView.topAnchor.constraint(equalTo: endTimeLable.bottomAnchor, constant: standardMargin),
            placeImageView.heightAnchor.constraint(equalToConstant: 20),
            placeImageView.widthAnchor.constraint(equalTo: placeImageView.heightAnchor, multiplier: 1),
            placeLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: standardMargin),
            placeLabel.centerYAnchor.constraint(equalTo: placeImageView.centerYAnchor),

            priceImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            priceImageView.topAnchor.constraint(equalTo: placeImageView.bottomAnchor, constant: standardMargin/2),
            priceImageView.heightAnchor.constraint(equalToConstant: 20),
            priceImageView.widthAnchor.constraint(equalTo: placeImageView.heightAnchor, multiplier: 1),
            priceLable.leadingAnchor.constraint(equalTo: priceImageView.trailingAnchor, constant: standardMargin),
            priceLable.centerYAnchor.constraint(equalTo: priceImageView.centerYAnchor),

            maleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            maleImageView.topAnchor.constraint(equalTo: priceImageView.bottomAnchor, constant: standardMargin/2),
            maleImageView.heightAnchor.constraint(equalToConstant: 20),
            maleImageView.widthAnchor.constraint(equalTo: placeImageView.heightAnchor, multiplier: 1),
            maleLackLable.leadingAnchor.constraint(equalTo: maleImageView.trailingAnchor, constant: standardMargin),
            maleLackLable.centerYAnchor.constraint(equalTo: maleImageView.centerYAnchor),
            femaleImageView.leadingAnchor.constraint(equalTo: maleLackLable.trailingAnchor, constant: standardMargin*2),
            femaleImageView.centerYAnchor.constraint(equalTo: maleImageView.centerYAnchor),
            femaleImageView.heightAnchor.constraint(equalToConstant: 20),
            femaleImageView.widthAnchor.constraint(equalTo: placeImageView.heightAnchor, multiplier: 1),
            femaleLackLable.leadingAnchor.constraint(equalTo: femaleImageView.trailingAnchor, constant: standardMargin),
            femaleLackLable.centerYAnchor.constraint(equalTo: maleImageView.centerYAnchor),

            digView.topAnchor.constraint(equalTo: maleImageView.bottomAnchor, constant: standardMargin),
            digView.centerXAnchor.constraint(equalTo: centerXAnchor),
            digView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
            setView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            setView.centerYAnchor.constraint(equalTo: digView.centerYAnchor),
            blockView.centerYAnchor.constraint(equalTo: digView.centerYAnchor),
            blockView.leadingAnchor.constraint(equalTo: setView.trailingAnchor, constant: standardMargin),
            blockView.trailingAnchor.constraint(equalTo: digView.leadingAnchor, constant: -standardMargin),
            spikeView.centerYAnchor.constraint(equalTo: digView.centerYAnchor),
            spikeView.leadingAnchor.constraint(equalTo: digView.trailingAnchor, constant: standardMargin),
            sumView.leadingAnchor.constraint(equalTo: spikeView.trailingAnchor, constant: standardMargin),
            sumView.centerYAnchor.constraint(equalTo: digView.centerYAnchor),
            sumView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin)
        ])
        self.addConstraint(NSLayoutConstraint(item: setView, attribute: .width, relatedBy: .equal, toItem: digView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: blockView, attribute: .width, relatedBy: .equal, toItem: digView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: spikeView, attribute: .width, relatedBy: .equal, toItem: digView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: sumView, attribute: .width, relatedBy: .equal, toItem: digView, attribute: .width, multiplier: 1.0, constant: 0.0))
    }
}
