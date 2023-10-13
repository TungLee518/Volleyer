//
//  TabBarViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/15.
//

import UIKit

class TabBarViewController: UITabBarController {

    private let tabs: [Tab] = [.finder, .playOne, .competition, .profile]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = .purple4
        viewControllers = tabs.map { $0.makeViewController() }
        RequestDataManager.sharedDataMenager.listenPlayRequests()
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        sceneDelegate.window?.rootViewController = self
    }
}

// MARK: - Tabs
extension TabBarViewController {
    private enum Tab {
        case finder
        case profile
        case competition
        case playOne

        func makeViewController() -> UIViewController {
            let controller: UINavigationController
            switch self {
            case .finder: controller = UINavigationController(rootViewController: FinderViewController())
            case .profile: controller = UINavigationController(rootViewController: MyViewController())
            case .competition: controller = UINavigationController(rootViewController: CompetitionsViewController())
            case .playOne: controller = UINavigationController(rootViewController: UIStoryboard(name: "PlayOne", bundle: nil).instantiateViewController(withIdentifier: "PlayOneViewController"))
            }
            controller.tabBarItem = makeTabBarItem()
            controller.tabBarItem.imageInsets = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 10.0, right: 0.0)
            return controller
        }

        private func makeTabBarItem() -> UITabBarItem {
            return UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        }

        private var title: String {
            switch self {
            case .finder:
                return TabBarEnum.finderPage.rawValue
            case .profile:
                return TabBarEnum.myPage.rawValue
            case .competition:
                return TabBarEnum.competitionPage.rawValue
            case .playOne:
                return TabBarEnum.playOnePage.rawValue
            }
        }

        private var image: UIImage? {
            switch self {
            case .finder:
                return .asset(.ball)
            case .profile:
                return .asset(.profile)
            case .competition:
                return .asset(.score)
            case .playOne:
                return .asset(.spike)
            }
        }

        private var selectedImage: UIImage? {
            switch self {
            case .finder:
                return .asset(.ball_selected)
            case .profile:
                return .asset(.profile_selected)
            case .competition:
                return .asset(.score_selected)
            case .playOne:
                return .asset(.spike_selected)
            }
        }
    }
}
