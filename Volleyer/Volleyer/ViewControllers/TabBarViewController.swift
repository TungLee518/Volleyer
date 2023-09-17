//
//  TabBarViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/15.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let findPlayerVC = FindPlayerViewController()
        let findPlayerNC = UINavigationController(rootViewController: findPlayerVC)
        // findPlayerNC.tabBarItem.image = UIImage(named: "placeholder")
        findPlayerNC.tabBarItem.title = TabBarEnum.finderPage.rawValue

        let myPageVC = MyPageViewController()
        let myPageNC = UINavigationController(rootViewController: myPageVC)
        // myPageNC.tabBarItem.image = UIImage(named: "placeholder")
        myPageNC.tabBarItem.title = TabBarEnum.myPage.rawValue

        let communityVC = CommunityViewController()
        let communityNC = UINavigationController(rootViewController: communityVC)
        // communityNC.tabBarItem.image = UIImage(named: "placeholder")
        communityNC.tabBarItem.title = TabBarEnum.communityPage.rawValue

        let competitionVC = CompetitionsPageViewController()
        let competitionNC = UINavigationController(rootViewController: competitionVC)
        // competitionNC.tabBarItem.image = UIImage(named: "placeholder")
        competitionNC.tabBarItem.title = TabBarEnum.competitionPage.rawValue

        let playOneVC = PlayOneViewController()
        let playOneNC = UINavigationController(rootViewController: playOneVC)
        // playOneNC.tabBarItem.image = UIImage(named: "placeholder")
        playOneNC.tabBarItem.title = TabBarEnum.playOnePage.rawValue

        viewControllers = [communityNC, findPlayerNC, myPageNC, competitionNC, playOneNC]

        self.selectedIndex = 1
    }
}
