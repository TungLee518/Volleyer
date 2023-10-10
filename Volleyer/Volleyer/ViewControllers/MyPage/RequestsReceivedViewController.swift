//
//  RequestsViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/21.
//

import UIKit
import MJRefresh

class RequestsReceivedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    lazy var photoImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "blow")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    private let noDataLabel: UILabel = {
        let label = UILabel()
        label.text = "目前沒有收到邀請"
        label.textColor = UIColor.gray2
        label.font = .semiboldNunito(size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var requestsTableView: UITableView!

    private let dataManager = RequestDataManager()
    var myRequests = [PlayRequest]()

    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.isHidden = true
        noDataLabel.isHidden = true
        setNavBar()
        dataManager.getPlayRequests()
        dataManager.playRequestDelegate = self
        setTableView()
        setImageView()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.myRequests.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .purple2
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setTableView() {
        requestsTableView = UITableView()
        requestsTableView.dataSource = self
        requestsTableView.delegate = self
        requestsTableView.register(RequestsTableViewCell.self, forCellReuseIdentifier: RequestsTableViewCell.identifier)
        requestsTableView.separatorStyle = .singleLine
        view.addSubview(requestsTableView)

        requestsTableView.translatesAutoresizingMaskIntoConstraints = false
        requestsTableView.rowHeight = UITableView.automaticDimension
        requestsTableView.estimatedRowHeight = 50
        NSLayoutConstraint.activate([
            requestsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            requestsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            requestsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            requestsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        MJRefreshNormalHeader {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }
                dataManager.getPlayRequests()
                self.requestsTableView.mj_header?.endRefreshing()
            }
        }.autoChangeTransparency(true).link(to: self.requestsTableView)
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
        myRequests.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: RequestsTableViewCell.identifier, for: indexPath) as! RequestsTableViewCell
        // swiftlint:enable force_cast

        let thisRequest = myRequests[indexPath.row]
        cell.titleLable.text = thisRequest.requestSenderId + " " + RequestEnum.sentARequestToYou.rawValue

        let players = thisRequest.requestPlayerList
        var playerListText = "名單："
        for player in players {
            playerListText += "\(player.name) "
        }
        cell.playersLable.text = playerListText
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd HH:mm"
        cell.dateLable.text = RequestEnum.sentAt.rawValue + " " + dateFormatter.string(from: thisRequest.createTime)
        if thisRequest.status == 99 { // accept
            cell.showOnly(status: requestStatus[1])
        } else if thisRequest.status == 0 { // pending
            print(thisRequest)
            cell.acceptRequestButton.isHidden = false
            cell.denyRequestButton.isHidden = false
            cell.statusLable.isHidden = true
        } else if thisRequest.status == -1 { // cancel
            cell.showOnly(status: requestStatus[3])
        } else { // deny
            cell.showOnly(status: requestStatus[2])
        }
        cell.updateStatus = { [weak self] status in
            guard let self = self else { return }
            dataManager.updateRequest(thisRequest, status: status)
        }
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = InfoViewController()
        // firebase get data by play id and request_sender_id
        nextVC.thisPlayId = myRequests[indexPath.row].playId
        nextVC.thisUserId = myRequests[indexPath.row].requestSenderId
        nextVC.title = "寄送者與場地資訊"
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension RequestsReceivedViewController: RequestsDataManagerDelegate {
    func manager(_ manager: RequestDataManager, iReceive playRequests: [PlayRequest]) {
        myRequests = playRequests
//        requestsTableView.reloadData()
        if myRequests.count == 0 {
            photoImageView.isHidden = false
            noDataLabel.isHidden = false
            requestsTableView.isHidden = true
        } else {
            photoImageView.isHidden = true
            noDataLabel.isHidden = true
            requestsTableView.isHidden = false
            requestsTableView.reloadData()
        }
    }
    func manager(_ manager: RequestDataManager, iSent playRequests: [PlayRequest]) {
    }
}
