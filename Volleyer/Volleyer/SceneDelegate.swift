//
//  SceneDelegate.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/13.
//

import UIKit
import Lottie

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    static let shared = SceneDelegate()

    var window: UIWindow?
    private var launchScreen: LottieAnimationView?
    private var waitingScreen: LottieAnimationView?
    let dispatchSemaphore = DispatchSemaphore(value: 0)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // let viewController = FindPlayerViewController()
        // let navigationController = UINavigationController(rootViewController: viewController)
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        // for simulator
        MyDataManager.shared.getSimulatorProfileData()
        window?.rootViewController = TabBarViewController()
        // for user
//        setAnimate()

        window?.makeKeyAndVisible()
        UserDefaults.standard.set(Date(), forKey: launchAppDate)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func setAnimate() {
        launchScreen = .init(name: "volleyHit")
        launchScreen?.frame = window?.bounds ?? CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        launchScreen?.backgroundColor = .gray7
        launchScreen?.contentMode = .scaleAspectFit
        launchScreen?.isHidden = true
        window?.addSubview(launchScreen!)

        waitingScreen = .init(name: "loading")
        waitingScreen?.frame = window?.bounds ?? CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        waitingScreen?.backgroundColor = .gray7
        waitingScreen?.contentMode = .scaleAspectFit
        waitingScreen?.isHidden = true
        window?.addSubview(waitingScreen!)

        UIView.transition(with: launchScreen!, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            self.waitingScreen?.isHidden = false
            self.waitingScreen?.loopMode = .loop
            self.waitingScreen?.animationSpeed = 1.0
            self.waitingScreen?.play()
        })
        // 判斷是否已登入
        if let thisUserAppleId = UserDefaults.standard.string(forKey: UserTitle.userIdentifier.rawValue) {
            MyDataManager.shared.getProfileData(appleUserId: thisUserAppleId) { gotUser, err in
                if let error = err {
                    // Handle the error
                    print("Error: \(error)")
                } else if let gotUser = gotUser {
                    // Use the gotUser
                    sleep(1)
                    self.window?.rootViewController = TabBarViewController()
                    UIView.transition(with: self.launchScreen!, duration: 0.4,
                                      options: .transitionCrossDissolve,
                                      animations: {
                        self.waitingScreen?.stop()
//                        self.launchScreen?.isHidden = true
                        self.waitingScreen?.isHidden = true
                    })
                } else {
                    // Handle the case where no matching document was found
                    print("No matching document found")
                }
            }
        } else {
            sleep(1)
            self.window?.rootViewController = LoginViewController()
            UIView.transition(with: self.launchScreen!, duration: 0.4,
                              options: .transitionCrossDissolve,
                              animations: {
                self.waitingScreen?.stop()
//                self.launchScreen?.isHidden = true
                self.waitingScreen?.isHidden = true
            })
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
//            // Put your code which should be executed with a delay here
//            UIView.transition(with: self.launchScreen!, duration: 0.4,
//                              options: .transitionCrossDissolve,
//                              animations: {
//                self.launchScreen?.isHidden = true
//            })
//        }
    }
}
