//
//  MyFindersViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/17.
//

import UIKit

class MyFindersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "no data yet")
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.isHidden = true
        return imageView
    }()

    private var myFindersTableView: UITableView!

    private let dataManager = DataManager()
    var myFinders = [Play]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        dataManager.getThisUserPlays()
        dataManager.playDataDelegate = self
        setTableView()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.myFinders.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .purple2
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setTableView() {
        myFindersTableView = UITableView()
        myFindersTableView.dataSource = self
        myFindersTableView.delegate = self
        myFindersTableView.register(PlayTableViewCell.self, forCellReuseIdentifier: PlayTableViewCell.identifier)
        myFindersTableView.separatorStyle = .singleLine
        view.addSubview(myFindersTableView)
        view.addSubview(photoImageView)

        myFindersTableView.translatesAutoresizingMaskIntoConstraints = false
        myFindersTableView.rowHeight = UITableView.automaticDimension
        myFindersTableView.estimatedRowHeight = 50
        NSLayoutConstraint.activate([
            myFindersTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            myFindersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myFindersTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            myFindersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            photoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 200),
            photoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myFinders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayTableViewCell.identifier, for: indexPath) as! PlayTableViewCell
        // swiftlint:enable force_cast

        let thisPlay = myFinders[indexPath.row]
        cell.thisPlay = thisPlay
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = MyFinderInfoViewController()
        nextVC.thisPlay = myFinders[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension MyFindersViewController: PlayDataManagerDelegate {
    func manager(_ manager: DataManager, didGet plays: [Play]) {
        for i in plays {
            if i.finderId == UserDefaults.standard.string(forKey: UserTitle.id.rawValue) {
                myFinders.append(i)
            }
        }
        if myFinders.count == 0 {
            photoImageView.isHidden = false
            myFindersTableView.isHidden = true
        } else {
            photoImageView.isHidden = true
            myFindersTableView.reloadData()
        }
    }
}
