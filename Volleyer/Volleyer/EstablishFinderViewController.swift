//
//  EstablishFinderViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/15.
//

import UIKit

class EstablishFinderViewController: UIViewController {

    private let timeLable: UILabel = {
        let label = UILabel()
        label.text = "時間"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    private let timeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "PingFang TC", size: CGFloat(16))
        textField.textColor = UIColor.black
        textField.placeholder = "time"
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    private let placeLable: UILabel = {
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
    private let priceLable: UILabel = {
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
    private let typeLable: UILabel = {
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        view.addSubview(timeLable)
        view.addSubview(timeTextField)
        view.addSubview(placeLable)
        view.addSubview(placeTextField)
        view.addSubview(priceLable)
        view.addSubview(priceTextField)
        view.addSubview(unitTextField)
        view.addSubview(typeLable)
        view.addSubview(typeTextField)
        view.addSubview(saveButton)

        setLayout()
        setUpNavBar()

    }

    func setUpNavBar() {
        navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = NavBarEnum.establishFinderPage.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "input content"
            textView.textColor = UIColor.lightGray
        }
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
            timeLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            timeLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: standardMargin),
            timeTextField.leadingAnchor.constraint(equalTo: timeLable.trailingAnchor, constant: standardMargin),
            timeTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            timeTextField.centerYAnchor.constraint(equalTo: timeLable.centerYAnchor),
            timeTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            timeTextField.widthAnchor.constraint(equalToConstant: standardTextFieldWidth),

            placeLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            placeLable.topAnchor.constraint(equalTo: timeLable.bottomAnchor, constant: standardMargin),
            placeTextField.leadingAnchor.constraint(equalTo: placeLable.trailingAnchor, constant: standardMargin),
            placeTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            placeTextField.centerYAnchor.constraint(equalTo: placeLable.centerYAnchor),
            placeTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            placeTextField.widthAnchor.constraint(equalToConstant: standardTextFieldWidth),

            priceLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            priceLable.topAnchor.constraint(equalTo: placeLable.bottomAnchor, constant: standardMargin),
            priceTextField.leadingAnchor.constraint(equalTo: placeTextField.leadingAnchor),
            priceTextField.centerYAnchor.constraint(equalTo: priceLable.centerYAnchor),
            priceTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            unitTextField.leadingAnchor.constraint(equalTo: priceTextField.trailingAnchor, constant: standardMargin),
            unitTextField.centerYAnchor.constraint(equalTo: priceLable.centerYAnchor),
            unitTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            unitTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            unitTextField.widthAnchor.constraint(equalToConstant: standardSmallerTextFieldWidth),

            typeLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            typeLable.topAnchor.constraint(equalTo: priceLable.bottomAnchor, constant: standardMargin),
            typeTextField.leadingAnchor.constraint(equalTo: typeLable.trailingAnchor, constant: standardMargin),
            typeTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            typeTextField.centerYAnchor.constraint(equalTo: typeLable.centerYAnchor),
            typeTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            typeTextField.widthAnchor.constraint(equalToConstant: standardTextFieldWidth),

            saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),
            saveButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            saveButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}

class CheckBox: UIButton {
    // Images
    // let checkedImage = UIImage(named: "ic_check_box")! as UIImage
    // let uncheckedImage = UIImage(named: "ic_check_box_outline_blank")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.backgroundColor = UIColor.black
                //self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.backgroundColor = UIColor.white
                //self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
        
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
