//
//  PlayInfoView.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/17.
//

import Foundation
import UIKit

class PlayInfoView: UIView {

    var play: Play?

    let lackLable: UILabel = {
        let label = UILabel()
        let padding = 3
//        label.text = String(repeating: " ", count: padding) + "缺\(play.lackAmount.female)女\(play.lackAmount.male)男" + String(repeating: " ", count: padding)
        label.textColor = .purple1
        label.backgroundColor = .purple6
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let startTimeLable: UILabel = {
        let label = UILabel()
//        label.text = "\(dateFormatter.string(from: play.startTime)) ~ \(dateFormatter.string(from: play.endTime))"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let endTimeLable: UILabel = {
        let label = UILabel()
//        label.text = "\(dateFormatter.string(from: play.endTime))"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let placeLabel: UILabel = {
        let label = UILabel()
//        label.text = "place: \(play.place)"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let typeLable: UILabel = {
        let label = UILabel()
//        label.text = playTypes[play.type]
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let priceLable: UILabel = {
        let label = UILabel()
//        label.text = "\(play.price) 元 /人"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let levelLable: UILabel = {
        let label = UILabel()
        label.text = "程度："
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var levelButton: UIButton = {
        let button = UIButton()
//        button.setTitle(levels[play.levelRange.sum], for: .normal)
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

    func setUI() {
        if let play = play {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd EE HH:mm"

            lackLable.text = "   缺\(play.lackAmount.female)女\(play.lackAmount.male)男   "
            startTimeLable.text = "\(dateFormatter.string(from: play.startTime)) ~ \(dateFormatter.string(from: play.endTime))"
            placeLabel.text = "place: \(play.place)"
            typeLable.text = playTypes[play.type]
            priceLable.text = "\(play.price) 元 /人"
            levelButton.setTitle(levelList[play.levelRange.sum], for: .normal)
            if play.levelRange.sum == 0 {
                levelButton.backgroundColor = .purple1
            } else if play.levelRange.sum == 1 {
                levelButton.backgroundColor = .purple3
            } else if play.levelRange.sum == 2 {
                levelButton.backgroundColor = .purple4
            } else if play.levelRange.sum == 3 {
                levelButton.backgroundColor = .purple5
            } else if play.levelRange.sum == 4 {
                levelButton.backgroundColor = .purple7
                levelButton.setTitleColor(.gray2, for: .normal)
            }

            addSubview(lackLable)
            addSubview(startTimeLable)
            // addSubview(endTimeLable)
            addSubview(placeLabel)
            addSubview(priceLable)
            addSubview(typeLable)
            addSubview(levelLable)
            addSubview(levelButton)

            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 130),

                startTimeLable.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
                startTimeLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
                // startTimeLable.trailingAnchor.constraint(equalTo: centerXAnchor),

                // endTimeLable.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
                // endTimeLable.leadingAnchor.constraint(equalTo: centerXAnchor),
                // endTimeLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),

                placeLabel.topAnchor.constraint(equalTo: startTimeLable.bottomAnchor, constant: standardMargin/2),
                placeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
                placeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),

                typeLable.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: standardMargin/2),
                typeLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),

                lackLable.centerYAnchor.constraint(equalTo: typeLable.centerYAnchor),
                lackLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),

                levelLable.topAnchor.constraint(equalTo: typeLable.bottomAnchor, constant: standardMargin/2),
                levelLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),

                levelButton.centerYAnchor.constraint(equalTo: levelLable.centerYAnchor),
                levelButton.leadingAnchor.constraint(equalTo: levelLable.trailingAnchor),
                levelButton.heightAnchor.constraint(equalToConstant: standardMargin*1.7),
                levelButton.widthAnchor.constraint(equalToConstant: standardMargin*1.7),

                priceLable.centerYAnchor.constraint(equalTo: levelLable.centerYAnchor),
                priceLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin)
            ])
        }
    }
}
