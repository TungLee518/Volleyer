//
//  EstablishFinderViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/15.
//

import UIKit
import FirebaseFirestore

class EstablishFinderViewController: UIViewController, PlayerListTableViewDelegate {
    let datePicker: UIDatePicker = {
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
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    private lazy var startTimeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "PingFang TC", size: CGFloat(16))
        textField.textColor = UIColor.black
        textField.placeholder = "starttime"
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneStartDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelToolbar))
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)

        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker

        return textField
    }()
    private let endTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "結束時間"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    private lazy var endTimeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "PingFang TC", size: CGFloat(16))
        textField.textColor = UIColor.black
        textField.placeholder = "endtime"
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneEndDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelToolbar))
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)

        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
        return textField
    }()
    private let placeLabel: UILabel = {
        let label = UILabel()
        label.text = "地點"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var placeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "PingFang TC", size: CGFloat(16))
        textField.textColor = UIColor.black
        textField.placeholder = "place"
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
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "價錢"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var priceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "PingFang TC", size: CGFloat(16))
        textField.textColor = UIColor.black
        textField.placeholder = "price"
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.keyboardType = .numberPad
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(cancelToolbar))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        return textField
    }()
    private lazy var unitTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "PingFang TC", size: CGFloat(16))
        textField.textColor = UIColor.black
        textField.placeholder = "unit"
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
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "場種"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var typeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "PingFang TC", size: CGFloat(16))
        textField.textColor = UIColor.black
        textField.placeholder = "X 網 X 排"
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
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
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let maleLabel: UILabel = {
        let label = UILabel()
        label.text = "男"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var maleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "PingFang TC", size: CGFloat(16))
        textField.textColor = UIColor.black
        textField.placeholder = "male"
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.keyboardType = .numberPad
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(cancelToolbar))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        return textField
    }()
    private let femaleLabel: UILabel = {
        let label = UILabel()
        label.text = "女"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var femaleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "PingFang TC", size: CGFloat(16))
        textField.textColor = UIColor.black
        textField.placeholder = "female"
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.keyboardType = .numberPad
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(cancelToolbar))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        return textField
    }()
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 20)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addPlayer), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleEditingMode), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    lazy var publishButton: UIButton = {
        let button = UIButton()
        button.setTitle("Publish", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addData), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addData), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.text = "程度"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var setCheckboxes: [UIButton] = []
    private var blocCheckboxes: [UIButton] = []
    private var digCheckboxes: [UIButton] = []
    private var spickCheckboxes: [UIButton] = []
    private var sumCheckboxes: [UIButton] = []

    private let playerListTableView = PlayerListTableView(frame: .zero, style: .plain)

    private var levelRange = LevelRange(setBall: 4, block: 4, dig: 4, spike: 4, sum: 4)
    private var lackAmount = LackAmount(male: 0, female: 0, unlimited: 0)

    lazy private var thisPlay: Play = Play(id: "maymmm518", startTime: Date(), endTime: Date(), place: "", price: 0, type: 0, levelRange: levelRange, lackAmount: lackAmount, playerInfo: [], status: 0)
    let players: [Player] = [
        Player(name: "Player 1", gender: "Male"),
        Player(name: "Player 2", gender: "Female"),
        Player(name: "Player 3", gender: "Male"),
        Player(name: "Player 4", gender: "Female"),
        Player(name: "Player 5", gender: "Male"),
        Player(name: "Player 6", gender: "Female"),
        Player(name: "Player 7", gender: "Male"),
        Player(name: "Player 8", gender: "Female"),
        Player(name: "Player 9", gender: "Male"),
        Player(name: "Player 10", gender: "Female"),
        Player(name: "Player 11", gender: "Male"),
        Player(name: "Player 12", gender: "Female")
    ]

    var dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        view.addSubview(startTimeLabel)
        view.addSubview(startTimeTextField)
        view.addSubview(endTimeLabel)
        view.addSubview(endTimeTextField)
        view.addSubview(placeLabel)
        view.addSubview(placeTextField)
        view.addSubview(priceLabel)
        view.addSubview(priceTextField)
        view.addSubview(unitTextField)
        view.addSubview(typeLabel)
        view.addSubview(typeTextField)
        view.addSubview(levelLabel)
        view.addSubview(lackLabel)
        view.addSubview(maleLabel)
        view.addSubview(maleTextField)
        view.addSubview(femaleLabel)
        view.addSubview(femaleTextField)
        view.addSubview(saveButton)
        view.addSubview(publishButton)
        view.addSubview(deleteButton)
        view.addSubview(addButton)

        setUpNavBar()
        setSABC()

        setCheckboxes = createCheckboxes(text: positions[0], i: 0, action: #selector(setCheckboxTapped))
        blocCheckboxes = createCheckboxes(text: positions[1], i: 1, action: #selector(blockCheckboxTapped))
        digCheckboxes = createCheckboxes(text: positions[2], i: 2, action: #selector(digCheckboxTapped))
        spickCheckboxes = createCheckboxes(text: positions[3], i: 3, action: #selector(spickCheckboxTapped))
        sumCheckboxes = createCheckboxes(text: positions[4], i: 4, action: #selector(sumCheckboxTapped))

        setPlayListTableView()
        setLayout()
        typePicker.dataSource = self
        typePicker.delegate = self
    }
    
    func setUpNavBar() {
        navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = NavBarEnum.establishFinderPage.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    func setPlayListTableView() {
        view.addSubview(playerListTableView)
        playerListTableView.translatesAutoresizingMaskIntoConstraints = false
        playerListTableView.playerListDelegate = self
        playerListTableView.players = players
    }

    func setSABC() {
        var previous: Any = levelLabel
        for i in 0...4 {
            let label = UILabel()
            label.text = levels[i]
            label.textColor = UIColor.gray
            label.font = UIFont.systemFont(ofSize: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            label.leadingAnchor.constraint(equalTo: (previous as AnyObject).trailingAnchor, constant: standardMargin+20).isActive = true
            label.centerYAnchor.constraint(equalTo: levelLabel.centerYAnchor).isActive = true
            previous = label
        }
    }

    func createCheckboxes(text: String, i: Int, action: Selector) -> [UIButton] {
        // Create a label for the question
        let questionLabel = UILabel()
        questionLabel.text = text
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionLabel)
        // Create constraints for the question label
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: levelLabel.trailingAnchor, constant: standardMargin),
            questionLabel.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: (standardMargin + 10) * Double(i))
        ])

        // Create checkboxes for each choice
        var choiceButtons: [UIButton] = []
        var previous: Any = questionLabel
        for i in 0...4 {
            let checkbox = UIButton(type: .system)
            checkbox.translatesAutoresizingMaskIntoConstraints = false
            checkbox.setImage(UIImage(systemName: "square"), for: .normal)
            checkbox.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
            checkbox.addTarget(self, action: action, for: .touchUpInside)
            checkbox.tag = i
            view.addSubview(checkbox)
            checkbox.leadingAnchor.constraint(equalTo: (previous as AnyObject).trailingAnchor, constant: standardMargin).isActive = true
            checkbox.topAnchor.constraint(equalTo: questionLabel.topAnchor).isActive = true
            choiceButtons.append(checkbox)
            previous = checkbox
        }
        return choiceButtons
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
    @objc func doneStartDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        startTimeTextField.text = formatter.string(from: datePicker.date)
        thisPlay.startTime = datePicker.date
        self.view.endEditing(true)
    }
    @objc func doneEndDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        endTimeTextField.text = formatter.string(from: datePicker.date)
        thisPlay.endTime = datePicker.date
        self.view.endEditing(true)
    }
    @objc func cancelToolbar() {
        self.view.endEditing(true)
    }
    @objc func toggleEditingMode() {
        playerListTableView.toggleEditing()
        let buttonText = playerListTableView.isEditingEnabled ? "Done" : "Edit"
        deleteButton.setTitle(buttonText, for: .normal)
    }
    @objc func addPlayer() {
        let newPlayer = Player(name: "New Player", gender: "Unknown") // Customize as needed
        playerListTableView.addNewPlayer(newPlayer)
    }

    func didTapProfileButton(for player: Player) {
        // Handle profile button tap for the selected player
        print("Tapped on profile button for \(player.name)")
        // Navigate to the player's profile view or perform any other action
    }

    @objc func addData(_ sender: UIButton) {
        if sender == publishButton {
            thisPlay.status = 1
        }
        if placeTextField.text != "", priceTextField.text != "", typeTextField.text != ""
            , maleTextField.text != "", femaleTextField.text != "" {
            thisPlay.place = placeTextField.text!
            thisPlay.price = Int(priceTextField.text!)!
            thisPlay.type = playTypes.firstIndex(of: typeTextField.text!)!
            thisPlay.lackAmount.male = Int(maleTextField.text!)!
            thisPlay.lackAmount.female = Int(femaleTextField.text!)!
            // thisPlay.playerInfo = players
            print(thisPlay)
            dataManager.savePlay(thisPlay)
            navigationController?.popToRootViewController(animated: true)
        }
    }

    func setLayout() {
        NSLayoutConstraint.activate([
            startTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            startTimeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: standardMargin),
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
            unitTextField.leadingAnchor.constraint(equalTo: priceTextField.trailingAnchor, constant: standardMargin),
            unitTextField.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            unitTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            unitTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            unitTextField.widthAnchor.constraint(equalToConstant: standardSmallerTextFieldWidth),

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
            maleTextField.trailingAnchor.constraint(equalTo: typeTextField.leadingAnchor, constant: standardTextFieldWidth / 2),
            femaleLabel.leadingAnchor.constraint(equalTo: typeTextField.leadingAnchor, constant: standardTextFieldWidth / 2 + standardMargin),
            femaleLabel.centerYAnchor.constraint(equalTo: lackLabel.centerYAnchor),
            femaleTextField.centerYAnchor.constraint(equalTo: lackLabel.centerYAnchor),
            femaleTextField.widthAnchor.constraint(equalToConstant: standardSmallerTextFieldWidth),
            femaleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),

            levelLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            levelLabel.topAnchor.constraint(equalTo: lackLabel.bottomAnchor, constant: standardMargin),

//            playerListView.topAnchor.constraint(equalTo: checkboxes[-1].bottomAnchor, constant: standardMargin),
            playerListTableView.heightAnchor.constraint(equalToConstant: 200.0),
            playerListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            playerListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),

            saveButton.topAnchor.constraint(equalTo: playerListTableView.bottomAnchor, constant: standardMargin),
            saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),
            saveButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            saveButton.widthAnchor.constraint(equalToConstant: 70),
            publishButton.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -standardMargin),
            publishButton.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor),
            publishButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            publishButton.widthAnchor.constraint(equalToConstant: 70),
            deleteButton.trailingAnchor.constraint(equalTo: publishButton.leadingAnchor, constant: -standardMargin),
            deleteButton.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            deleteButton.widthAnchor.constraint(equalToConstant: 70),
            addButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -standardMargin),
            addButton.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor),
            addButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            addButton.widthAnchor.constraint(equalToConstant: 70)
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