//
//  PlayOneViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/15.
//

import UIKit

class PlayOneViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var allCourtTableView: UITableView!
//    private let dataManager = DataManager()
//    var allCompetitions = [Competition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
//        dataManager.getCompetion()
//        dataManager.competitionDelegate = self
        setTableView()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.playOnePage.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setTableView() {
        allCourtTableView = UITableView()
        allCourtTableView.dataSource = self
        allCourtTableView.delegate = self
        allCourtTableView.register(PlayOneCourtTableViewCell.self, forCellReuseIdentifier: PlayOneCourtTableViewCell.identifier)
        allCourtTableView.separatorStyle = .singleLine
        view.addSubview(allCourtTableView)

        allCourtTableView.translatesAutoresizingMaskIntoConstraints = false
        allCourtTableView.rowHeight = UITableView.automaticDimension
        allCourtTableView.estimatedRowHeight = 50
        NSLayoutConstraint.activate([
            allCourtTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            allCourtTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            allCourtTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            allCourtTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayOneCourtTableViewCell.identifier, for: indexPath) as! PlayOneCourtTableViewCell
        // swiftlint:enable force_cast

//        let thisCompetition = allCompetitions[indexPath.row]

        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = PlayOneCourtViewController()
        nextVC.title = "場五"
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
