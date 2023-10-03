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
        label.font = UIFont.systemFont(ofSize: 14)
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
        button.setTitle(" \(RequestEnum.accept.rawValue)  ", for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .purple6
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.purple1.cgColor
        button.addTarget(self, action: #selector(acceptRequest), for: .touchUpInside)
        return button
    }()
    lazy var denyRequestButton: UIButton = {
        let button = UIButton()
        button.setTitle(" \(RequestEnum.deny.rawValue)  ", for: .normal)
        button.titleLabel?.font =  .regularNunito(size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .gray6
        button.setTitleColor(.purple1, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.purple1.cgColor
        button.addTarget(self, action: #selector(denyRequest), for: .touchUpInside)
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
            acceptRequestButton.widthAnchor.constraint(equalToConstant: standardButtonWidth*2/3),

            denyRequestButton.trailingAnchor.constraint(equalTo: acceptRequestButton.leadingAnchor, constant: -standardMargin/2),
            denyRequestButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin),
            denyRequestButton.centerYAnchor.constraint(equalTo: dateLable.centerYAnchor),
            denyRequestButton.widthAnchor.constraint(equalToConstant: standardButtonWidth*2/3),

            statusLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),
            statusLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin),
            statusLable.centerYAnchor.constraint(equalTo: dateLable.centerYAnchor)
        ])
    }

    @objc func acceptRequest() {
        showOnly(status: RequestEnum.accepted.rawValue)
        updateStatus?(99)
    }

    @objc func denyRequest() {
        showOnly(status: RequestEnum.denied.rawValue)
        updateStatus?(1)
    }

    func showOnly(status: String) {
        acceptRequestButton.isHidden = true
        denyRequestButton.isHidden = true
        statusLable.isHidden = false
        statusLable.text = "\(RequestEnum.invite.rawValue)\(status)"
    }
}
