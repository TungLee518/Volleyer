//
//  PlayerListTableView.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/16.
//

import Foundation
import UIKit

class PlayerListTableView: UITableView, UITableViewDataSource, UITableViewDelegate, EditPlayersDelegate {
    
    var players: [Player] = []
    var isEditingEnabled = false // Flag to track editing mode

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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
        cell.selectionStyle = .none
        cell.playerDelegate = self
        // swiftlint:enable force_cast
        let player = players[indexPath.row]
        
        // 第一個永遠是自己
        if indexPath.row == 0 {
            cell.showOnly(with: player)
        } 
        return cell
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
    func addNewPlayer(_ player: Player) {
        players.append(player)
        insertRows(at: [IndexPath(row: players.count - 1, section: 0)], with: .automatic)
    }
    
    func addPlayer(from cell: PlayerTableViewCell, add player: Player) {
        guard let indexPath = indexPath(for: cell) else {
            return
        }
        players[indexPath.row] = player
    }
}
