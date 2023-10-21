//
//  MyPlaysViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/17.
//

import UIKit
import MJRefresh

class MyPlaysViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    lazy var photoImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "blow")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    private let noDataLabel: UILabel = {
        let label = UILabel()
        label.text = "目前沒有要打的場"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var myPlaysTableView: UITableView!

    private let dataManager = FinderDataManager()
    var myPlays = [Play]()

    override func viewDidLoad() {
        super.viewDidLoad()
        LKProgressHUD.show()
        photoImageView.isHidden = true
        noDataLabel.isHidden = true
        setNavBar()
        dataManager.getThisUserPlays()
        dataManager.playDataDelegate = self
        setTableView()
        setImageView()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.myPlays.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .purple2
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
        myPlaysTableView.allowsSelection = false
        MJRefreshNormalHeader {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }
                dataManager.getThisUserPlays()
                self.myPlaysTableView.mj_header?.endRefreshing()
            }
        }.autoChangeTransparency(true).link(to: self.myPlaysTableView)
    }

    func setImageView() {
        view.addSubview(photoImageView)
        view.addSubview(noDataLabel)
        NSLayoutConstraint.activate([
            photoImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            photoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 150),
            photoImageView.heightAnchor.constraint(equalToConstant: 150),
            noDataLabel.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            noDataLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: standardMargin)
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
}

extension MyPlaysViewController: PlayDataManagerDelegate {
    func manager(_ manager: FinderDataManager, didGet plays: [Play]) {
        myPlays = plays
        LKProgressHUD.dismiss()
        if myPlays.count == 0 {
            photoImageView.isHidden = false
            noDataLabel.isHidden = false
            myPlaysTableView.isHidden = true
        } else {
            photoImageView.isHidden = true
            noDataLabel.isHidden = true
            myPlaysTableView.isHidden = false
            myPlaysTableView.reloadData()
        }
    }
}
