//
//  PlayerListTableViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/16.
//

import UIKit

struct Player {
    let name: String
    let gender: String
    // Add more properties as needed
}

protocol EditPlayersDelegate: AnyObject {
    func addPlayer(from cell: PlayerTableViewCell, add player: Player)
}

class PlayerTableViewCell: UITableViewCell {

    weak var playerDelegate: EditPlayersDelegate?

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.textColor = UIColor.gray2
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.isHidden = true
        return label
    }()
    private lazy var inputNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "PingFang TC", size: CGFloat(16))
        textField.textColor = UIColor.black
        textField.placeholder = "input name"
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
        label.text = "gender"
        label.textColor = UIColor.gray2
        label.font = .regularNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.isHidden = true
        return label
    }()
    private lazy var inputGenderTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "PingFang TC", size: CGFloat(16))
        textField.textColor = UIColor.black
        textField.placeholder = "input gender"
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
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("done", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(doneToView), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(genderLabel)
        contentView.addSubview(inputNameTextField)
        contentView.addSubview(inputGenderTextField)
        contentView.addSubview(rightButton)

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            genderLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            genderLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            genderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin/2),
            genderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin/2),

            inputNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            inputNameTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            inputNameTextField.widthAnchor.constraint(equalToConstant: standardSmallerTextFieldWidth*2),
            inputNameTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            inputGenderTextField.leadingAnchor.constraint(equalTo: inputNameTextField.trailingAnchor, constant: standardMargin),
            inputGenderTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            inputGenderTextField.widthAnchor.constraint(equalToConstant: standardSmallerTextFieldWidth*2),
            inputGenderTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),

            rightButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin/4),
            rightButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),
            rightButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin/4),
            rightButton.heightAnchor.constraint(equalToConstant: 20),
            rightButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    func showOnly(with player: Player) {
        nameLabel.text = player.name
        genderLabel.text = player.gender
        nameLabel.isHidden = false
        genderLabel.isHidden = false
        inputNameTextField.isHidden = true
        inputGenderTextField.isHidden = true
        rightButton.addTarget(self, action: #selector(viewProfile), for: .touchUpInside)
        rightButton.setTitle("view", for: .normal)
    }

    @objc func cancelToolbar() {
        self.endEditing(true)
    }

    @objc func doneToView(_ sender: UIButton) {
        if inputNameTextField.text != "" && inputGenderTextField.text != "" {
            let newPlayer = Player(name: inputNameTextField.text!, gender: inputGenderTextField.text!)
            showOnly(with: newPlayer)
            playerDelegate?.addPlayer(from: self, add: newPlayer)
        }
    }
    @objc func viewProfile(_ sender: UIButton) {
        print("will push to profile")
    }
}
