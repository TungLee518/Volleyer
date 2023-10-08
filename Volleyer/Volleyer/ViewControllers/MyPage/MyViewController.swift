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
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.purple1.cgColor
        button.addTarget(self, action: #selector(pushToEditPhoto), for: .touchUpInside)
        return button
    }()
    lazy var editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("更改資料", for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.purple1.cgColor
        button.addTarget(self, action: #selector(pushToInputProfile), for: .touchUpInside)
        return button
    }()
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("登出", for: .normal)
        button.titleLabel?.font =  .semiboldNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .purple1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
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
    lazy var requestSentCard: CardView = {
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
    lazy var requestReceiveCard: CardView = {
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
    let dataManager = MyDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        view.addSubview(myProfileView)
        view.addSubview(editPhotoButton)
        view.addSubview(editProfileButton)
        view.addSubview(logoutButton)
        view.addSubview(myPlayCard)
        view.addSubview(reportCard)
        view.addSubview(myFinderCard)
        view.addSubview(requestReceiveCard)
        view.addSubview(requestSentCard)
        view.addSubview(lockCard)
        setLayout()
        setProfileData()
        navigationItem.title = NavBarEnum.myPage.rawValue
    }

    func setProfileData() {
        myProfileView.translatesAutoresizingMaskIntoConstraints = false
        myProfileView.thisUser = User(
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
        myProfileView.setView()
    }

    private func setLayout() {
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
            requestReceiveCard.topAnchor.constraint(equalTo: myFinderCard.bottomAnchor, constant: standardMargin),
            requestReceiveCard.centerXAnchor.constraint(equalTo: editPhotoButton.centerXAnchor),
            requestReceiveCard.widthAnchor.constraint(equalTo: editPhotoButton.widthAnchor, multiplier: 0.8),
            requestSentCard.topAnchor.constraint(equalTo: myPlayCard.bottomAnchor, constant: standardMargin),
            requestSentCard.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            requestSentCard.widthAnchor.constraint(equalTo: editProfileButton.widthAnchor, multiplier: 0.8),
            lockCard.topAnchor.constraint(equalTo: reportCard.bottomAnchor, constant: standardMargin),
            lockCard.centerXAnchor.constraint(equalTo: logoutButton.centerXAnchor),
            lockCard.widthAnchor.constraint(equalTo: logoutButton.widthAnchor, multiplier: 0.8)
        ])
    }

    @objc func pushToEditPhoto() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    @objc func pushToInputProfile() {

    }
    @objc func logout() {
        let controller = UIAlertController(title: "確定？", message: "要登出？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "是", style: .default) { _ in
            print("確定要登出")
            LKProgressHUD.showSuccess(text: "已登出")
            UserDefaults.standard.set(nil, forKey: UserTitle.firebaseId.rawValue)
            UserDefaults.standard.set(nil, forKey: UserTitle.userIdentifier.rawValue)
            UserDefaults.standard.set(nil, forKey: UserTitle.id.rawValue)
            UserDefaults.standard.set(nil, forKey: UserTitle.name.rawValue)
            UserDefaults.standard.set(nil, forKey: UserTitle.image.rawValue)
            UserDefaults.standard.set(nil, forKey: UserTitle.email.rawValue)
            UserDefaults.standard.set(nil, forKey: UserTitle.gender.rawValue)
            UserDefaults.standard.set(nil, forKey: Level.setBall.rawValue)
            UserDefaults.standard.set(nil, forKey: Level.block.rawValue)
            UserDefaults.standard.set(nil, forKey: Level.dig.rawValue)
            UserDefaults.standard.set(nil, forKey: Level.spike.rawValue)
            UserDefaults.standard.set(nil, forKey: Level.sum.rawValue)
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
        dataManager.saveProfileImage(imageData: imageData)
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
        navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func pushToLock() {
//        let nextVC = RequestSentViewController()
//        navigationController?.pushViewController(nextVC, animated: true)
    }
}
