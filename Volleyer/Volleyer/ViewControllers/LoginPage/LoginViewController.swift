//
//  LoginViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/3.
//

import UIKit
import AuthenticationServices
import FirebaseFirestore

class LoginViewController: UIViewController {
    private let welcomeLable: UILabel = {
        let label = UILabel()
        label.text = "歡迎來到排球人"
        label.textColor = .gray2
        label.font = .semiboldNunito(size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var appleLogInButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(handleLogInWithAppleID), for: .touchUpInside)
        button.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(welcomeLable)
        view.addSubview(appleLogInButton)
        setLayout()
    }

    func setLayout() {
        NSLayoutConstraint.activate([
            welcomeLable.bottomAnchor.constraint(equalTo: appleLogInButton.topAnchor, constant: -standardMargin*3),
            welcomeLable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            appleLogInButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            appleLogInButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            appleLogInButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            appleLogInButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            appleLogInButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin)
        ])
    }

    @objc func handleLogInWithAppleID() {
         let request = ASAuthorizationAppleIDProvider().createRequest()
         request.requestedScopes = [.fullName, .email]
         let controller = ASAuthorizationController(authorizationRequests: [request])
         controller.delegate = self
         controller.presentationContextProvider = self
         controller.performRequests()
     }

    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]

        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
//            UserDefaults.standard.set(userIdentifier, forKey: "userIdentifier1")
            Firestore.firestore().collection("users").whereField(UserTitle.userIdentifier.rawValue, isEqualTo: userIdentifier).getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    if querySnapshot!.documents.count > 0 { // 已有帳號
                        MyDataManager.shared.getProfileData(appleUserId: userIdentifier) { gotUser, err in
                            if let error = err {
                                // Handle the error
                                print("Error: \(error)")
                            } else if let gotUser = gotUser {
                                // Use the gotUser
                                if gotUser.status == -1 { // 以前刪過帳號
                                    self.showInputProfileViewController(userIdentifier: userIdentifier, fullName: appleIDCredential.fullName, email: appleIDCredential.email, wasVolleyer: gotUser)
                                } else { // 只是要重新登入
                                    UserDefaults.standard.set(userIdentifier, forKey: UserTitle.userIdentifier.rawValue)
                                    let viewController = TabBarViewController()
                                    viewController.modalPresentationStyle = .fullScreen
                                    self.present(viewController, animated: true)
                                }
                            } else {
                                // Handle the case where no matching document was found
                                print("No matching document found")
                            }
                        }
                    } else { // 沒有帳號
                        self.showInputProfileViewController(userIdentifier: userIdentifier, fullName: appleIDCredential.fullName, email: appleIDCredential.email, wasVolleyer: nil)
                    }
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
            }
        default:
            break
        }
    }

    private func saveUserInKeychain(_ userIdentifier: String) {
        print("save user in keychain")
    }

    private func showInputProfileViewController(userIdentifier: String, fullName: PersonNameComponents?, email: String?, wasVolleyer: User?) {
        let viewController = InputProfileViewController()
        DispatchQueue.main.async {
            if let wasVolleyer = wasVolleyer {
                viewController.thisUser.firebaseId = wasVolleyer.firebaseId
            }
            viewController.thisUser.loginWay = 1
            viewController.thisUser.userIdentifier = userIdentifier
            if let givenName = fullName?.givenName,
               let familyName = fullName?.familyName {
                viewController.nameTextField.text = familyName + givenName
            }
            if let email = email {
                viewController.emailTextField.text = email
            }
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }
    }

    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    /// - Tag: did_complete_error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

