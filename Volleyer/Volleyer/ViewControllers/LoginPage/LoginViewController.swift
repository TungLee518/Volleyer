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
        view.addSubview(appleLogInButton)
        setLayout()
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            appleLogInButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            appleLogInButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
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
                        MyDataManager.shared.getProfileData(userId: userIdentifier)
                        UserDefaults.standard.set(userIdentifier, forKey: UserTitle.userIdentifier.rawValue)
                        let viewController = TabBarViewController()
                        viewController.modalPresentationStyle = .fullScreen
                        self.present(viewController, animated: true)
                    } else { // 沒有帳號
                        self.showInputProfileViewController(userIdentifier: userIdentifier, fullName: appleIDCredential.fullName, email: appleIDCredential.email)
                        print("email: \(appleIDCredential.email), name: \(appleIDCredential.fullName), userid: \(userIdentifier)")
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

    private func showInputProfileViewController(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
        let viewController = InputProfileViewController()
        DispatchQueue.main.async {
            viewController.thisUser.loginWay = 0
            viewController.thisUser.userIdentifier = userIdentifier
            if let givenName = fullName?.givenName,
               let familyName = fullName?.familyName {
                viewController.nameTextField.text = familyName + givenName
            }
            if let email = email {
                viewController.emailTextField.text = email
            }
//            self.dismiss(animated: true, completion: nil)
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

