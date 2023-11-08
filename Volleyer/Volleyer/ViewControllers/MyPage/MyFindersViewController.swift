//
//  MyFindersViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/17.
//

import UIKit
import MJRefresh

class MyFindersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "blow")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let noDataLabel: UILabel = {
        let label = UILabel()
        label.text = "目前沒有揪場"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var myFindersTableView: UITableView!

    private let dataManager = FinderDataManager()
    var myFinders = [Play]()

    override func viewDidLoad() {
        super.viewDidLoad()
        LKProgressHUD.show()
        photoImageView.isHidden = true
        noDataLabel.isHidden = true
        setNavBar()
        dataManager.playDataDelegate = self
        setTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataManager.getThisUserPlays()
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
        view.addSubview(noDataLabel)

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
            photoImageView.widthAnchor.constraint(equalToConstant: 150),
            photoImageView.heightAnchor.constraint(equalToConstant: 150),
            noDataLabel.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            noDataLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: standardMargin)
        ])
        MJRefreshNormalHeader {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }
                dataManager.getThisUserPlays()
                self.myFindersTableView.mj_header?.endRefreshing()
            }
        }.autoChangeTransparency(true).link(to: self.myFindersTableView)
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
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = MyFinderInfoViewController()
        nextVC.thisPlay = myFinders[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension MyFindersViewController: PlayDataManagerDelegate {
    func manager(_ manager: FinderDataManager, didGet plays: [Play]) {
        LKProgressHUD.dismiss()
        myFinders = []
        for i in plays where i.finderId == UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) {
            myFinders.append(i)
        }
        myFinders.sort { $0.startTime < $1.startTime }
        if myFinders.count == 0 {
            photoImageView.isHidden = false
            noDataLabel.isHidden = false
            myFindersTableView.isHidden = true
        } else {
            photoImageView.isHidden = true
            noDataLabel.isHidden = true
            myFindersTableView.isHidden = false
            myFindersTableView.reloadData()
        }
    }
}
