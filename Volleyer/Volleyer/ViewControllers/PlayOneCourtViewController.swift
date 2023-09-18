//
//  PlayOneCourtViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/18.
//

import UIKit

class PlayOneCourtViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
