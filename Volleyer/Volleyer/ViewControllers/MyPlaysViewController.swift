//
//  MyPlaysViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/17.
//

import UIKit

class MyPlaysViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var myPlaysTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setTableView()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.myPlays.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setTableView() {
        myPlaysTableView = UITableView()
        myPlaysTableView.dataSource = self
        myPlaysTableView.delegate = self
        myPlaysTableView.register(PlayTableViewCell.self, forCellReuseIdentifier: PlayTableViewCell.identifier)
        myPlaysTableView.separatorStyle = .singleLine
        view.addSubview(myPlaysTableView)

        myPlaysTableView.translatesAutoresizingMaskIntoConstraints = false
        myPlaysTableView.rowHeight = UITableView.automaticDimension
        myPlaysTableView.estimatedRowHeight = 50
        NSLayoutConstraint.activate([
            myPlaysTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            myPlaysTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myPlaysTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            myPlaysTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayTableViewCell.identifier, for: indexPath) as! PlayTableViewCell
        // swiftlint:enable force_cast

        return cell
    }
}