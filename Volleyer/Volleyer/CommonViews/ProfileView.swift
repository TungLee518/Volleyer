//
//  ProfileView.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/22.
//

import Foundation
import UIKit
import Kingfisher

class ProfileView: UIView {

    var thisUser: User? {
        didSet {
            setView()
        }
    }

    let dataManager = MyDataManager()
    weak var parent: UIViewController?

    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: UserDefaults.standard.string(forKey: UserTitle.id.rawValue) ?? "placeholder")
        imageView.layer.cornerRadius = photoHeight/2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let accountLable: UILabel = {
        let label = UILabel()
        label.text = "id"
        label.textColor = .gray2
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let nameLable: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.textColor = .gray3
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let genderLable: UILabel = {
        let label = UILabel()
        label.text = "gender"
        label.textColor = .gray3
        label.font = .regularNunito(size: 16)
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
        label.text = "舉球"
        label.textColor = .gray3
        label.font = .regularNunito(size: 16)
        label.textAlignment = .center
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
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let spikeLable: UILabel = {
        let label = UILabel()
        label.text = "攻擊"
        label.textColor = .gray3
        label.font = .regularNunito(size: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let spikeLevelLable: UILabel = {
        let label = UILabel()
        let padding = 3
        label.text = "No"
        label.textColor = .purple3
        label.backgroundColor = .purple7
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let digLable: UILabel = {
        let label = UILabel()
        label.text = "接球"
        label.textColor = .gray3
        label.font = .regularNunito(size: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let digLevelLable: UILabel = {
        let label = UILabel()
        let padding = 3
        label.text = "No"
        label.textColor = .purple3
        label.backgroundColor = .purple7
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let blockLable: UILabel = {
        let label = UILabel()
        label.text = "攔網"
        label.textColor = .gray3
        label.font = .regularNunito(size: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let blockLevelLable: UILabel = {
        let label = UILabel()
        let padding = 3
        label.text = "No"
        label.textColor = .purple3
        label.backgroundColor = .purple7
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let sumLable: UILabel = {
        let label = UILabel()
        label.text = "綜合"
        label.textColor = .gray3
        label.font = .regularNunito(size: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let sumLevelLable: UILabel = {
        let label = UILabel()
        let padding = 3
        label.text = "No"
        label.textColor = .purple3
        label.backgroundColor = .purple7
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var blockUserView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray7
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tappable = true
        view.callback = {
            self.blockAction()
        }
        return view
    }()
    lazy var blockUserImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "block")?.withTintColor(UIColor.gray2)
        imageView.tintColor = .gray5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let blockUserLable: UILabel = {
        let label = UILabel()
        label.text = "封鎖"
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func setView() {
        addSubview(photoImageView)
        addSubview(accountLable)
        addSubview(nameLable)
        addSubview(genderLable)
        addSubview(setLable)
        addSubview(setLevelLable)
        addSubview(spikeLable)
        addSubview(spikeLevelLable)
        addSubview(digLable)
        addSubview(digLevelLable)
        addSubview(blockLable)
        addSubview(blockLevelLable)
        addSubview(sumLable)
        addSubview(sumLevelLable)
        addSubview(blockUserView)
        addSubview(blockUserImageView)
        addSubview(blockUserLable)
        setContent()
        setLayout()
    }
    func setContent() {
        if let thisUser = thisUser {
            photoImageView.kf.setImage(with: URL(string: thisUser.image))
            accountLable.text = thisUser.id
            nameLable.text = thisUser.name
            genderLable.text = genderList[thisUser.gender]
            setLevelLable.text = "  \(levelList[thisUser.level.setBall])  "
            spikeLevelLable.text = "  \(levelList[thisUser.level.spike])  "
            digLevelLable.text = "  \(levelList[thisUser.level.dig])  "
            blockLevelLable.text = "  \(levelList[thisUser.level.block])  "
            sumLevelLable.text = "  \(levelList[thisUser.level.sum])  "
        }
    }
    private func setLayout() {
        NSLayoutConstraint.activate([
//            self.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.57),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            photoImageView.heightAnchor.constraint(equalToConstant: photoHeight),
            photoImageView.widthAnchor.constraint(equalToConstant: photoHeight),

            accountLable.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: standardMargin),
            accountLable.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),

            nameLable.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin/2),
            nameLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            genderLable.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: standardMargin/2),
            genderLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            digLable.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: standardMargin),
            digLable.centerXAnchor.constraint(equalTo: centerXAnchor),
            setLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            setLable.centerYAnchor.constraint(equalTo: digLable.centerYAnchor),
            blockLable.centerYAnchor.constraint(equalTo: digLable.centerYAnchor),
            blockLable.leadingAnchor.constraint(equalTo: setLable.trailingAnchor, constant: standardMargin),
            blockLable.trailingAnchor.constraint(equalTo: digLable.leadingAnchor, constant: -standardMargin),
            spikeLable.centerYAnchor.constraint(equalTo: digLable.centerYAnchor),
            spikeLable.leadingAnchor.constraint(equalTo: digLable.trailingAnchor, constant: standardMargin),
            sumLable.leadingAnchor.constraint(equalTo: spikeLable.trailingAnchor, constant: standardMargin),
            sumLable.centerYAnchor.constraint(equalTo: digLable.centerYAnchor),
            sumLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            digLevelLable.centerXAnchor.constraint(equalTo: digLable.centerXAnchor),
            digLevelLable.topAnchor.constraint(equalTo: digLable.bottomAnchor, constant: standardMargin),
            spikeLevelLable.centerXAnchor.constraint(equalTo: spikeLable.centerXAnchor),
            spikeLevelLable.topAnchor.constraint(equalTo: spikeLable.bottomAnchor, constant: standardMargin),
            setLevelLable.centerXAnchor.constraint(equalTo: setLable.centerXAnchor),
            setLevelLable.topAnchor.constraint(equalTo: setLable.bottomAnchor, constant: standardMargin),
            blockLevelLable.centerXAnchor.constraint(equalTo: blockLable.centerXAnchor),
            blockLevelLable.topAnchor.constraint(equalTo: blockLable.bottomAnchor, constant: standardMargin),
            sumLevelLable.centerXAnchor.constraint(equalTo: sumLable.centerXAnchor),
            sumLevelLable.topAnchor.constraint(equalTo: sumLable.bottomAnchor, constant: standardMargin),
            blockUserView.topAnchor.constraint(equalTo: digLevelLable.bottomAnchor, constant: standardMargin),
            blockUserView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            blockUserView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: standardMargin/2),
            blockUserView.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            blockUserView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
            blockUserLable.centerXAnchor.constraint(equalTo: blockUserView.centerXAnchor, constant: standardMargin/2),
            blockUserLable.centerYAnchor.constraint(equalTo: blockUserView.centerYAnchor),
            blockUserImageView.centerYAnchor.constraint(equalTo: blockUserView.centerYAnchor),
            blockUserImageView.trailingAnchor.constraint(equalTo: blockUserLable.leadingAnchor, constant: -standardMargin),
            blockUserImageView.widthAnchor.constraint(equalToConstant: 15),
            blockUserImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
        self.addConstraint(NSLayoutConstraint(item: setLable, attribute: .width, relatedBy: .equal, toItem: digLable, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: blockLable, attribute: .width, relatedBy: .equal, toItem: digLable, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: spikeLable, attribute: .width, relatedBy: .equal, toItem: digLable, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: sumLable, attribute: .width, relatedBy: .equal, toItem: digLable, attribute: .width, multiplier: 1.0, constant: 0.0))
    }

    func blockAction() {
        if let thisUserId = self.thisUser?.id {
            let controller = UIAlertController(title: "確定？", message: "要封鎖 \(thisUserId)？", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "是", style: .default) { _ in
                print("block")
                MyDataManager.shared.addToBlocklist(userId: thisUserId)
                self.parent?.navigationController?.popToRootViewController(animated: true)
            }
            controller.addAction(okAction)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel)
            controller.addAction(cancelAction)
            parent?.present(controller, animated: true)
        }
    }
}
