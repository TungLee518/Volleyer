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

    private var playView = PlayInfoView()

    var thisPlay: Play? {
        didSet {
            sendData(thisPlay!)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(playView)
        setLayout()
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

    func sendData(_ data: Play) {
        playView.play = thisPlay
        playView.setUI()
    }

    @objc func addData() {
    }
}
