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
    private let pleaseInputLabel: UILabel = {
        let label = UILabel()
        label.text = "來輸入資訊"
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
        textField.placeholder = "id"
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
        textField.placeholder = "name"
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
        textField.placeholder = "email"
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
        textField.placeholder = "gender"
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
        button.layer.borderWidth = 3
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

    var setCheckboxes: [UIButton] = []
    var blocCheckboxes: [UIButton] = []
    var digCheckboxes: [UIButton] = []
    var spickCheckboxes: [UIButton] = []
    var sumCheckboxes: [UIButton] = []
    var SABCLabels: [UILabel] = []

    lazy var thisUser = User(id: "", email: "", gender: -1, name: "")

    override func viewDidLoad() {
        super.viewDidLoad()

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

        MyDataManager.shared.canGoToTabbarVC = { [weak self] canGoToTabbarVc in
            guard let self = self else { return }
            if canGoToTabbarVc {
                let viewController = TabBarViewController()
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true)
            } else {
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = "此 ID 已存在"
                hud.indicatorView = JGProgressHUDErrorIndicatorView()
                hud.show(in: view)
                hud.dismiss(afterDelay: 1.5)
            }
        }
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
            LKProgressHUD.showFailure(text: "請輸入完整資訊")
        }
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
