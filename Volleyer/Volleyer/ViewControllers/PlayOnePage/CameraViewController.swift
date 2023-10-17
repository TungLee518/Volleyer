//
//  CameraViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/19.
//

import UIKit
import AVFoundation
import FirebaseStorage
import JGProgressHUD

class CameraViewController: UIViewController {

    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "留下隊友的資訊"
        label.font = .semiboldNunito(size: 20)
        label.textColor = .gray2
        label.textAlignment = .center
        return label
    }()
    var photoPreviewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "placeholder")
        return imageView
    }()

    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .regularNunito(size: 16)
        textField.textColor = .gray2
        textField.placeholder = " 姓名"
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

    lazy var takePhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("拍照", for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.purple1.cgColor
        button.addTarget(self, action: #selector(didTapOnTakePhotoButton), for: .touchUpInside)
        return button
    }()

    private let storage = Storage.storage().reference()

    var finderInfo: User?
    var playerN: String?
    var imageTook: Data?
    let dataManager = PlayOneDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headerLabel)
        view.addSubview(photoPreviewImageView)
        view.addSubview(nameTextField)
        view.addSubview(takePhotoButton)
        setLayout()
        setNavBar()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = ""
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .purple2
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            photoPreviewImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            photoPreviewImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            photoPreviewImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            photoPreviewImageView.heightAnchor.constraint(equalTo: photoPreviewImageView.widthAnchor, multiplier: 1),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            nameTextField.bottomAnchor.constraint(equalTo: photoPreviewImageView.topAnchor, constant: -standardMargin),
            nameTextField.heightAnchor.constraint(equalToConstant: standardTextFieldHeight),
            headerLabel.centerXAnchor.constraint(equalTo: nameTextField.centerXAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            headerLabel.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -standardMargin*2),
            takePhotoButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            takePhotoButton.topAnchor.constraint(equalTo: photoPreviewImageView.bottomAnchor, constant: standardMargin),
            takePhotoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            takePhotoButton.heightAnchor.constraint(equalToConstant: standardButtonHeight)
        ])
    }

    @objc func didTapOnTakePhotoButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else {
            return
        }
        imageTook = imageData
//        if let finderInfo = finderInfo, let playerN = playerN, nameTextField.text != "" {
//            dataManager.savePlayOneImage(finder: finderInfo, playerN: playerN, imageData: imageData, playerName: nameTextField.text!)
//        }

        photoPreviewImageView.image = image
        takePhotoButton.setTitle("完成拍照", for: .normal)
        takePhotoButton.removeTarget(nil, action: nil, for: .allEvents)
        takePhotoButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
    }
    @objc func dismissSelf() {
        if let finderInfo = finderInfo, let playerN = playerN, let imageTook = imageTook, nameTextField.text != "" {
            let hud = JGProgressHUD()
            hud.textLabel.text = "上傳中"
            hud.show(in: self.view)
            dataManager.savePlayOneImage(finder: finderInfo, playerN: playerN, imageData: imageTook, playerName: nameTextField.text ?? "name error") { err in
                if err == nil {
                    print("推回去")
                    hud.dismiss()
                    self.navigationController?.popViewController(animated: true)
                } else {
                    hud.dismiss()
                    LKProgressHUD.showFailure(text: "上傳失敗:(")
                }
            }
        } else {
            LKProgressHUD.showFailure(text: "請輸入姓名")
        }
    }
    @objc func cancelToolbar() {
        self.view.endEditing(true)
    }
}
