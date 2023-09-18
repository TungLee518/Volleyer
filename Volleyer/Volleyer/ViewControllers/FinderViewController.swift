//
//  ViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/13.
//

import UIKit
import FirebaseFirestore

class FinderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var db: Firestore!
    var findPlayerTableView: UITableView!

    private let dataManager = DataManager()
    var publicPlays = [Play]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        dataManager.delegate = self
        setTableView()
        dataManager.getPlay()
    }

    func setNavBar() {
        self.view.backgroundColor = UIColor.white
        navigationItem.title = NavBarEnum.finderPage.rawValue
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .systemBlue
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 20)
         ]
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushToEstablishVC))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }

    @objc func pushToEstablishVC() {
        let nextVC = EstablishFinderViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

    func setTableView() {
        findPlayerTableView = UITableView()
        findPlayerTableView.dataSource = self
        findPlayerTableView.delegate = self
        findPlayerTableView.register(PlayInfoTableViewCell.self, forCellReuseIdentifier: PlayInfoTableViewCell.identifier)
        findPlayerTableView.separatorStyle = .singleLine
        view.addSubview(findPlayerTableView)

        findPlayerTableView.translatesAutoresizingMaskIntoConstraints = false
        findPlayerTableView.rowHeight = UITableView.automaticDimension
        findPlayerTableView.estimatedRowHeight = 50
        NSLayoutConstraint.activate([
            findPlayerTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            findPlayerTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            findPlayerTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            findPlayerTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        publicPlays.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayInfoTableViewCell.identifier, for: indexPath) as! PlayInfoTableViewCell
        // swiftlint:enable force_cast
        let thisPlay = publicPlays[indexPath.row]
        cell.thisPlay = thisPlay
        return cell
    }
}

// not determine public or not yet
extension FinderViewController: PlayDataManagerDelegate {
    func manager(_ manager: DataManager, didGet plays: [Play]) {
        publicPlays = plays
        findPlayerTableView.reloadData()
    }
}
