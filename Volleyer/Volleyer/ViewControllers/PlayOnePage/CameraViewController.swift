//
//  CameraViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/19.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    var photoPreviewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "placeholder")
        return imageView
    }()

    lazy var takePhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("take photo", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .purple1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.gray7, for: .normal)
        button.addTarget(self, action: #selector(didTapOnTakePhotoButton), for: .touchUpInside)
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(photoPreviewImageView)
        view.addSubview(takePhotoButton)
        setLayout()
        setNavBar()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            photoPreviewImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photoPreviewImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoPreviewImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photoPreviewImageView.bottomAnchor.constraint(equalTo: takePhotoButton.topAnchor, constant: -standardMargin),
            takePhotoButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            takePhotoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),
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
        photoPreviewImageView.image = image
        takePhotoButton.setTitle("完成拍照", for: .normal)
        takePhotoButton.removeTarget(nil, action: nil, for: .allEvents)
        takePhotoButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
    }
    @objc func dismissSelf() {
        self.dismiss(animated: true)
    }
}
