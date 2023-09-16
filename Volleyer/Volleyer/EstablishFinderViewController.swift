//
//  EstablishFinderViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/15.
//

import UIKit

class EstablishFinderViewController: UIViewController {
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        datePicker.minuteInterval = 5
        datePicker.sizeToFit()
        return datePicker
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
    private let placeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "PingFang TC", size: CGFloat(16))
        textField.textColor = UIColor.black
        textField.placeholder = "place"
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
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
    private let priceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "PingFang TC", size: CGFloat(16))
        textField.textColor = UIColor.black
        textField.placeholder = "price"
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    private let unitTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "PingFang TC", size: CGFloat(16))
        textField.textColor = UIColor.black
        textField.placeholder = "unit"
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
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
    private let typeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "PingFang TC", size: CGFloat(16))
        textField.textColor = UIColor.black
        textField.placeholder = "X 網 X 排"
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
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
    private let maleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "PingFang TC", size: CGFloat(16))
        textField.textColor = UIColor.black
        textField.placeholder = "male"
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
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
    private let femaleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "PingFang TC", size: CGFloat(16))
        textField.textColor = UIColor.black
        textField.placeholder = "female"
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 20)
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
    private var checkboxes: [UIButton] = []
    private var selectedStates: [UIButton: Bool] = [:]

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
        view.addSubview(saveButton)
        view.addSubview(levelLabel)
        view.addSubview(lackLabel)
        view.addSubview(maleLabel)
        view.addSubview(maleTextField)
        view.addSubview(femaleLabel)
        view.addSubview(femaleTextField)

        setLayout()
        setUpNavBar()
        setSABC()

        for i in 0...4 {
            createQuestion(text: positions[i], i: i)
        }
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

    func createQuestion(text: String, i: Int) {
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
        for _ in 0...4 {
            let checkbox = UIButton(type: .system)
            checkbox.translatesAutoresizingMaskIntoConstraints = false
            checkbox.setImage(UIImage(systemName: "square"), for: .normal)
            checkbox.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
            checkbox.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
            view.addSubview(checkbox)
            checkboxes.append(checkbox)
            selectedStates[checkbox] = false
            checkbox.leadingAnchor.constraint(equalTo: (previous as AnyObject).trailingAnchor, constant: standardMargin).isActive = true
            checkbox.topAnchor.constraint(equalTo: questionLabel.topAnchor).isActive = true
            choiceButtons.append(checkbox)
            previous = checkbox
        }
    }
    @objc func checkboxTapped(sender: UIButton) {
        selectedStates[sender] = !selectedStates[sender]!
        sender.isSelected = selectedStates[sender]!

        print("Checkbox selected state: \(selectedStates[sender] ?? false)")
    }

    func setUpNavBar() {
        navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = NavBarEnum.establishFinderPage.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    @objc func doneStartDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        startTimeTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    @objc func doneEndDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        endTimeTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    @objc func cancelToolbar() {
        self.view.endEditing(true)
    }

    @objc func addData() {
//        if authorTextField.text != "" {
//            let articles = Firestore.firestore().collection("articles")
//            let document = articles.document()
//            let data: [String: Any] = [
//                "author": [
//                    "email": "wayne@school.appworks.tw",
//                    "id": "waynechen323",
//                    "name": authorTextField.text as Any
//                ] as [String : Any],
//                "title": titleTextField.text as Any,
//                "content": contentTextField.text as Any,
//                "createdTime": Date().timeIntervalSince1970,
//                "id": document.documentID,
//                "category": tagTextField.text as Any
//            ]
//            document.setData(data) { err in
//                if let err = err {
//                    print("Error adding document: \(err)")
//                } else {
//                    print("Document added with ID: \(document.documentID)")
//                    self.navigationController?.popToRootViewController(animated: true)
//                }
//            }
//            print("add data")
//        } else {
//            let controller = UIAlertController(title: "post error", message: "need to input author", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            controller.addAction(okAction)
//            present(controller, animated: true)
//        }
//
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

            saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),
            saveButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            saveButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
