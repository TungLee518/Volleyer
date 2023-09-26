//
//  TabBarViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/15.
//

import UIKit

class TabBarViewController: UITabBarController {

    private let tabs: [Tab] = [.finder, .profile, .competition, .playOne]

    private var trolleyTabBarItem: UITabBarItem?

    private var orderObserver: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = UIColor.purple
        viewControllers = tabs.map { $0.makeViewController() }

        delegate = self
    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let findPlayerVC = FinderViewController()
//        let findPlayerNC = UINavigationController(rootViewController: findPlayerVC)
//        findPlayerNC.tabBarItem.title = TabBarEnum.finderPage.rawValue
//        findPlayerNC.tabBarItem.image = UIImage(named: TabBarImageEnum.plus.rawValue)
//        findPlayerNC.tabBarItem.imageInsets = UIEdgeInsets(top: 6.0, left: 0.0, bottom: -6.0, right: 0.0)
//
//        let myPageVC = MyViewController()
//        let myPageNC = UINavigationController(rootViewController: myPageVC)
//        // myPageNC.tabBarItem.image = UIImage(named: "placeholder")
//        myPageNC.tabBarItem.title = TabBarEnum.myPage.rawValue
//
//        let communityVC = CommunityViewController()
//        let communityNC = UINavigationController(rootViewController: communityVC)
//        // communityNC.tabBarItem.image = UIImage(named: "placeholder")
//        communityNC.tabBarItem.title = TabBarEnum.communityPage.rawValue
//
//        let competitionVC = CompetitionsViewController()
//        let competitionNC = UINavigationController(rootViewController: competitionVC)
//        // competitionNC.tabBarItem.image = UIImage(named: "placeholder")
//        competitionNC.tabBarItem.title = TabBarEnum.competitionPage.rawValue
//
//        let storyboard = UIStoryboard(name: "PlayOne", bundle: nil)
//        let playOneVC = storyboard.instantiateViewController(withIdentifier: "PlayOneViewController")
//        let playOneNC = UINavigationController(rootViewController: playOneVC)
//        // playOneNC.tabBarItem.image = UIImage(named: "placeholder")
//        playOneNC.tabBarItem.title = TabBarEnum.playOnePage.rawValue
//
//        viewControllers = [findPlayerNC, myPageNC, competitionNC, playOneNC]
//
//        self.selectedIndex = 0
//    }
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
            controller.tabBarItem.imageInsets = UIEdgeInsets(top: 15.0, left: 0.0, bottom: -15.0, right: 0.0)
            return controller
        }

        private func makeTabBarItem() -> UITabBarItem {
            return UITabBarItem(title: nil, image: image, selectedImage: selectedImage)
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

// MARK: - UITabBarControllerDelegate
extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController
    ) -> Bool {
        guard
            let navVC = viewController as? UINavigationController,
            navVC.viewControllers.first is FinderViewController
//                || navVC.viewControllers.first is AuctionViewController
        else {
            return true
        }
        return true
    }
}
