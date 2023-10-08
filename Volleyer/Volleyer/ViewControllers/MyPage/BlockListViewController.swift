//
//  BlackListViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/7.
//

import UIKit

class BlockListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private lazy var photoImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "red")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    private let noDataLabel: UILabel = {
        let label = UILabel()
        label.text = "目前沒有封鎖名單"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var blockListTableView: UITableView!
    private let dataManager = RequestDataManager()
    var blockUsers = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        dataManager.getPlayRequests()
        dataManager.playRequestDelegate = self
        setTableView()
        setImageView()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.myRequestsSent.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .purple2
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setTableView() {
        blockListTableView = UITableView()
        blockListTableView.dataSource = self
        blockListTableView.delegate = self
        blockListTableView.register(RequestsTableViewCell.self, forCellReuseIdentifier: RequestsTableViewCell.identifier)
        blockListTableView.separatorStyle = .singleLine
        view.addSubview(blockListTableView)

        blockListTableView.translatesAutoresizingMaskIntoConstraints = false
        blockListTableView.rowHeight = UITableView.automaticDimension
        blockListTableView.estimatedRowHeight = 50
        NSLayoutConstraint.activate([
            blockListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            blockListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            blockListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            blockListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
        blockUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: RequestsTableViewCell.identifier, for: indexPath) as! RequestsTableViewCell
        // swiftlint:enable force_cast

        cell.selectionStyle = .none
        return cell
    }
}

extension BlockListViewController: RequestsDataManagerDelegate {
    func manager(_ manager: RequestDataManager, iReceive playRequests: [PlayRequest]) {

    }
    func manager(_ manager: RequestDataManager, iSent playRequests: [PlayRequest]) {
//        blockUsers = playRequests
//        requestsTableView.reloadData()
        if blockUsers.count == 0 {
            photoImageView.isHidden = false
            noDataLabel.isHidden = false
            blockListTableView.isHidden = true
        } else {
            photoImageView.isHidden = true
            noDataLabel.isHidden = true
            blockListTableView.isHidden = false
            blockListTableView.reloadData()
        }
    }
}
