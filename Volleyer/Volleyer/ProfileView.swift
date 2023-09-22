//
//  ProfileView.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/22.
//

import Foundation
import UIKit

class ProfileView: UIView {

    var thisUser: UserData? 
    
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
        label.text = "id"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let nameLable: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let genderLable: UILabel = {
        let label = UILabel()
        label.text = "gender"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let levelLable: UILabel = {
        let label = UILabel()
        label.text = "Level"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let setLable: UILabel = {
        let label = UILabel()
        label.text = "set: X"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let spikeLable: UILabel = {
        let label = UILabel()
        label.text = "spike: X"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let digLable: UILabel = {
        let label = UILabel()
        label.text = "dig: X"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let blockLable: UILabel = {
        let label = UILabel()
        label.text = "block: X"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let sumLable: UILabel = {
        let label = UILabel()
        label.text = "sum: X"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setContent() {
        if let thisUser = thisUser {
            accountLable.text = thisUser.id
            nameLable.text = thisUser.name
            genderLable.text = genderList[thisUser.gender]
            setLable.text = "Set: \(levelList[thisUser.level.setBall])"
            spikeLable.text = "Spike: \(levelList[thisUser.level.spike])"
            digLable.text = "Dig: \(levelList[thisUser.level.dig])"
            blockLable.text = "Block: \(levelList[thisUser.level.block])"
            sumLable.text = "Sum: \(levelList[thisUser.level.sum])"
            
            addSubview(photoImageView)
            addSubview(accountLable)
            addSubview(nameLable)
            addSubview(genderLable)
            addSubview(levelLable)
            addSubview(setLable)
            addSubview(spikeLable)
            addSubview(digLable)
            addSubview(blockLable)
            addSubview(sumLable)

            setLayout()
        }
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 250),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            photoImageView.heightAnchor.constraint(equalToConstant: photoHeight),
            photoImageView.widthAnchor.constraint(equalToConstant: photoHeight),

            accountLable.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: standardMargin),
            accountLable.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),

            nameLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            nameLable.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: standardMargin),

            genderLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            genderLable.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: standardMargin),

            levelLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            levelLable.topAnchor.constraint(equalTo: genderLable.bottomAnchor, constant: standardMargin),

            setLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            setLable.topAnchor.constraint(equalTo: levelLable.bottomAnchor, constant: standardMargin),

            spikeLable.leadingAnchor.constraint(equalTo: setLable.trailingAnchor, constant: standardMargin),
            spikeLable.topAnchor.constraint(equalTo: levelLable.bottomAnchor, constant: standardMargin),

            digLable.leadingAnchor.constraint(equalTo: spikeLable.trailingAnchor, constant: standardMargin),
            digLable.topAnchor.constraint(equalTo: levelLable.bottomAnchor, constant: standardMargin),

            blockLable.leadingAnchor.constraint(equalTo: digLable.trailingAnchor, constant: standardMargin),
            blockLable.topAnchor.constraint(equalTo: levelLable.bottomAnchor, constant: standardMargin),

            sumLable.leadingAnchor.constraint(equalTo: blockLable.trailingAnchor, constant: standardMargin),
            sumLable.topAnchor.constraint(equalTo: levelLable.bottomAnchor, constant: standardMargin)
        ])
    }
}
