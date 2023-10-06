//
//  AddPlayViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/18.
//

import UIKit

class AddPlayViewController: UIViewController {

//    private var playView = PlayInfoView()
    lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let wantToAddLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray7
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
    lazy var calanderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "calendar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    private let playerListTableView = PlayerListTableView(frame: .zero, style: .plain)
    lazy var addPlayerButton: UIButton = {
        let button = UIButton()
        button.setTitle(AddPlayPageEnum.addPlayer.rawValue, for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.purple1.cgColor
        button.addTarget(self, action: #selector(addPlayer), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.purple1.cgColor
        button.addTarget(self, action: #selector(toggleEditingMode), for: .touchUpInside)
        return button
    }()
    lazy var sendRequestButton: UIButton = {
        let button = UIButton()
//        button.setTitle(AddPlayPageEnum.sendRequest.rawValue, for: .normal)
//        button.titleLabel?.font =  .semiboldNunito(size: 16)
//        button.titleLabel?.textAlignment = .center
//        button.backgroundColor = .purple1
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.layer.cornerRadius = 16
//        button.clipsToBounds = true
        button.setImage(UIImage(named: "plus 1"), for: .normal)
        button.tintColor = .purple4
//        button.tintColor = .gray3
//        button.titleLabel?.font =  .regularNunito(size: 16)
//        button.titleLabel?.textAlignment = .center
//        button.backgroundColor = .clear
//        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.gray1.cgColor
        button.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
        return button
    }()

    var thisPlay: Play? {
        didSet {
            sendDataToPlayView(thisPlay!)
            setContent()
        }
    }

    private var addPlayers: [Player] = []

    var dataManager = RequestDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(playView)
        view.addSubview(topImageView)
        topImageView.addSubview(wantToAddLable)
//        view.addSubview(calanderImageView)
        view.addSubview(photoImageView)
        view.addSubview(accountLable)
        view.addSubview(startTimeLable)
        view.addSubview(endTimeLable)
        view.addSubview(placeImageView)
        view.addSubview(placeLabel)
//        view.addSubview(lackLable)
        view.addSubview(typeLable)
//        view.addSubview(setLevelLable)
//        view.addSubview(blockLevelLable)
//        view.addSubview(digLevelLable)
//        view.addSubview(spikeLevelLable)
//        view.addSubview(sumLevelLable)
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
        view.addSubview(addPlayerButton)
        view.addSubview(sendRequestButton)
//        setPlayersTableView()
        setLayout()
        setNavBar()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = ""
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .gray7
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .clear
        navigationBarAppearance.shadowColor = .clear
//        navigationBarAppearance.backgroundImage = UIImage(named: "play-volleyball")
//        navigationBarAppearance.titleTextAttributes = [
//            .foregroundColor: UIColor.gray7,
//            .font: UIFont.semiboldNunito(size: 20)
//         ]
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
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

    private func setPlayersTableView() {
//        view.addSubview(playerListTableView)
        playerListTableView.translatesAutoresizingMaskIntoConstraints = false
        // 第一個永遠是自己
        playerListTableView.players.append(
            Player(name: UserDefaults.standard.string(forKey: UserTitle.name.rawValue)!,
                   gender: UserDefaults.standard.string(forKey: UserTitle.gender.rawValue)!)
        )
    }

    private func setLayout() {
        setView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            playView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            playView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            playView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

//            playerListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
////            playerListTableView.topAnchor.constraint(equalTo: playView.bottomAnchor, constant: standardMargin),
//            playerListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            playerListTableView.heightAnchor.constraint(equalToConstant: 200),
           

            photoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            photoImageView.topAnchor.constraint(equalTo: typeLable.bottomAnchor, constant: standardMargin),
            photoImageView.heightAnchor.constraint(equalToConstant: photoHeight/2),
            photoImageView.widthAnchor.constraint(equalToConstant: photoHeight/2),

            accountLable.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: standardMargin),
            accountLable.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
//            calanderImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
//            calanderImageView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: standardMargin),
//            calanderImageView.heightAnchor.constraint(equalToConstant: 20),
//            calanderImageView.widthAnchor.constraint(equalTo: calanderImageView.heightAnchor, multiplier: 1),
            startTimeLable.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: standardMargin*1.5),
            startTimeLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            endTimeLable.topAnchor.constraint(equalTo: startTimeLable.bottomAnchor, constant: standardMargin),
            endTimeLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            placeImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            placeImageView.topAnchor.constraint(equalTo: endTimeLable.bottomAnchor, constant: standardMargin*1.5),
            placeImageView.heightAnchor.constraint(equalToConstant: 20),
            placeImageView.widthAnchor.constraint(equalTo: placeImageView.heightAnchor, multiplier: 1),
//            placeLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: standardMargin),
            placeLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: standardMargin),
//            placeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin*4.7),
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
            digView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin*2),
//            digView.widthAnchor.constraint(equalToConstant: 60),
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

            addPlayerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            addPlayerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),
            addPlayerButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            addPlayerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -standardMargin/2),

            sendRequestButton.centerYAnchor.constraint(equalTo: typeLable.centerYAnchor),
            sendRequestButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            sendRequestButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            sendRequestButton.widthAnchor.constraint(equalTo: sendRequestButton.heightAnchor, multiplier: 1.0),
            wantToAddLable.centerXAnchor.constraint(equalTo: topImageView.centerXAnchor),
            wantToAddLable.centerYAnchor.constraint(equalTo: topImageView.centerYAnchor),
            typeLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
//            typeLable.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: standardMargin*3),
            topImageView.topAnchor.constraint(equalTo: view.topAnchor),
            topImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            topImageView.heightAnchor.constraint(equalToConstant: 150),
            topImageView.bottomAnchor.constraint(equalTo: typeLable.topAnchor, constant: -standardMargin)
        ])
//        topImageView.bottomAnchor.constraint(equalTo: typeLable.topAnchor, constant: -standardMargin).isActive = true
//        topImageView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
//        typeLable.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        self.view.addConstraint(NSLayoutConstraint(item: setView, attribute: .width, relatedBy: .equal, toItem: digView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: blockView, attribute: .width, relatedBy: .equal, toItem: digView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: spikeView, attribute: .width, relatedBy: .equal, toItem: digView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: sumView, attribute: .width, relatedBy: .equal, toItem: digView, attribute: .width, multiplier: 1.0, constant: 0.0))
    }

    func sendDataToPlayView(_ data: Play) {
//        playView.play = thisPlay
//        playView.setUI()
    }

    @objc func sendRequest() {
        addPlayers = playerListTableView.players
        print(addPlayers)
        dataManager.saveRequest(thisPlay!, playerList: addPlayers)
        print("request sent")
        navigationController?.popToRootViewController(animated: true)
    }

    @objc func toggleEditingMode() {
        playerListTableView.toggleEditing()
        let buttonText = playerListTableView.isEditing ? "Done" : "Delete"
        deleteButton.setTitle(buttonText, for: .normal)
    }
    @objc func addPlayer() {
        let newPlayer = Player(name: "", gender: "") // Customize as needed
        playerListTableView.addNewPlayer(newPlayer)
    }
}
