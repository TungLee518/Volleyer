//
//  ResultViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/3.
//

import UIKit
import JGProgressHUD

class InputProfileViewController: UIViewController {
    let genderPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.sizeToFit()
        return picker
    }()
    private var pleaseInputLabel: UILabel = {
        let label = UILabel()
        label.text = "歡迎加入排球人"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let idLabel: UILabel = {
        let label = UILabel()
        label.text = "ID"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .regularNunito(size: 16)
        textField.textColor = .gray2
        textField.placeholder = "用於顯示且不重複的ID"
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(cancelToolbar))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        return textField
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "姓名"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .regularNunito(size: 16)
        textField.textColor = .gray2
        textField.placeholder = "輸入姓名"
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(cancelToolbar))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        return textField
    }()
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "email"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .regularNunito(size: 16)
        textField.textColor = .gray2
        textField.placeholder = "輸入 email"
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(cancelToolbar))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        return textField
    }()
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "性別"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var genderTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .regularNunito(size: 16)
        textField.textColor = .gray2
        textField.placeholder = "請選擇"
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.inputView = genderPicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(cancelToolbar))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        return textField
    }()
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.text = "程度自評"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var viewLevelButton: UIButton = {
        let button = UIButton()
        button.setTitle("自評表", for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.purple1.cgColor
        button.addTarget(self, action: #selector(viewLevel), for: .touchUpInside)
        return button
    }()
    lazy var doneInputButton: UIButton = {
        let button = UIButton()
        button.setTitle("完成", for: .normal)
        button.titleLabel?.font =  .semiboldNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .purple1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(doneInput), for: .touchUpInside)
        return button
    }()
//    var levelImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = .secondarySystemBackground
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = UIImage(named: "levels")
//        imageView.isUserInteractionEnabled = true
//        return imageView
//    }()
    let levelImageView = PanZoomImageView(named: "levels")

    var setCheckboxes: [UIButton] = []
    var blocCheckboxes: [UIButton] = []
    var digCheckboxes: [UIButton] = []
    var spickCheckboxes: [UIButton] = []
    var sumCheckboxes: [UIButton] = []
    var SABCLabels: [UILabel] = []

    lazy var thisUser = User(id: "", email: "", gender: -1, name: "")

    var changeUserInfoData: User? {
        didSet {
            // auto input user data
//            autoInputUserInfo()
        }
    }

    var levelImageIsHidden = true
    let hud = JGProgressHUD(style: .dark)

    override func viewDidLoad() {
        super.viewDidLoad()

        pleaseInputLabel.text = "歡迎加入排球人"
        viewLevelButton.removeTarget(nil, action: nil, for: .allEvents)
        viewLevelButton.setTitle("自評表", for: .normal)
        viewLevelButton.addTarget(self, action: #selector(viewLevel), for: .touchUpInside)
        doneInputButton.removeTarget(nil, action: nil, for: .allEvents)
        doneInputButton.setTitle("完成", for: .normal)
        doneInputButton.addTarget(self, action: #selector(doneInput), for: .touchUpInside)
        print(thisUser)
        view.backgroundColor = .white
        view.addSubview(pleaseInputLabel)
        view.addSubview(idLabel)
        view.addSubview(idTextField)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(genderLabel)
        view.addSubview(genderTextField)
        view.addSubview(levelLabel)
        view.addSubview(viewLevelButton)
        view.addSubview(doneInputButton)

        setLayout()
        setSABC()

        setCheckboxes = createCheckboxes(text: positions[0], i: 0, action: #selector(setCheckboxTapped))
        blocCheckboxes = createCheckboxes(text: positions[1], i: 1, action: #selector(blockCheckboxTapped))
        digCheckboxes = createCheckboxes(text: positions[2], i: 2, action: #selector(digCheckboxTapped))
        spickCheckboxes = createCheckboxes(text: positions[3], i: 3, action: #selector(spickCheckboxTapped))
        sumCheckboxes = createCheckboxes(text: positions[4], i: 4, action: #selector(sumCheckboxTapped))

        genderPicker.dataSource = self
        genderPicker.delegate = self
        setLevelImage()

        MyDataManager.shared.canGoToTabbarVC = { [weak self] canGoToTabbarVc in
            guard let self = self else { return }
            if canGoToTabbarVc {
                let viewController = TabBarViewController()
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true)
            } else {
                hud.textLabel.text = "此 ID 已存在"
                hud.indicatorView = JGProgressHUDErrorIndicatorView()
                hud.show(in: view)
                hud.dismiss(afterDelay: 1.5)
            }
        }
        autoInputUserInfo()
    }
    func setLayout() {
        NSLayoutConstraint.activate([
            pleaseInputLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: standardMargin*3),
            pleaseInputLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),

            idLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            idLabel.topAnchor.constraint(equalTo: pleaseInputLabel.bottomAnchor, constant: standardMargin*3),
            idTextField.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: standardMargin),
            idTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            idTextField.centerYAnchor.constraint(equalTo: idLabel.centerYAnchor),
            idTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            idTextField.widthAnchor.constraint(equalToConstant: standardTextFieldWidth),

            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: standardMargin),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: standardMargin),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            nameTextField.widthAnchor.constraint(equalToConstant: standardTextFieldWidth),

            emailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: standardMargin),
            emailTextField.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: standardMargin),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            emailTextField.centerYAnchor.constraint(equalTo: emailLabel.centerYAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            emailTextField.widthAnchor.constraint(equalToConstant: standardTextFieldWidth),

            genderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            genderLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: standardMargin),
            genderTextField.leadingAnchor.constraint(equalTo: genderLabel.trailingAnchor, constant: standardMargin),
            genderTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            genderTextField.centerYAnchor.constraint(equalTo: genderLabel.centerYAnchor),
            genderTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            genderTextField.widthAnchor.constraint(equalToConstant: standardTextFieldWidth),

            levelLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            levelLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: standardMargin*2),

            viewLevelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            viewLevelButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            viewLevelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -standardMargin/2),
            viewLevelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),

            doneInputButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: standardMargin/2),
            doneInputButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            doneInputButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),
            doneInputButton.heightAnchor.constraint(equalToConstant: standardButtonHeight)
        ])
    }
    func setSABC() {
        var previous: Any = genderLabel
        for i in 0...3 {
            let label = UILabel()
            label.text = levelList[i]
            label.textColor = .gray3
            label.font = .regularNunito(size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            if i == 0 {
                label.leadingAnchor.constraint(equalTo: genderTextField.leadingAnchor).isActive = true
            } else {
                label.leadingAnchor.constraint(equalTo: (previous as AnyObject).trailingAnchor, constant: standardMargin+20).isActive = true
            }
            label.centerYAnchor.constraint(equalTo: levelLabel.centerYAnchor).isActive = true
            SABCLabels.append(label)
            previous = label
        }
    }

    func createCheckboxes(text: String, i: Int, action: Selector) -> [UIButton] {
        // Create a label for the question
        let questionLabel = UILabel()
        questionLabel.text = text
        questionLabel.font = .regularNunito(size: 16)
        questionLabel.textColor = .gray3
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionLabel)
        // Create constraints for the question label
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: levelLabel.trailingAnchor, constant: -standardMargin),
            questionLabel.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: (standardMargin + 10) * (Double(i)+0.2))
        ])

        // Create checkboxes for each choice
        var choiceButtons: [UIButton] = []
        for i in 0...3 {
            let checkbox = UIButton(type: .custom)
            checkbox.translatesAutoresizingMaskIntoConstraints = false
            checkbox.setImage(UIImage(systemName: "square"), for: .normal)
            checkbox.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
            checkbox.tintColor = .purple2
            checkbox.addTarget(self, action: action, for: .touchUpInside)
            checkbox.tag = i
            view.addSubview(checkbox)
            checkbox.centerXAnchor.constraint(equalTo: SABCLabels[i].centerXAnchor).isActive = true
            checkbox.topAnchor.constraint(equalTo: questionLabel.topAnchor).isActive = true
            choiceButtons.append(checkbox)
        }
        return choiceButtons
    }
    func setLevelImage() {
        view.addSubview(levelImageView)
        levelImageView.backgroundColor = .gray5
        levelImageView.isHidden = levelImageIsHidden
        levelImageView.imageView.image = UIImage(named: "levels")
        levelImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            levelImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            levelImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            levelImageView.heightAnchor.constraint(equalTo: levelImageView.widthAnchor, multiplier: 1.3),
            levelImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    func autoInputUserInfo() {
        if let changeUserInfoData = changeUserInfoData {
            thisUser = changeUserInfoData
            idTextField.text = changeUserInfoData.id
            nameTextField.text = changeUserInfoData.name
            emailTextField.text = changeUserInfoData.email
            genderTextField.text = genderList[changeUserInfoData.gender]
            print(changeUserInfoData)
            print(setCheckboxes)
            setCheckboxes[changeUserInfoData.level.setBall].isSelected = true
            blocCheckboxes[changeUserInfoData.level.block].isSelected = true
            digCheckboxes[changeUserInfoData.level.dig].isSelected = true
            spickCheckboxes[changeUserInfoData.level.spike].isSelected = true
            sumCheckboxes[changeUserInfoData.level.sum].isSelected = true
            pleaseInputLabel.text = "更改個人資訊"
            viewLevelButton.removeTarget(nil, action: nil, for: .allEvents)
            viewLevelButton.setTitle("刪除帳號", for: .normal)
            viewLevelButton.addTarget(self, action: #selector(deleteAccount), for: .touchUpInside)
            doneInputButton.removeTarget(nil, action: nil, for: .allEvents)
            doneInputButton.setTitle("更改資料", for: .normal)
            doneInputButton.addTarget(self, action: #selector(changeUserInfo), for: .touchUpInside)
        }
    }
    @objc func cancelToolbar() {
        self.view.endEditing(true)
    }
    @objc func setCheckboxTapped(sender: UIButton) {
        print(sender.tag)
        thisUser.level.setBall = sender.tag
        for checkbox in setCheckboxes {
            checkbox.isSelected = (checkbox == sender)
        }
    }
    @objc func blockCheckboxTapped(sender: UIButton) {
        print(sender.tag)
        thisUser.level.block = sender.tag
        for checkbox in blocCheckboxes {
            checkbox.isSelected = (checkbox == sender)
        }
    }
    @objc func digCheckboxTapped(sender: UIButton) {
        print(sender.tag)
        thisUser.level.dig = sender.tag
        for checkbox in digCheckboxes {
            checkbox.isSelected = (checkbox == sender)
        }
    }
    @objc func spickCheckboxTapped(sender: UIButton) {
        print(sender.tag)
        thisUser.level.spike = sender.tag
        for checkbox in spickCheckboxes {
            checkbox.isSelected = (checkbox == sender)
        }
    }
    @objc func sumCheckboxTapped(sender: UIButton) {
        print(sender.tag)
        thisUser.level.sum = sender.tag
        for checkbox in sumCheckboxes {
            checkbox.isSelected = (checkbox == sender)
        }
    }
    @objc func viewLevel() {
        levelImageIsHidden = !levelImageIsHidden
        levelImageView.isHidden = levelImageIsHidden
        if levelImageIsHidden {
            doneInputButton.isHidden = false
            viewLevelButton.setTitle("自評表", for: .normal)
        } else {
            doneInputButton.isHidden = true
            viewLevelButton.setTitle("OK", for: .normal)
        }
    }
    @objc func doneInput() {
        if idTextField.text != "", nameTextField.text != "", emailTextField.text != "", genderTextField.text != "", nameTextField.text != "", thisUser.level.block != 4, thisUser.level.setBall != 4, thisUser.level.dig != 4, thisUser.level.spike != 4, thisUser.level.sum != 4 {
            thisUser.email = emailTextField.text!
            thisUser.id = idTextField.text!
            thisUser.name = nameTextField.text!
            thisUser.gender = genderList.firstIndex(of: genderTextField.text!)!
            print(thisUser)
            MyDataManager.shared.saveProfileInfo(thisUser)
        } else {
            hud.textLabel.text = "請輸入完整資訊"
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.show(in: view)
            hud.dismiss(afterDelay: 1.5)
        }
    }
    @objc func changeUserInfo() {
        if idTextField.text != "", nameTextField.text != "", emailTextField.text != "", genderTextField.text != "" {
            thisUser.email = emailTextField.text!
            thisUser.id = idTextField.text!
            thisUser.name = nameTextField.text!
            thisUser.gender = genderList.firstIndex(of: genderTextField.text!)!
            print(thisUser)
            // 如果有改 id ，檢查使用者輸入的 id 是否已經有人用了
            if thisUser.id != UserDefaults.standard.string(forKey: UserTitle.id.rawValue) {
                MyDataManager.shared.users.whereField(UserTitle.id.rawValue, isEqualTo: thisUser.id).getDocuments { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        if querySnapshot!.documents.count > 0 {
                            LKProgressHUD.showFailure(text: "此 ID 已存在")
                        } else {
                            self.updateToForebase(userToSave: self.thisUser)
                        }
                    }
                }
            } else {
                updateToForebase(userToSave: thisUser)
            }
        } else {
            LKProgressHUD.showFailure(text: "請輸入完整資訊")
        }
    }
    func updateToForebase(userToSave: User) {
        let hud = JGProgressHUD()
        hud.textLabel.text = "上傳中"
        hud.show(in: self.view)
        MyDataManager.shared.updateProfileInfo(changedUser: userToSave){ isSuccess, err in
            if let error = err {
                // Handle the error
                print("Error: \(error)")
            } else if let isSuccess = isSuccess {
                self.navigationController?.popViewController(animated: true)
                LKProgressHUD.showSuccess(text: "帳號更改成功")
                hud.dismiss()
            } else {
                print("No matching document found")
            }
        }
    }
    @objc func deleteAccount() {
        let controller = UIAlertController(title: "確定？", message: "要刪除帳號？刪除後需重新註冊", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "是", style: .default) { _ in
            MyDataManager.shared.removeThisuser(firebaseId: self.thisUser.firebaseId, userId: self.thisUser.id)
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                return
            }
            let loginVC = LoginViewController()
            sceneDelegate.window?.rootViewController = loginVC
            LKProgressHUD.showSuccess(text: "帳號刪除成功")
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        controller.addAction(cancelAction)
        present(controller, animated: true)
    }
}

// MARK: - UIPickerViewDelegate
extension InputProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderList.count
    }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderList[row]
    }
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = genderList[row]
    }
}
