//
//  TextFieldTableViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/19.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    static let identifier = "TextFieldTableViewCell"

    let theLabel: UILabel = {
        let label = UILabel()
        label.semiboldSmallLabel()
        return label
    }()
    let theTextField: UITextField = {
        let textField = UITextField()
        textField.regularTextField(placeHolder: "test")
        return textField
    }()
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
    var setCheckboxesList: [UIButton] = []
    var blocCheckboxesList: [UIButton] = []
    var digCheckboxesList: [UIButton] = []
    var spikeCheckboxesList: [UIButton] = []
    var sumCheckboxesList: [UIButton] = []
    private var levelRange = LevelRange(setBall: 4, block: 4, dig: 4, spike: 4, sum: 4)
    private var lackAmount = LackAmount(male: 0, female: 0, unlimited: 0)

    lazy var thisPlay: Play = Play(id: "", finderId: UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "Wrong User Id", startTime: Date(), endTime: Date(), place: "", price: 0, type: 0, levelRange: levelRange, lackAmount: lackAmount, playerInfo: [], status: 0)

    func setLabelAndTextField() {
        contentView.addSubview(theLabel)
        contentView.addSubview(theTextField)
        NSLayoutConstraint.activate([
            theTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin),
            theTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),
            theTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            theTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            theTextField.widthAnchor.constraint(equalToConstant: standardTextFieldWidth),
            theLabel.centerYAnchor.constraint(equalTo: theTextField.centerYAnchor),
            theLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            theTextField.leadingAnchor.constraint(equalTo: theLabel.trailingAnchor, constant: standardMargin)
        ])
    }

    func setStartTime() {
        
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

    func setSABC() {
        setLabelAndTextField()
        theLabel.text = "程度"
        theTextField.isHidden = true
        var previous: Any = theLabel
        for i in 0...4 {
            let label = UILabel()
            label.text = levelList[i]
            label.regularSmallLabel()
            contentView.addSubview(label)
            label.leadingAnchor.constraint(equalTo: (previous as AnyObject).trailingAnchor, constant: standardMargin+20).isActive = true
            label.centerYAnchor.constraint(equalTo: theLabel.centerYAnchor).isActive = true
//            SABCLabels.append(label)
            previous = label
        }
    }

    func createCheckboxes(text: String, action: Selector) -> [UIButton] {
        setLabelAndTextField()
        theLabel.text = text
        theTextField.isHidden = true
        // Create checkboxes for each choice
        var choiceButtons: [UIButton] = []
        var previous: Any = theLabel
        for i in 0...4 {
            let checkbox = UIButton(type: .custom)
            checkbox.translatesAutoresizingMaskIntoConstraints = false
            checkbox.setImage(UIImage(systemName: "square"), for: .normal)
            checkbox.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
            checkbox.tintColor = .purple2
            checkbox.addTarget(self, action: action, for: .touchUpInside)
            checkbox.tag = i
            contentView.addSubview(checkbox)
            checkbox.leadingAnchor.constraint(equalTo: (previous as AnyObject).trailingAnchor, constant: standardMargin+20).isActive = true
            checkbox.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//            checkbox.topAnchor.constraint(equalTo: theLabel.topAnchor).isActive = true
            choiceButtons.append(checkbox)
            if i == 4 {
                checkbox.isSelected = true
            }
            previous = checkbox
        }
        return choiceButtons
    }
    @objc func setCheckboxTapped(sender: UIButton) {
        print(sender.tag)
        thisPlay.levelRange.setBall = sender.tag
        for checkbox in setCheckboxesList {
            checkbox.isSelected = (checkbox == sender)
        }
    }
    @objc func blockCheckboxTapped(sender: UIButton) {
        print(sender.tag)
        thisPlay.levelRange.block = sender.tag
        for checkbox in blocCheckboxesList {
            checkbox.isSelected = (checkbox == sender)
        }
    }
    @objc func digCheckboxTapped(sender: UIButton) {
        print(sender.tag)
        thisPlay.levelRange.dig = sender.tag
        for checkbox in digCheckboxesList {
            checkbox.isSelected = (checkbox == sender)
        }
    }
    @objc func spickCheckboxTapped(sender: UIButton) {
        print(sender.tag)
        thisPlay.levelRange.spike = sender.tag
        for checkbox in spikeCheckboxesList {
            checkbox.isSelected = (checkbox == sender)
        }
    }
    @objc func sumCheckboxTapped(sender: UIButton) {
        print(sender.tag)
        thisPlay.levelRange.sum = sender.tag
        for checkbox in sumCheckboxesList {
            checkbox.isSelected = (checkbox == sender)
        }
    }
    @objc func doneStartDatePicker(_ sender: UIBarItem) {
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        theTextField.text = formatter.string(from: startDatePicker.date)
        thisPlay.startTime = startDatePicker.date
        if theTextField.text == "" {
            endDatePicker.date = startDatePicker.date
        }
        self.contentView.endEditing(true)
    }
    @objc func doneEndDatePicker() {
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        theTextField.text = formatter.string(from: endDatePicker.date)
        thisPlay.endTime = endDatePicker.date
        self.contentView.endEditing(true)
    }
    @objc func donePlace() {
        if theTextField.text?.count ?? 0 > 15 {
            LKProgressHUD.showFailure(text: "字數勿超過 15 字")
        } else {
            self.contentView.endEditing(true)
        }
    }
    @objc func donePrice() {
        let priceInput = Int(theTextField.text ?? "-1") ?? -1
        print(priceInput)
        if priceInput > 100000 || priceInput < 0 {
            LKProgressHUD.showFailure(text: "請輸入合理價格")
        } else {
            self.contentView.endEditing(true)
        }
    }
    @objc func doneMaleLack() {
        let amount = Int(theTextField.text ?? "-1") ?? -1
        print(amount)
        if amount > 99 || amount < 0 {
            LKProgressHUD.showFailure(text: "請輸入合理人數")
        } else {
            self.contentView.endEditing(true)
        }
    }
    @objc func doneFemaleLack() {
        let amount = Int(theTextField.text ?? "-1") ?? -1
        print(amount)
        if amount > 99 || amount < 0 {
            LKProgressHUD.showFailure(text: "請輸入合理人數")
        } else {
            self.contentView.endEditing(true)
        }
    }
    @objc func cancelToolbar() {
        self.contentView.endEditing(true)
    }
}
