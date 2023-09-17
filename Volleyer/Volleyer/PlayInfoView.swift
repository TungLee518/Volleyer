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

    func setUI() {
        if let play = play {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd EE HH:mm"

            let lackLable: UILabel = {
                let label = UILabel()
                let padding = 3
                label.text = String(repeating: " ", count: padding) + "缺3女" + String(repeating: " ", count: padding)
                label.textColor = UIColor.systemBlue
                label.backgroundColor = UIColor.lightGray
                label.layer.cornerRadius = 5
                label.clipsToBounds = true
                label.font = UIFont.boldSystemFont(ofSize: 16)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let startTimeLable: UILabel = {
                let label = UILabel()
                label.text = "\(dateFormatter.string(from: play.startTime)) ~ \(dateFormatter.string(from: play.endTime))"
                label.textColor = UIColor.gray
                label.font = UIFont.systemFont(ofSize: 16)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let endTimeLable: UILabel = {
                let label = UILabel()
                label.text = "\(dateFormatter.string(from: play.endTime))"
                label.textColor = UIColor.gray
                label.font = UIFont.systemFont(ofSize: 16)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let placeLabel: UILabel = {
                let label = UILabel()
                label.text = play.place
                label.textColor = UIColor.black
                label.font = UIFont.systemFont(ofSize: 16)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let typeLable: UILabel = {
                let label = UILabel()
                label.text = playTypes[play.type]
                label.textColor = UIColor.black
                label.font = UIFont.systemFont(ofSize: 16)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            let priceLable: UILabel = {
                let label = UILabel()
                label.text = "\(play.price) 元 /人"
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
                button.setTitle("B", for: .normal)
                button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
                button.titleLabel?.textAlignment = .center
                button.backgroundColor = UIColor.orange
                button.translatesAutoresizingMaskIntoConstraints = false
                // button.addTarget(self, action: #selector(showLevelDetail), for: .touchUpInside)
                button.layer.cornerRadius = standardMargin / 2
                button.clipsToBounds = true
                return button
            }()
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
                levelButton.heightAnchor.constraint(equalToConstant: standardMargin),
                levelButton.widthAnchor.constraint(equalToConstant: standardMargin),

                priceLable.centerYAnchor.constraint(equalTo: levelLable.centerYAnchor),
                priceLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin)
            ])
        }
    }
}
