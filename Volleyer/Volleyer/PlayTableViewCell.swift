//
//  PlayTableViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/17.
//

import Foundation
import UIKit

class PlayTableViewCell: UITableViewCell {

    static let identifier = "PlayTableViewCell"

    private let playView = PlayInfoView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(playView)
        setLayout()
        playView.setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        playView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            playView.topAnchor.constraint(equalTo: contentView.topAnchor),
            playView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            playView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    @objc func addData() {
    }
}
