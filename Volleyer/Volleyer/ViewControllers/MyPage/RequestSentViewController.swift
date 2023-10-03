//
//  RequestSentViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/22.
//

import UIKit
import MJRefresh

class RequestSentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var requestsTableView: UITableView!

    private let dataManager = RequestDataManager()
    var myRequests = [PlayRequest]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        dataManager.getPlayRequests()
        dataManager.playRequestDelegate = self
        setTableView()
        RequestDataManager.sharedDataMenager.updateRequestsSentTableView = { [weak self] modifiedRequest in
            guard let self = self else { return }
            for i in 0..<myRequests.count {
                if myRequests[i].id == modifiedRequest.id {
                    myRequests[i] = modifiedRequest
                    let indexPathToReload = IndexPath(row: i, section: 0)
                    requestsTableView.reloadRows(at: [indexPathToReload], with: .automatic)
                }
            }
        }
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myRequests.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: RequestsTableViewCell.identifier, for: indexPath) as! RequestsTableViewCell
        // swiftlint:enable force_cast

        let thisRequest = myRequests[indexPath.row]
        cell.titleLable.text = RequestEnum.requestSentTo.rawValue + " " + thisRequest.requestReceverId

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
            cell.showOnly(status: requestStatus[0])
        } else if thisRequest.status == -1 { // cancel
            cell.showOnly(status: requestStatus[3])
        } else { // deny
            cell.showOnly(status: requestStatus[2])
        }
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = InfoViewController()
        // firebase get data by play id and request_sender_id
        nextVC.thisPlayId = myRequests[indexPath.row].playId
        nextVC.thisUserId = myRequests[indexPath.row].requestReceverId
        nextVC.thisRequest = myRequests[indexPath.row]
        nextVC.cancelRequestButton.isHidden = false
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension RequestSentViewController: RequestsDataManagerDelegate {
    func manager(_ manager: RequestDataManager, iReceive playRequests: [PlayRequest]) {

    }
    func manager(_ manager: RequestDataManager, iSent playRequests: [PlayRequest]) {
        myRequests = playRequests
        requestsTableView.reloadData()
    }
}
