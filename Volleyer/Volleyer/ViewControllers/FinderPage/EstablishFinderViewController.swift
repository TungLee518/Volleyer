//
//  EstablishFinderViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/15.
//

import UIKit
import FirebaseFirestore
import JGProgressHUD

class EstablishFinderViewController: UIViewController {
    let formatter = DateFormatter()
    let startDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        datePicker.minuteInterval = 5
        datePicker.sizeToFit()
        return datePicker
    }()
    let endDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        datePicker.minuteInterval = 5
        datePicker.sizeToFit()
        return datePicker
    }()
    let typePicker: UIPickerView = {
        let typePicker = UIPickerView()
        typePicker.sizeToFit()
        return typePicker
    }()
    private let startTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "開始時間"
        label.semiboldSmallLabel()
        return label
    }()
    lazy var startTimeTextField: UITextField = {
        let textField = UITextField()
        textField.regularTextField(placeHolder: "starttime")
        textField.inputView = startDatePicker
        textField.inputAccessoryView = createToolBar(doneTarget: #selector(doneStartDatePicker))
        return textField
    }()
    private let endTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "結束時間"
        label.semiboldSmallLabel()
        return label
    }()
    lazy var endTimeTextField: UITextField = {
        let textField = UITextField()
        textField.regularTextField(placeHolder: "endtime")
        textField.inputAccessoryView = createToolBar(doneTarget: #selector(doneEndDatePicker))
        textField.inputView = endDatePicker
        return textField
    }()
    private let placeLabel: UILabel = {
        let label = UILabel()
        label.text = "地點"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var placeTextField: UITextField = {
        let textField = UITextField()
        textField.regularTextField(placeHolder: "place")
        textField.inputAccessoryView = createToolBar(doneTarget: #selector(donePlace))
        return textField
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "價錢"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var priceTextField: UITextField = {
        let textField = UITextField()
        textField.regularTextField(placeHolder: "price")
        textField.inputAccessoryView = createToolBar(doneTarget: #selector(donePrice))
        textField.keyboardType = .numberPad
        return textField
    }()
    private let unitLabel: UILabel = {
        let label = UILabel()
        label.text = "元/人"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "場種"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var typeTextField: UITextField = {
        let textField = UITextField()
        textField.regularTextField(placeHolder: "X 網 X 排")
        textField.inputView = typePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(cancelToolbar))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        return textField
    }()
    private let lackLabel: UILabel = {
        let label = UILabel()
        label.text = "缺"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let maleLabel: UILabel = {
        let label = UILabel()
        label.text = "男"
        label.textColor = UIColor.gray2
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var maleTextField: UITextField = {
        let textField = UITextField()
        textField.regularTextField(placeHolder: "male")
        textField.inputAccessoryView = createToolBar(doneTarget: #selector(doneMaleLack))
        textField.keyboardType = .numberPad
        return textField
    }()
    private let femaleLabel: UILabel = {
        let label = UILabel()
        label.text = "女"
        label.textColor = .gray2
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var femaleTextField: UITextField = {
        let textField = UITextField()
        textField.regularTextField(placeHolder: "female")
        textField.inputAccessoryView = createToolBar(doneTarget: #selector(doneFemaleLack))
        textField.keyboardType = .numberPad
        return textField
    }()
    lazy var publishButton: UIButton = {
        let button = UIButton()
        button.purpleButton()
        button.setTitle(EstablishPageEnum.publish.rawValue, for: .normal)
        button.addTarget(self, action: #selector(addData), for: .touchUpInside)
        return button
    }()
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.whiteButton()
        button.setTitle(EstablishPageEnum.save.rawValue, for: .normal)
        button.addTarget(self, action: #selector(addData), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    lazy var deletePostButton: UIButton = {
        let button = UIButton()
        button.whiteButton()
        button.setTitle(EstablishPageEnum.deletePost.rawValue, for: .normal)
        button.addTarget(self, action: #selector(deletePost), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.text = EstablishPageEnum.level.rawValue
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var setCheckboxes: [UIButton] = []
    var blocCheckboxes: [UIButton] = []
    var digCheckboxes: [UIButton] = []
    var spickCheckboxes: [UIButton] = []
    var sumCheckboxes: [UIButton] = []

    private let playerListTableView = PlayerListTableView(frame: .zero, style: .plain)

    private var levelRange = LevelRange(setBall: 4, block: 4, dig: 4, spike: 4, sum: 4)
    private var lackAmount = LackAmount(male: 0, female: 0, unlimited: 0)

    lazy var thisPlay: Play = Play(id: "", finderId: UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "Wrong User Id", startTime: Date(), endTime: Date(), place: "", price: 0, type: 0, levelRange: levelRange, lackAmount: lackAmount, playerInfo: [], status: 0)

    var players: [Player] = []
    var SABCLabels: [UILabel] = []

    var dataManager = FinderDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        addViews()
        setUpNavBar()
        setSABC()
        setCheckboxes = createCheckboxes(leftLabel: createLevelLabels(text: positions[0], i: 0), action: #selector(setCheckboxTapped))
        blocCheckboxes = createCheckboxes(leftLabel: createLevelLabels(text: positions[1], i: 1), action: #selector(blockCheckboxTapped))
        digCheckboxes = createCheckboxes(leftLabel: createLevelLabels(text: positions[2], i: 2), action: #selector(digCheckboxTapped))
        spickCheckboxes = createCheckboxes(leftLabel: createLevelLabels(text: positions[3], i: 3), action: #selector(spickCheckboxTapped))
        sumCheckboxes = createCheckboxes(leftLabel: createLevelLabels(text: positions[4], i: 4), action: #selector(sumCheckboxTapped))
        setLayout()
        typePicker.dataSource = self
        typePicker.delegate = self
        ifEditMode()
    }

    func addViews() {
        view.addSubview(startTimeLabel)
        view.addSubview(startTimeTextField)
        view.addSubview(endTimeLabel)
        view.addSubview(endTimeTextField)
        view.addSubview(placeLabel)
        view.addSubview(placeTextField)
        view.addSubview(priceLabel)
        view.addSubview(priceTextField)
        view.addSubview(unitLabel)
        view.addSubview(typeLabel)
        view.addSubview(typeTextField)
        view.addSubview(levelLabel)
        view.addSubview(lackLabel)
        view.addSubview(maleLabel)
        view.addSubview(maleTextField)
        view.addSubview(femaleLabel)
        view.addSubview(femaleTextField)
        view.addSubview(deletePostButton)
        view.addSubview(publishButton)
    }

    func setUpNavBar() {
        navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = NavBarEnum.establishFinderPage.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .purple2
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
    }

    func setSABC() {
        var previous: Any = levelLabel
        for i in 0...4 {
            let label = UILabel()
            label.text = levelList[i]
            label.textColor = .gray3
            label.font = .regularNunito(size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            if i == 0 {
                label.leadingAnchor.constraint(equalTo: typeTextField.leadingAnchor).isActive = true
            } else {
                label.leadingAnchor.constraint(equalTo: (previous as AnyObject).trailingAnchor, constant: standardMargin+20).isActive = true
            }
            label.centerYAnchor.constraint(equalTo: levelLabel.centerYAnchor).isActive = true
            SABCLabels.append(label)
            previous = label
        }
    }

    func createLevelLabels(text: String, i: Int) -> UILabel {
        // Create a label
        let label = UILabel()
        label.text = text
        label.regularSmallLabel()
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: levelLabel.trailingAnchor, constant: standardMargin),
            label.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: (standardMargin + 10) * (Double(i)+0.2))
        ])
        return label
    }

    func createCheckboxes(leftLabel: UILabel, action: Selector) -> [UIButton] {
        // Create checkboxes for each choice
        var choiceButtons: [UIButton] = []
        for i in 0...4 {
            let checkbox = UIButton(type: .custom)
            checkbox.translatesAutoresizingMaskIntoConstraints = false
            checkbox.setImage(UIImage(systemName: "square"), for: .normal)
            checkbox.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
            checkbox.tintColor = .purple2
            checkbox.addTarget(self, action: action, for: .touchUpInside)
            checkbox.tag = i
            view.addSubview(checkbox)
            checkbox.centerXAnchor.constraint(equalTo: SABCLabels[i].centerXAnchor).isActive = true
            checkbox.topAnchor.constraint(equalTo: leftLabel.topAnchor).isActive = true
            choiceButtons.append(checkbox)
            if i == 4 {
                checkbox.isSelected = true
            }
        }
        return choiceButtons
    }

    func ifEditMode() {
        if thisPlay.id != "" {
            deletePostButton.isHidden = false
            publishButton.setTitle(EstablishPageEnum.save.rawValue, for: .normal)
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            startTimeTextField.text = formatter.string(from: thisPlay.startTime)
            startDatePicker.date = thisPlay.startTime
            endTimeTextField.text = formatter.string(from: thisPlay.endTime)
            endDatePicker.date = thisPlay.endTime
            placeTextField.text = thisPlay.place
            priceTextField.text = String(thisPlay.price)
            typeTextField.text = playTypes[thisPlay.type]
            maleTextField.text = String(thisPlay.lackAmount.male)
            femaleTextField.text = String(thisPlay.lackAmount.female)
            setCheckboxTapped(sender: setCheckboxes[thisPlay.levelRange.setBall])
            blockCheckboxTapped(sender: blocCheckboxes[thisPlay.levelRange.block])
            digCheckboxTapped(sender: digCheckboxes[thisPlay.levelRange.dig])
            spickCheckboxTapped(sender: spickCheckboxes[thisPlay.levelRange.spike])
            sumCheckboxTapped(sender: sumCheckboxes[thisPlay.levelRange.sum])
        }
    }
    func createToolBar(doneTarget: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: doneTarget)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelToolbar))
        toolbar.sizeToFit()
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        return toolbar
    }
    @objc func setCheckboxTapped(sender: UIButton) {
        print(sender.tag)
        thisPlay.levelRange.setBall = sender.tag
        for checkbox in setCheckboxes {
            checkbox.isSelected = (checkbox == sender)
        }
    }
    @objc func blockCheckboxTapped(sender: UIButton) {
        print(sender.tag)
        thisPlay.levelRange.block = sender.tag
        for checkbox in blocCheckboxes {
            checkbox.isSelected = (checkbox == sender)
        }
    }
    @objc func digCheckboxTapped(sender: UIButton) {
        print(sender.tag)
        thisPlay.levelRange.dig = sender.tag
        for checkbox in digCheckboxes {
            checkbox.isSelected = (checkbox == sender)
        }
    }
    @objc func spickCheckboxTapped(sender: UIButton) {
        print(sender.tag)
        thisPlay.levelRange.spike = sender.tag
        for checkbox in spickCheckboxes {
            checkbox.isSelected = (checkbox == sender)
        }
    }
    @objc func sumCheckboxTapped(sender: UIButton) {
        print(sender.tag)
        thisPlay.levelRange.sum = sender.tag
        for checkbox in sumCheckboxes {
            checkbox.isSelected = (checkbox == sender)
        }
    }
    @objc func doneStartDatePicker(_ sender: UIBarItem) {
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        startTimeTextField.text = formatter.string(from: startDatePicker.date)
        thisPlay.startTime = startDatePicker.date
        if endTimeTextField.text == "" {
            endDatePicker.date = startDatePicker.date
        }
        self.view.endEditing(true)
    }
    @objc func doneEndDatePicker() {
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        endTimeTextField.text = formatter.string(from: endDatePicker.date)
        thisPlay.endTime = endDatePicker.date
        self.view.endEditing(true)
    }
    @objc func donePlace() {
        if placeTextField.text?.count ?? 0 > 15 {
            LKProgressHUD.showFailure(text: "字數勿超過 15 字")
        } else {
            self.view.endEditing(true)
        }
    }
    @objc func donePrice() {
        let priceInput = Int(priceTextField.text ?? "-1") ?? -1
        print(priceInput)
        if priceInput > 100000 || priceInput < 0 {
            LKProgressHUD.showFailure(text: "請輸入合理價格")
        } else {
            self.view.endEditing(true)
        }
    }
    @objc func doneMaleLack() {
        let amount = Int(maleTextField.text ?? "-1") ?? -1
        print(amount)
        if amount > 99 || amount < 0 {
            LKProgressHUD.showFailure(text: "請輸入合理人數")
        } else {
            self.view.endEditing(true)
        }
    }
    @objc func doneFemaleLack() {
        let amount = Int(femaleTextField.text ?? "-1") ?? -1
        print(amount)
        if amount > 99 || amount < 0 {
            LKProgressHUD.showFailure(text: "請輸入合理人數")
        } else {
            self.view.endEditing(true)
        }
    }
    @objc func cancelToolbar() {
        self.view.endEditing(true)
    }

    @objc func addData(_ sender: UIButton) {
//        players = playerListTableView.players
        if sender == publishButton {
            thisPlay.status = 1
        }
        if startTimeTextField.text != "", endTimeTextField.text != "", placeTextField.text != "", priceTextField.text != "", typeTextField.text != ""
            , maleTextField.text != "", femaleTextField.text != "" {
            if thisPlay.startTime > thisPlay.endTime {
                LKProgressHUD.showFailure(text: "結束時間早於開始時間")
            } else {
                let placeInput = placeTextField.text ?? "input invalind place by user"
                let priceInput = Int(priceTextField.text ?? "1000000") ?? 1000000
                let maleInput = Int(maleTextField.text ?? "100") ?? 100
                let femaleInput = Int(femaleTextField.text ?? "100") ?? 100
                if placeInput.count > 15 || priceInput > 100000 || priceInput < 0 || maleInput > 99 || maleInput < 0 || femaleInput > 99 || femaleInput < 0 {
                    LKProgressHUD.showFailure(text: "請符合字數限制")
                } else {
                    thisPlay.place = placeTextField.text ?? "input error"
                    thisPlay.price = priceInput
                    thisPlay.type = playTypes.firstIndex(of: typeTextField.text ?? "select error") ?? 0
                    thisPlay.lackAmount.male = maleInput
                    thisPlay.lackAmount.female = femaleInput
                    if thisPlay.id == "" {
                        dataManager.savePlay(thisPlay)
                        LKProgressHUD.showSuccess(text: "發文成功")
                        navigationController?.popToRootViewController(animated: true)
                    } else {
                        dataManager.updatePlay(thisPlay)
                        LKProgressHUD.showSuccess(text: "更改成功")
                        for controller in (self.navigationController?.viewControllers ?? []) as Array {
                            print(controller)
                            if controller.isKind(of: MyFindersViewController.self) {
                                self.navigationController?.popToViewController(controller, animated: true)
                                break
                            }
                        }
                    }
                }
            }
        } else {
            LKProgressHUD.showFailure(text: "請填寫完整資訊")
        }
    }
    @objc func deletePost() {
        let controller = UIAlertController(title: "確定？", message: "要刪除貼文？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "是", style: .default) { _ in
            print("確定要刪除")
            self.dataManager.deletePlay(self.thisPlay) { err in
                if err == nil {
                    for controller in (self.navigationController?.viewControllers ?? []) as Array {
                        print(controller)
                        if controller.isKind(of: MyFindersViewController.self) {
                            self.navigationController!.popToViewController(controller, animated: true)
                            break
                        }
                    }
                    LKProgressHUD.showSuccess(text: AlertTitile.successDeletePost.rawValue)
                } else {
                    LKProgressHUD.showFailure(text: AlertTitile.failureDeletePost.rawValue)
                    print(err as Any)
                }
            }
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        controller.addAction(cancelAction)
        present(controller, animated: true)
    }

    func setLayout() {
        NSLayoutConstraint.activate([
            startTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            startTimeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: standardMargin*5),
            startTimeTextField.leadingAnchor.constraint(equalTo: startTimeLabel.trailingAnchor, constant: standardMargin),
            startTimeTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            startTimeTextField.centerYAnchor.constraint(equalTo: startTimeLabel.centerYAnchor),
            startTimeTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            startTimeTextField.widthAnchor.constraint(equalToConstant: standardTextFieldWidth),

            endTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            endTimeLabel.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: standardMargin),
            endTimeTextField.leadingAnchor.constraint(equalTo: endTimeLabel.trailingAnchor, constant: standardMargin),
            endTimeTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            endTimeTextField.centerYAnchor.constraint(equalTo: endTimeLabel.centerYAnchor),
            endTimeTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            endTimeTextField.widthAnchor.constraint(equalToConstant: standardTextFieldWidth),

            placeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            placeLabel.topAnchor.constraint(equalTo: endTimeLabel.bottomAnchor, constant: standardMargin),
            placeTextField.leadingAnchor.constraint(equalTo: placeLabel.trailingAnchor, constant: standardMargin),
            placeTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            placeTextField.centerYAnchor.constraint(equalTo: placeLabel.centerYAnchor),
            placeTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            placeTextField.widthAnchor.constraint(equalToConstant: standardTextFieldWidth),

            priceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            priceLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: standardMargin),
            priceTextField.leadingAnchor.constraint(equalTo: placeTextField.leadingAnchor),
            priceTextField.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            priceTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            unitLabel.leadingAnchor.constraint(equalTo: priceTextField.trailingAnchor, constant: standardMargin),
            unitLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            unitLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            unitLabel.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            unitLabel.widthAnchor.constraint(equalToConstant: standardSmallerTextFieldWidth),

            typeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            typeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: standardMargin),
            typeTextField.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: standardMargin),
            typeTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            typeTextField.centerYAnchor.constraint(equalTo: typeLabel.centerYAnchor),
            typeTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            typeTextField.widthAnchor.constraint(equalToConstant: standardTextFieldWidth),

            lackLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            lackLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: standardMargin),
            maleLabel.leadingAnchor.constraint(equalTo: typeTextField.leadingAnchor, constant: standardMargin),
            maleLabel.centerYAnchor.constraint(equalTo: lackLabel.centerYAnchor),
            maleTextField.centerYAnchor.constraint(equalTo: lackLabel.centerYAnchor),
            maleTextField.widthAnchor.constraint(equalToConstant: standardSmallerTextFieldWidth),
            maleTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            maleTextField.trailingAnchor.constraint(equalTo: typeTextField.leadingAnchor, constant: standardTextFieldWidth / 2),
            femaleLabel.leadingAnchor.constraint(equalTo: typeTextField.leadingAnchor, constant: standardTextFieldWidth / 2 + standardMargin),
            femaleLabel.centerYAnchor.constraint(equalTo: lackLabel.centerYAnchor),
            femaleTextField.centerYAnchor.constraint(equalTo: lackLabel.centerYAnchor),
            femaleTextField.widthAnchor.constraint(equalToConstant: standardSmallerTextFieldWidth),
            femaleTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            femaleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),

            levelLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            levelLabel.topAnchor.constraint(equalTo: lackLabel.bottomAnchor, constant: standardMargin),
            publishButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            publishButton.topAnchor.constraint(equalTo: sumCheckboxes[0].bottomAnchor, constant: standardMargin*2),
            publishButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            publishButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: standardMargin/2),

            deletePostButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: standardMargin),
            deletePostButton.trailingAnchor.constraint(equalTo: publishButton.leadingAnchor, constant: -standardMargin/2),
            deletePostButton.centerYAnchor.constraint(equalTo: publishButton.centerYAnchor),
            deletePostButton.heightAnchor.constraint(equalToConstant: standardButtonHeight)
        ])
    }
}

// MARK: - UIPickerViewDelegate
extension EstablishFinderViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return playTypes.count
    }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return playTypes[row]
    }
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeTextField.text = playTypes[row]
    }
}
