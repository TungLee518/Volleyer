//
//  ProfileViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/22.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var thisUser: User?

    let dataManager = MyDataManager()

    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: UserDefaults.standard.string(forKey: UserTitle.id.rawValue) ?? "placeholder")
        imageView.layer.cornerRadius = photoHeight
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let accountLable: UILabel = {
        let label = UILabel()
        label.text = "id"
        label.textColor = .gray2
        label.font = .semiboldNunito(size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let nameLable: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.textColor = .gray2
        label.font = .semiboldNunito(size: 16)
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
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("更改", for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.purple1.cgColor
//        button.addTarget(self, action: #selector(toggleEditingMode), for: .touchUpInside)
        return button
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
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
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
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
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
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
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
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
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
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
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
    lazy var editPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("更改照片", for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 3
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
        button.layer.borderWidth = 3
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(photoImageView)
        view.addSubview(accountLable)
//        view.addSubview(nameLable)
//        view.addSubview(genderLable)
//        view.addSubview(levelLable)
        view.addSubview(setLable)
        view.addSubview(setLevelLable)
        view.addSubview(spikeLable)
        view.addSubview(spikeLevelLable)
        view.addSubview(digLable)
        view.addSubview(digLevelLable)
        view.addSubview(blockLable)
        view.addSubview(blockLevelLable)
        view.addSubview(sumLable)
        view.addSubview(sumLevelLable)
        view.addSubview(editPhotoButton)
        view.addSubview(editProfileButton)
        view.addSubview(logoutButton)
        setNavBar()
        setLayout()
        setContent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setContent()
        print("view will appear")
    }

    func setContent() {
        photoImageView.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: UserTitle.image.rawValue) ?? placeholderImage))
        accountLable.text = UserDefaults.standard.string(forKey: UserTitle.id.rawValue) ?? "No id found"
        nameLable.text = UserDefaults.standard.string(forKey: UserTitle.name.rawValue)
        genderLable.text = genderList[UserDefaults.standard.integer(forKey: UserTitle.gender.rawValue)]
        setLevelLable.text = "  \(levelList[UserDefaults.standard.integer(forKey: Level.setBall.rawValue)])  "
        spikeLevelLable.text = "  \(levelList[UserDefaults.standard.integer(forKey: Level.spike.rawValue)])  "
        digLevelLable.text = "  \(levelList[UserDefaults.standard.integer(forKey: Level.dig.rawValue)])  "
        blockLevelLable.text = "  \(levelList[UserDefaults.standard.integer(forKey: Level.block.rawValue)])  "
        sumLevelLable.text = "  \(levelList[UserDefaults.standard.integer(forKey: Level.sum.rawValue)])  "
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.myProfile.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .purple2
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: RightBarTiems.editContent.rawValue, style: .plain, target: self, action: #selector(pushToEditPhoto))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.purple2], for: .normal)

    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            photoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: standardMargin),
            photoImageView.heightAnchor.constraint(equalToConstant: photoHeight*2),
            photoImageView.widthAnchor.constraint(equalToConstant: photoHeight*2),

            accountLable.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: standardMargin),
            accountLable.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),

//            nameLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
//            nameLable.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: standardMargin),
//
//            genderLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
//            genderLable.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: standardMargin),

//            levelLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
//            levelLable.topAnchor.constraint(equalTo: genderLable.bottomAnchor, constant: standardMargin),

            digLable.centerXAnchor.constraint(equalTo: accountLable.centerXAnchor),
            digLable.topAnchor.constraint(equalTo: accountLable.bottomAnchor, constant: standardMargin),
            digLevelLable.centerXAnchor.constraint(equalTo: digLable.centerXAnchor),
            digLevelLable.topAnchor.constraint(equalTo: digLable.bottomAnchor, constant: standardMargin),

            spikeLable.trailingAnchor.constraint(equalTo: digLable.leadingAnchor, constant: -standardMargin*2),
            spikeLable.centerYAnchor.constraint(equalTo: digLable.centerYAnchor),
            spikeLevelLable.centerXAnchor.constraint(equalTo: spikeLable.centerXAnchor),
            spikeLevelLable.topAnchor.constraint(equalTo: spikeLable.bottomAnchor, constant: standardMargin),

            setLable.trailingAnchor.constraint(equalTo: spikeLable.leadingAnchor, constant: -standardMargin*2),
            setLable.centerYAnchor.constraint(equalTo: digLable.centerYAnchor),
            setLevelLable.centerXAnchor.constraint(equalTo: setLable.centerXAnchor),
            setLevelLable.topAnchor.constraint(equalTo: setLable.bottomAnchor, constant: standardMargin),

            blockLable.leadingAnchor.constraint(equalTo: digLable.trailingAnchor, constant: standardMargin*2),
            blockLable.centerYAnchor.constraint(equalTo: digLable.centerYAnchor),
            blockLevelLable.centerXAnchor.constraint(equalTo: blockLable.centerXAnchor),
            blockLevelLable.topAnchor.constraint(equalTo: blockLable.bottomAnchor, constant: standardMargin),

            sumLable.leadingAnchor.constraint(equalTo: blockLable.trailingAnchor, constant: standardMargin*2),
            sumLable.centerYAnchor.constraint(equalTo: digLable.centerYAnchor),
            sumLevelLable.centerXAnchor.constraint(equalTo: sumLable.centerXAnchor),
            sumLevelLable.topAnchor.constraint(equalTo: sumLable.bottomAnchor, constant: standardMargin),
            
            editPhotoButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            editPhotoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),
            editPhotoButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            editPhotoButton.trailingAnchor.constraint(equalTo: editProfileButton.leadingAnchor, constant: -standardMargin),
            editProfileButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),
            editProfileButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            editProfileButton.trailingAnchor.constraint(equalTo: logoutButton.leadingAnchor, constant: -standardMargin),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),
            logoutButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin)
        ])
        self.view.addConstraint(NSLayoutConstraint(item: editPhotoButton, attribute: .width, relatedBy: .equal, toItem: editProfileButton, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: editProfileButton, attribute: .width, relatedBy: .equal, toItem: logoutButton, attribute: .width, multiplier: 1.0, constant: 0.0))
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
        photoImageView.image = UIImage(data: imageData)
        dataManager.saveProfileImage(imageData: imageData)
    }
}
