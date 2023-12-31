//
//  MyPageViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/15.
//

import UIKit

class MyViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    let myProfileView = MyProfileView()

    lazy var editPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("更改照片", for: .normal)
        button.whiteButton()
        button.addTarget(self, action: #selector(pushToEditPhoto), for: .touchUpInside)
        return button
    }()
    lazy var editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("更改資料", for: .normal)
        button.whiteButton()
        button.addTarget(self, action: #selector(pushToInputProfile), for: .touchUpInside)
        return button
    }()
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("登出", for: .normal)
        button.purpleButton()
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return button
    }()
    lazy var myFinderCard: CardView = {
        let view = CardView()
        view.thisCardImage = "blow"
        view.thisCardLabel = MyPageEnum.myFinders.rawValue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tappable = true
        view.callback = {
            self.pushToMyFinders()
        }
        return view
    }()
    lazy var myPlayCard: CardView = {
        let view = CardView()
        view.thisCardImage = "rescue"
        view.thisCardLabel = MyPageEnum.myPlays.rawValue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tappable = true
        view.callback = {
            self.pushToMyPlays()
        }
        return view
    }()
    private let requestReceiveAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .red
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var requestReceiveCard: CardView = {
        let view = CardView()
        view.thisCardImage = "kick"
        view.thisImageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        view.thisCardLabel = MyPageEnum.requestIReceive.rawValue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tappable = true
        view.callback = {
            self.pushToRequestsReceive()
        }
        return view
    }()
    private let requestSentAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .red
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.font = .semiboldNunito(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var requestSentCard: CardView = {
        let view = CardView()
        view.thisCardImage = "defense"
        view.thisCardLabel = MyPageEnum.requestISent.rawValue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tappable = true
        view.callback = {
            self.pushToRequestsSend()
        }
        return view
    }()
    lazy var reportCard: CardView = {
        let view = CardView()
        view.thisCardImage = "yellow"
        view.thisCardLabel = MyPageEnum.report.rawValue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tappable = true
        view.callback = {
            self.pushToReport()
        }
        return view
    }()
    lazy var lockCard: CardView = {
        let view = CardView()
        view.thisCardImage = "red"
        view.thisCardLabel = MyPageEnum.lock.rawValue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tappable = true
        view.callback = {
            self.pushToLock()
        }
        return view
    }()
    let myDataManager = MyDataManager()
    let requestDataManager = RequestDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        addViews()
        setLayout()
        navigationItem.title = NavBarEnum.myPage.rawValue
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myProfileView.setView()
        setRequestsAmount()
    }

    private func addViews() {
        view.addSubview(myProfileView)
        view.addSubview(editPhotoButton)
        view.addSubview(editProfileButton)
        view.addSubview(logoutButton)
        view.addSubview(myPlayCard)
        view.addSubview(reportCard)
        view.addSubview(myFinderCard)
        view.addSubview(requestSentCard)
        view.addSubview(requestReceiveCard)
        view.addSubview(lockCard)
    }

    private func setLayout() {
        myProfileView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: editPhotoButton, attribute: .width, relatedBy: .equal, toItem: editProfileButton, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: editProfileButton, attribute: .width, relatedBy: .equal, toItem: logoutButton, attribute: .width, multiplier: 1.0, constant: 0.0))
        NSLayoutConstraint.activate([
            myProfileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myProfileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            myProfileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            editPhotoButton.topAnchor.constraint(equalTo: myProfileView.bottomAnchor, constant: standardMargin),
            editPhotoButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            editPhotoButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            editPhotoButton.trailingAnchor.constraint(equalTo: editProfileButton.leadingAnchor, constant: -standardMargin),
            editProfileButton.centerYAnchor.constraint(equalTo: editPhotoButton.centerYAnchor),
            editProfileButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            editProfileButton.trailingAnchor.constraint(equalTo: logoutButton.leadingAnchor, constant: -standardMargin),
            logoutButton.centerYAnchor.constraint(equalTo: editPhotoButton.centerYAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),

            myPlayCard.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: standardMargin),
            myPlayCard.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            myPlayCard.widthAnchor.constraint(equalTo: editProfileButton.widthAnchor, multiplier: 0.8),
            myFinderCard.topAnchor.constraint(equalTo: editPhotoButton.bottomAnchor, constant: standardMargin),
            myFinderCard.centerXAnchor.constraint(equalTo: editPhotoButton.centerXAnchor),
            myFinderCard.widthAnchor.constraint(equalTo: editPhotoButton.widthAnchor, multiplier: 0.8),
            reportCard.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: standardMargin),
            reportCard.centerXAnchor.constraint(equalTo: logoutButton.centerXAnchor),
            reportCard.widthAnchor.constraint(equalTo: logoutButton.widthAnchor, multiplier: 0.8),
            requestSentCard.topAnchor.constraint(equalTo: myFinderCard.bottomAnchor, constant: standardMargin),
            requestSentCard.centerXAnchor.constraint(equalTo: editPhotoButton.centerXAnchor),
            requestSentCard.widthAnchor.constraint(equalTo: editPhotoButton.widthAnchor, multiplier: 0.8),
            requestReceiveCard.topAnchor.constraint(equalTo: myPlayCard.bottomAnchor, constant: standardMargin),
            requestReceiveCard.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            requestReceiveCard.widthAnchor.constraint(equalTo: editProfileButton.widthAnchor, multiplier: 0.8),
            lockCard.topAnchor.constraint(equalTo: reportCard.bottomAnchor, constant: standardMargin),
            lockCard.centerXAnchor.constraint(equalTo: logoutButton.centerXAnchor),
            lockCard.widthAnchor.constraint(equalTo: logoutButton.widthAnchor, multiplier: 0.8)
        ])
    }

    @objc func pushToEditPhoto() {
        LKProgressHUD.show()
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true) {
            LKProgressHUD.dismiss()
        }
    }
    @objc func pushToInputProfile() {
        let nextVC = InputProfileViewController()
        nextVC.hidesBottomBarWhenPushed = true
        nextVC.changeUserInfoData = User(
            firebaseId: UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "No firebase id found",
            id: UserDefaults.standard.string(forKey: UserTitle.id.rawValue) ?? "No id found",
            email: UserDefaults.standard.string(forKey: UserTitle.email.rawValue) ?? "No email found",
            gender: UserDefaults.standard.integer(forKey: UserTitle.gender.rawValue),
            name: UserDefaults.standard.string(forKey: UserTitle.name.rawValue) ?? "No name found",
            level: LevelRange(setBall: UserDefaults.standard.integer(forKey: Level.setBall.rawValue),
                              block: UserDefaults.standard.integer(forKey: Level.block.rawValue),
                              dig: UserDefaults.standard.integer(forKey: Level.dig.rawValue),
                              spike: UserDefaults.standard.integer(forKey: Level.spike.rawValue),
                              sum: UserDefaults.standard.integer(forKey: Level.sum.rawValue)),
            image: UserDefaults.standard.string(forKey: UserTitle.image.rawValue) ?? "https://firebasestorage.googleapis.com/v0/b/volleyer-a15b6.appspot.com/o/defaults%2Fplaceholder.png?alt=media&token=d686707b-7b55-4291-8d67-c809c14f9528&_gl=1*gmtbad*_ga*MTE1Njk3OTU3Ny4xNjkxNjU1MTk0*_ga_CW55HF8NVT*MTY5NjA2MDc1Ni45Mi4xLjE2OTYwNjEwMTguNTQuMC4w"
        )
        navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func logout() {
        let controller = UIAlertController(title: "確定？", message: "要登出？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "是", style: .default) { _ in
            print("確定要登出")
            LKProgressHUD.showSuccess(text: "已登出")
            MyDataManager.shared.deleteUserDefault()
            let nextVC = LoginViewController()
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true)
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        controller.addAction(cancelAction)
        present(controller, animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else {
            return
        }
        myProfileView.photoImageView.image = UIImage(data: imageData)
        myDataManager.saveProfileImage(imageData: imageData)
    }
    @objc func pushToMyFinders() {
        let nextVC = MyFindersViewController()
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @objc func pushToMyPlays() {
        let nextVC = MyPlaysViewController()
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @objc func pushToRequestsReceive() {
        let nextVC = RequestsReceivedViewController()
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @objc func pushToRequestsSend() {
        let nextVC = RequestSentViewController()
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func pushToReport() {
        let nextVC = ReportViewController()
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func pushToLock() {
        let nextVC = BlockListViewController()
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
    }
    func setRequestsAmount() {
        requestDataManager.getPlayRequests()
        requestDataManager.playRequestDelegate = self
        requestReceiveCard.addSubview(requestReceiveAmountLabel)
        NSLayoutConstraint.activate([
            requestReceiveAmountLabel.topAnchor.constraint(equalTo: requestReceiveCard.topAnchor),
            requestReceiveAmountLabel.trailingAnchor.constraint(equalTo: requestReceiveCard.trailingAnchor)
        ])
        requestSentCard.addSubview(requestSentAmountLabel)

        NSLayoutConstraint.activate([
            requestSentAmountLabel.topAnchor.constraint(equalTo: requestSentCard.topAnchor),
            requestSentAmountLabel.trailingAnchor.constraint(equalTo: requestSentCard.trailingAnchor)
        ])
    }
}

extension MyViewController: RequestsDataManagerDelegate {

    func manager(_ manager: RequestDataManager, iReceive playRequests: [PlayRequest]) {
        var receiveAmount = 0
        for i in playRequests where i.status == 0 {
            receiveAmount += 1
        }
        if receiveAmount > 0 {
            requestReceiveAmountLabel.isHidden = false
            requestReceiveAmountLabel.text = "  \(String(receiveAmount))  "
        } else {
            requestReceiveAmountLabel.isHidden = true
        }
    }

    func manager(_ manager: RequestDataManager, iSent playRequests: [PlayRequest]) {
        var sentAmount = 0
        for i in playRequests where i.status == 0 {
            sentAmount += 1
        }
        if sentAmount > 0 {
            requestSentAmountLabel.isHidden = false
            requestSentAmountLabel.text = "  \(String(sentAmount))  "
        } else {
            requestSentAmountLabel.isHidden = true
        }
    }

}
