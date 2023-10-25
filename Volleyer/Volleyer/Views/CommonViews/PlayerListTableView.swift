//
//  PlayerListTableView.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/16.
//

import Foundation
import UIKit

class PlayerListTableView: UITableView, UITableViewDataSource, UITableViewDelegate, EditPlayersDelegate {

    var players: [User] = []
    var canEdit = true
    weak var parent: UIViewController?

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTableView()
    }

    private func setupTableView() {
        dataSource = self
        delegate = self
        register(PlayerTableViewCell.self, forCellReuseIdentifier: "PlayerTableViewCell")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        let nameLabel: UILabel = {
//            let label = UILabel()
//            label.text = "隊員"
//            label.textColor = UIColor.gray2
//            label.font = .regularNunito(size: 16)
//            label.translatesAutoresizingMaskIntoConstraints = false
//            return label
//        }()
//        let genderLabel: UILabel = {
//            let label = UILabel()
//            label.text = "性別"
//            label.textColor = UIColor.gray2
//            label.font = .regularNunito(size: 16)
//            label.translatesAutoresizingMaskIntoConstraints = false
//            label.isHidden = true
//            return label
//        }()
//        headerView.backgroundColor = UIColor.purple7
//        headerView.layer.cornerRadius = 10
////        headerView.layer.borderColor = UIColor.gray4.cgColor
////        headerView.layer.borderWidth = 0.7
//        headerView.addSubview(nameLabel)
//        headerView.addSubview(genderLabel)
//        NSLayoutConstraint.activate([
//            nameLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
//            nameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//            nameLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: standardMargin/2),
//            nameLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -standardMargin/2),
//            genderLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//            genderLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -standardMargin)
//        ])
//        return headerView
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
        cell.selectionStyle = .none
        cell.playerDelegate = self
        // swiftlint:enable force_cast
        cell.indexLabel.text = String(indexPath.row + 1)
        let player = players[indexPath.row]
        // 第一個永遠是自己
        if indexPath.row == 0 || canEdit == false {
            cell.showOnly(with: player)
        } 
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = ProfileViewController()
        nextVC.thisUser = players[indexPath.row]
        parent?.navigationController?.pushViewController(nextVC, animated: true)
    }

    // Toggle the editing mode of the table view
    func toggleEditing() {
        setEditing(!isEditing, animated: true)
    }

    // Implement editing style for each cell (delete button)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Handle deletion of a player
            let player = players[indexPath.row]
            // Perform deletion logic and update the data source
            players.remove(at: indexPath.row)
            deleteRows(at: [indexPath], with: .fade)
        }
    }

    // Add a new player to the list
    func addNewPlayer(_ player: User) {
        players.append(player)
        insertRows(at: [IndexPath(row: players.count - 1, section: 0)], with: .automatic)
    }

    func addPlayer(from cell: PlayerTableViewCell, add player: User) {
        guard let indexPath = indexPath(for: cell) else {
            return
        }
        players[indexPath.row] = player
    }
}
