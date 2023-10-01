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
    var finderTableView: UITableView!

    private let dataManager = DataManager()
    var publicPlays = [Play]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        dataManager.playDataDelegate = self
        setTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        dataManager.getPublishPlay()
    }

    func setNavBar() {
        self.view.backgroundColor = UIColor.white
        navigationItem.title = NavBarEnum.finderPage.rawValue
//        let navigationBarAppearance = UINavigationBarAppearance()
//        navigationBarAppearance.configureWithOpaqueBackground()
//        navigationBarAppearance.backgroundColor = .systemBlue
//        navigationBarAppearance.titleTextAttributes = [
//            .foregroundColor: UIColor.white,
//            .font: UIFont.boldSystemFont(ofSize: 20)
//         ]
//        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
//        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushToEstablishVC))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }

    @objc func pushToEstablishVC() {
        let nextVC = EstablishFinderViewController()
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
    }

    func setTableView() {
        finderTableView = UITableView()
        finderTableView.dataSource = self
        finderTableView.delegate = self
        finderTableView.register(FinderTableViewCell.self, forCellReuseIdentifier: FinderTableViewCell.identifier)
        finderTableView.separatorStyle = .singleLine
        finderTableView.allowsSelection = false
        view.addSubview(finderTableView)

        finderTableView.translatesAutoresizingMaskIntoConstraints = false
        finderTableView.rowHeight = UITableView.automaticDimension
        finderTableView.estimatedRowHeight = 50
        NSLayoutConstraint.activate([
            finderTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            finderTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            finderTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            finderTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        publicPlays.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: FinderTableViewCell.identifier, for: indexPath) as! FinderTableViewCell
        // swiftlint:enable force_cast
        let thisPlay = publicPlays[indexPath.row]
        cell.thisPlay = thisPlay
        cell.parent = self
        return cell
    }
}

// not determine public or not yet
extension FinderViewController: PlayDataManagerDelegate {
    func manager(_ manager: DataManager, didGet plays: [Play]) {
        publicPlays = plays
        finderTableView.reloadData()
    }
}
