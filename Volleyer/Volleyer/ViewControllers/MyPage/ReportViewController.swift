//
//  ReportViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/7.
//

import UIKit

class ReportViewController: UIViewController {

    private let idLabel: UILabel = {
        let label = UILabel()
        label.text = "標題"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.regularTextField(placeHolder: "Title")
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(cancelToolbar))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        return textField
    }()
    private let reasonLabel: UILabel = {
        let label = UILabel()
        label.text = "原因"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var reasonTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .regularNunito(size: 16)
        textView.textColor = .gray4
        textView.textAlignment = .left
        textView.autocapitalizationType = .none
        textView.layer.borderColor = UIColor.gray3.cgColor
        textView.layer.borderWidth = 0.3
        textView.layer.cornerRadius = 5
        textView.text = "請輸入詳細原因"
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(cancelToolbar))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        textView.inputAccessoryView = toolbar
        return textView
    }()
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("送出檢舉", for: .normal)
        button.whiteButton()
        button.addTarget(self, action: #selector(submitReport), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setContent()
        reasonTextView.delegate = self
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.report.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .purple2
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setContent() {
        view.addSubview(idLabel)
        view.addSubview(idTextField)
        view.addSubview(reasonLabel)
        view.addSubview(reasonTextView)
        view.addSubview(submitButton)
        NSLayoutConstraint.activate([
            reasonTextView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -standardMargin*2),
            reasonTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            reasonTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            reasonTextView.heightAnchor.constraint(equalToConstant: 100),
            reasonLabel.bottomAnchor.constraint(equalTo: reasonTextView.topAnchor, constant: -standardMargin/2),
            reasonLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            idTextField.bottomAnchor.constraint(equalTo: reasonLabel.topAnchor, constant: -standardMargin),
            idTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            idTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            idTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            idLabel.bottomAnchor.constraint(equalTo: idTextField.topAnchor, constant: -standardMargin/2),
            idLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),
            submitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            submitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            submitButton.heightAnchor.constraint(equalToConstant: standardButtonHeight)
        ])
    }

    @objc func cancelToolbar() {
        self.view.endEditing(true)
    }

    @objc func submitReport() {
        if let title = idTextField.text, let content = reasonTextView.text {
            let thisReport = Report(createTime: Date(), reportUserId: UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "user default error", title: title, content: content)
            MyDataManager.shared.saveReport(thisReport) { isSaved in
                if isSaved {
                    LKProgressHUD.showSuccess(text: "檢舉成功")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    LKProgressHUD.showSuccess(text: "請再試一次")
                }
            }
        }
    }
}

extension ReportViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray4 {
            textView.text = nil
            textView.textColor = .gray1
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "請輸入詳細原因"
            textView.textColor = .gray4
        }
    }
}
