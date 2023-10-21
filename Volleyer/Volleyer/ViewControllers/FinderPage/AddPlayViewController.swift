//
//  AddPlayViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/18.
//

import UIKit

class AddPlayViewController: UIViewController {

    lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ballnet")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.alpha = 0.7
        return imageView
    }()
    let wantToAddLable: UILabel = {
        let label = UILabel()
        label.textColor = .clear
        label.text = "我要加"
        label.font = .semiboldNunito(size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let typeLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray1
        label.font = .semiboldNunito(size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.layer.cornerRadius = photoHeight / 4
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tappable = true
        imageView.callback = {
            self.pushToProfileVC()
        }
        return imageView
    }()

    private let accountLable: UILabel = {
        let label = UILabel()
        label.text = "loading"
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let startTimeLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray2
        label.font = .semiboldNunito(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let endTimeLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray2
        label.font = .semiboldNunito(size: 20)
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
        label.font = .regularNunito(size: 20)
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
        label.font = .regularNunito(size: 20)
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
        label.font = .regularNunito(size: 20)
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
        label.font = .regularNunito(size: 20)
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
    lazy var sendRequestButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus")?.withTintColor(.purple4), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
        return button
    }()

    var thisPlay: Play? {
        didSet {
            setContent()
            if thisPlay?.finderId == UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) {
                sendRequestButton.isHidden = true
            } else {
                sendRequestButton.isHidden = false
            }
        }
    }
    var thisFinderId: String?

    private var addPlayers: [Player] = []

    var dataManager = RequestDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        view.addSubview(topImageView)
        view.addSubview(wantToAddLable)
        view.addSubview(photoImageView)
        view.addSubview(accountLable)
        view.addSubview(startTimeLable)
        view.addSubview(endTimeLable)
        view.addSubview(placeImageView)
        view.addSubview(placeLabel)
        view.addSubview(typeLable)
        view.addSubview(priceImageView)
        view.addSubview(priceLable)
        view.addSubview(maleImageView)
        view.addSubview(maleLackLable)
        view.addSubview(femaleImageView)
        view.addSubview(femaleLackLable)
        view.addSubview(setView)
        view.addSubview(blockView)
        view.addSubview(digView)
        view.addSubview(spikeView)
        view.addSubview(sumView)
        view.addSubview(sendRequestButton)
        setLayout()
    }

    func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = ""
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .purple2
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .clear
        navigationBarAppearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
    }

    func setContent() {
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
            FinderDataManager.sharedDataMenager.getUserByFirebaseId(id: thisPlay.finderId) { gotUser, err in
                if let error = err {
                    // Handle the error
                    print("Error: \(error)")
                } else if let gotUser = gotUser {
                    // Use the gotUser
                    self.thisFinderId = gotUser.id
                    self.accountLable.text = gotUser.id
                } else {
                    // Handle the case where no matching document was found
                    print("No matching document found")
                }
            }
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
    }

    private func setLayout() {
        setView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            photoImageView.topAnchor.constraint(equalTo: typeLable.bottomAnchor, constant: standardMargin),
            photoImageView.heightAnchor.constraint(equalToConstant: photoHeight/2),
            photoImageView.widthAnchor.constraint(equalToConstant: photoHeight/2),

            accountLable.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: standardMargin),
            accountLable.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
            startTimeLable.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: standardMargin*1.5),
            startTimeLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            endTimeLable.topAnchor.constraint(equalTo: startTimeLable.bottomAnchor, constant: standardMargin),
            endTimeLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            placeImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            placeImageView.topAnchor.constraint(equalTo: endTimeLable.bottomAnchor, constant: standardMargin*1.5),
            placeImageView.heightAnchor.constraint(equalToConstant: 20),
            placeImageView.widthAnchor.constraint(equalTo: placeImageView.heightAnchor, multiplier: 1),
            placeLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: standardMargin),
            placeLabel.centerYAnchor.constraint(equalTo: placeImageView.centerYAnchor),

            priceImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            priceImageView.topAnchor.constraint(equalTo: placeImageView.bottomAnchor, constant: standardMargin*1.5),
            priceImageView.heightAnchor.constraint(equalToConstant: 20),
            priceImageView.widthAnchor.constraint(equalTo: placeImageView.heightAnchor, multiplier: 1),
            priceLable.leadingAnchor.constraint(equalTo: priceImageView.trailingAnchor, constant: standardMargin),
            priceLable.centerYAnchor.constraint(equalTo: priceImageView.centerYAnchor),

            maleImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            maleImageView.topAnchor.constraint(equalTo: priceImageView.bottomAnchor, constant: standardMargin*1.5),
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

            digView.topAnchor.constraint(equalTo: maleImageView.bottomAnchor, constant: standardMargin*2),
            digView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            digView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin*7),
            setView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            setView.centerYAnchor.constraint(equalTo: digView.centerYAnchor),
            blockView.centerYAnchor.constraint(equalTo: digView.centerYAnchor),
            blockView.leadingAnchor.constraint(equalTo: setView.trailingAnchor, constant: standardMargin),
            blockView.trailingAnchor.constraint(equalTo: digView.leadingAnchor, constant: -standardMargin),
            spikeView.centerYAnchor.constraint(equalTo: digView.centerYAnchor),
            spikeView.leadingAnchor.constraint(equalTo: digView.trailingAnchor, constant: standardMargin),
            sumView.leadingAnchor.constraint(equalTo: spikeView.trailingAnchor, constant: standardMargin),
            sumView.centerYAnchor.constraint(equalTo: digView.centerYAnchor),
            sumView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),

            sendRequestButton.centerYAnchor.constraint(equalTo: typeLable.centerYAnchor),
            sendRequestButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            sendRequestButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            sendRequestButton.widthAnchor.constraint(equalTo: sendRequestButton.heightAnchor, multiplier: 1.0),
            wantToAddLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -standardMargin),
            wantToAddLable.centerXAnchor.constraint(equalTo: topImageView.centerXAnchor),
            typeLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            topImageView.topAnchor.constraint(equalTo: view.topAnchor),
            topImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topImageView.bottomAnchor.constraint(equalTo: typeLable.topAnchor, constant: -standardMargin)
        ])
        self.view.addConstraint(NSLayoutConstraint(item: setView, attribute: .width, relatedBy: .equal, toItem: digView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: blockView, attribute: .width, relatedBy: .equal, toItem: digView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: spikeView, attribute: .width, relatedBy: .equal, toItem: digView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: sumView, attribute: .width, relatedBy: .equal, toItem: digView, attribute: .width, multiplier: 1.0, constant: 0.0))
    }

    @objc func sendRequest() {
        let controller = UIAlertController(title: "確定？", message: "要發加場邀請給 \(thisFinderId ??  "Internet Error")？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "是", style: .default) { _ in
            print(self.addPlayers)
            self.dataManager.saveRequest(self.thisPlay!, playerList: self.addPlayers)
            print("request sent")
            self.navigationController?.popToRootViewController(animated: true)
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        controller.addAction(cancelAction)
        present(controller, animated: true)
    }

    func pushToProfileVC() {
        let nextVC = ProfileViewController()
        nextVC.thisUserId = thisPlay?.finderId
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
