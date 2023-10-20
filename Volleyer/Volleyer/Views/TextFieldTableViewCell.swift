//
//  TextFieldTableViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/19.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    static let identifier = "TextFieldTableViewCell"
    
    private let theLabel: UILabel = {
        let label = UILabel()
//        label.text = "開始時間"
        label.semiboldSmallLabel()
        return label
    }()
    lazy var theTextField: UITextField = {
        let textField = UITextField()
//        textField.regularTextField(placeHolder: "starttime")
//        textField.inputView = startDatePicker
//        textField.inputAccessoryView = createToolBar(doneTarget: #selector(doneStartDatePicker), endTarget: #selector(cancelTarget))
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(theLabel)
        contentView.addSubview(theTextField)
        NSLayoutConstraint.activate([
            theTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin),
            theTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),
            theTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin),
            theTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            theTextField.widthAnchor.constraint(equalToConstant: standardTextFieldWidth),
            theLabel.centerYAnchor.constraint(equalTo: theTextField.centerYAnchor),
            theLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            theTextField.leadingAnchor.constraint(equalTo: theLabel.trailingAnchor, constant: standardMargin)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createToolBar(doneTarget: Selector, endTarget: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: doneTarget)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: endTarget)
        toolbar.sizeToFit()
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        return toolbar
    }
}
