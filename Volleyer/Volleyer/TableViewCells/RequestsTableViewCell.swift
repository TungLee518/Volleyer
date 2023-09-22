//
//  RequestsTableViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/21.
//

import UIKit

class RequestsTableViewCell: UITableViewCell {

    static let identifier = "RequestsTableViewCell"
    
    var titleLable: UILabel = {
        let label = UILabel()
        label.text = "No title"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var dateLable: UILabel = {
        let label = UILabel()
        label.text = "No date"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var playersLable: UILabel = {
        let label = UILabel()
        label.text = "名單"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLable)
        contentView.addSubview(dateLable)
        contentView.addSubview(playersLable)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            titleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            titleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin),

            playersLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            playersLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: standardMargin),

            dateLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),
            dateLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin),
            dateLable.centerYAnchor.constraint(equalTo: playersLable.centerYAnchor)
        ])
    }

    @objc func addData() {
    }
}
