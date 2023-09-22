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
        label.text = "Sent date"
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
    lazy var acceptRequestButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Accept  ", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(acceptRequest), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    lazy var denyRequestButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Deny  ", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(denyRequest), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    var statusLable: UILabel = {
        let label = UILabel()
        label.text = "Status"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()

    var updateStatus: ((Int) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLable)
        contentView.addSubview(dateLable)
//        contentView.addSubview(playersLable)
        contentView.addSubview(acceptRequestButton)
        contentView.addSubview(denyRequestButton)
        contentView.addSubview(statusLable)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            titleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            titleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin),

            dateLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            dateLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: standardMargin),

            acceptRequestButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),
            acceptRequestButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin),
            acceptRequestButton.centerYAnchor.constraint(equalTo: dateLable.centerYAnchor),

            denyRequestButton.trailingAnchor.constraint(equalTo: acceptRequestButton.leadingAnchor, constant: -standardMargin),
            denyRequestButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin),
            denyRequestButton.centerYAnchor.constraint(equalTo: dateLable.centerYAnchor),

            statusLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),
            statusLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin),
            statusLable.centerYAnchor.constraint(equalTo: dateLable.centerYAnchor)
        ])
    }

    @objc func acceptRequest() {
        showOnly(status: "Accepted")
        updateStatus?(99)
    }

    @objc func denyRequest() {
        showOnly(status: "Denied")
        updateStatus?(1)
    }

    func showOnly(status: String) {
        acceptRequestButton.isHidden = true
        denyRequestButton.isHidden = true
        statusLable.isHidden = false
        statusLable.text = "Request \(status)"
    }
}