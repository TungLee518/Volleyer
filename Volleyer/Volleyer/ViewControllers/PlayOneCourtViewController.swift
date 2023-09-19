//
//  PlayOneCourtViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/18.
//

import UIKit

class PlayOneCourtViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var allCourtTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setTableView()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setTableView() {
        allCourtTableView = UITableView()
        allCourtTableView.dataSource = self
        allCourtTableView.delegate = self
        allCourtTableView.register(PlayOneFinderTableViewCell.self, forCellReuseIdentifier: PlayOneFinderTableViewCell.identifier)
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
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayOneFinderTableViewCell.identifier, for: indexPath) as! PlayOneFinderTableViewCell
        // swiftlint:enable force_cast
        cell.parent = self
        cell.selectionStyle = .none
        return cell
    }
}
