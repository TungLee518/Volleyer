//
//  JGProgressHUDWrapper.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/1.
//

import JGProgressHUD

enum HUDType {
    case success(String)
    case failure(String)
}

class LKProgressHUD {

    static let shared = LKProgressHUD()

    private init() {}

    let hud = JGProgressHUD(style: .dark)

    var view: UIView? {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return nil
        }

        return sceneDelegate.window?.rootViewController?.view
    }

    static func show(type: HUDType) {
        switch type {
        case .success(let text):
            showSuccess(text: text)
        case .failure(let text):
            showFailure(text: text)
        }
    }

    static func showSuccess(text: String = "success") {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                showSuccess(text: text)
            }
            return
        }
        guard let theView = shared.view else {
            return
        }
        shared.hud.textLabel.text = text
        shared.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        shared.hud.show(in: theView)
        shared.hud.dismiss(afterDelay: 1.5)
    }

    static func showFailure(text: String = "Failure") {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                showFailure(text: text)
            }
            return
        }
        guard let theView = shared.view else {
            return
        }
        shared.hud.textLabel.text = text
        shared.hud.indicatorView = JGProgressHUDErrorIndicatorView()
        shared.hud.show(in: theView)
        shared.hud.dismiss(afterDelay: 1.5)
    }

    static func show() {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                show()
            }
            return
        }
        guard let theView = shared.view else {
            return
        }
        shared.hud.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        shared.hud.textLabel.text = "Loading"
        shared.hud.show(in: theView)
    }

    static func dismiss() {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                dismiss()
            }
            return
        }
        shared.hud.dismiss()
    }
}
