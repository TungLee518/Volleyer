//
//  MyFindersViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/17.
//

import UIKit

class MyFindersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    private var myFindersTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setTableView()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.myFinders.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setTableView() {
        myFindersTableView = UITableView()
        myFindersTableView.dataSource = self
        myFindersTableView.delegate = self
        myFindersTableView.register(PlayTableViewCell.self, forCellReuseIdentifier: PlayTableViewCell.identifier)
        myFindersTableView.separatorStyle = .singleLine
        view.addSubview(myFindersTableView)

        myFindersTableView.translatesAutoresizingMaskIntoConstraints = false
        myFindersTableView.rowHeight = UITableView.automaticDimension
        myFindersTableView.estimatedRowHeight = 50
        NSLayoutConstraint.activate([
            myFindersTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            myFindersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myFindersTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            myFindersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
