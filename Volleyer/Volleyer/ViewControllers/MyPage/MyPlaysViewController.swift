//
//  MyPlaysViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/17.
//

import UIKit

class MyPlaysViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var myPlaysTableView: UITableView!

    private let dataManager = DataManager()
    var myPlays = [Play]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        dataManager.getThisUserPlays()
        dataManager.playDataDelegate = self
        setTableView()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.myPlays.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor.black
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
        myPlays.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayTableViewCell.identifier, for: indexPath) as! PlayTableViewCell
        // swiftlint:enable force_cast

        let thisPlay = myPlays[indexPath.row]
        cell.thisPlay = thisPlay
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = MyPlayInfoViewController()
        nextVC.thisPlay = myPlays[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension MyPlaysViewController: PlayDataManagerDelegate {
    func manager(_ manager: DataManager, didGet plays: [Play]) {
        myPlays = plays
        myPlaysTableView.reloadData()
    }
}
