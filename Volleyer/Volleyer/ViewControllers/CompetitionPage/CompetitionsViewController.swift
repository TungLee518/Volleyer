//
//  CompetitionsPageViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/15.
//

import UIKit
import WebKit
import SafariServices

class CompetitionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var competitionsTableView: UITableView!

    private let dataManager = FinderDataManager()
    var allCompetitions = [Competition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        dataManager.getCompetion()
        dataManager.competitionDelegate = self
        setTableView()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        navigationItem.title = NavBarEnum.competitionPage.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setTableView() {
        competitionsTableView = UITableView()
        competitionsTableView.dataSource = self
        competitionsTableView.delegate = self
        competitionsTableView.register(CompetitionTableViewCell.self, forCellReuseIdentifier: CompetitionTableViewCell.identifier)
        competitionsTableView.separatorStyle = .singleLine
        view.addSubview(competitionsTableView)

        competitionsTableView.translatesAutoresizingMaskIntoConstraints = false
        competitionsTableView.rowHeight = UITableView.automaticDimension
        competitionsTableView.estimatedRowHeight = 50
        NSLayoutConstraint.activate([
            competitionsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            competitionsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            competitionsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            competitionsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allCompetitions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: CompetitionTableViewCell.identifier, for: indexPath) as! CompetitionTableViewCell
        // swiftlint:enable force_cast

        let thisCompetition = allCompetitions[indexPath.row]
        cell.titleLable.text = thisCompetition.title
        cell.dateLable.text = thisCompetition.date
        cell.countyLable.text = thisCompetition.county
        if thisCompetition.isEnrolling {
            cell.enrollingLabel.isHidden = false
        } else {
            cell.enrollingLabel.isHidden = true
        }
//        cell.isEnrolling = thisCompetition.isEnrolling
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: allCompetitions[indexPath.row].url) else {
          return
        }
        let nextVC = SFSafariViewController(url: url)
        present(nextVC, animated: true)
//        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension CompetitionsViewController: CompetitionDataManagerDelegate {
    func manager(_ manager: FinderDataManager, didGet competitions: [Competition]) {
        allCompetitions = competitions
        competitionsTableView.reloadData()
    }
}
