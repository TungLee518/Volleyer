//
//  PostFinderViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/19.
//

import UIKit

private enum PostFields: Int, CaseIterable {
    case startTime
    case endTime
    case place
    case price
    case type
    case lackAmount
    case levels
    case setBallCheckBoxes
    case blockCheckBoxes
    case digCheckBoxes
    case spikeCheckBoxes
    case sumCheckBoxes
}

class PostFinderViewController: UIViewController {

    private var postFinderTableView: UITableView!

    private lazy var publishButton: UIButton = {
        let button = UIButton()
        button.purpleButton()
        button.setTitle(EstablishPageEnum.publish.rawValue, for: .normal)
        button.addTarget(self, action: #selector(addData), for: .touchUpInside)
        return button
    }()
    private lazy var deletePostButton: UIButton = {
        let button = UIButton()
        button.whiteButton()
        button.setTitle(EstablishPageEnum.deletePost.rawValue, for: .normal)
        button.addTarget(self, action: #selector(deletePost), for: .touchUpInside)
        button.isHidden = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUpNavBar()
        setButtons()
        setTableView()
    }

    private func setUpNavBar() {
        navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = NavBarEnum.establishFinderPage.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .purple2
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
//        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }

    private func setTableView() {
        postFinderTableView = UITableView()
        postFinderTableView.dataSource = self
        postFinderTableView.delegate = self
        postFinderTableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: TextFieldTableViewCell.identifier)
        postFinderTableView.separatorStyle = .none
        view.addSubview(postFinderTableView)
        postFinderTableView.translatesAutoresizingMaskIntoConstraints = false
        postFinderTableView.rowHeight = UITableView.automaticDimension
        postFinderTableView.estimatedRowHeight = 10
        NSLayoutConstraint.activate([
            postFinderTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postFinderTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postFinderTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postFinderTableView.bottomAnchor.constraint(equalTo: publishButton.topAnchor)
        ])
    }

    func setButtons() {
        view.addSubview(publishButton)
        view.addSubview(deletePostButton)
        NSLayoutConstraint.activate([
            publishButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            publishButton.heightAnchor.constraint(equalToConstant: standardButtonHeight),
            publishButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: standardMargin/2),
            publishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),

            deletePostButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: standardMargin),
            deletePostButton.trailingAnchor.constraint(equalTo: publishButton.leadingAnchor, constant: -standardMargin/2),
            deletePostButton.centerYAnchor.constraint(equalTo: publishButton.centerYAnchor),
            deletePostButton.heightAnchor.constraint(equalToConstant: standardButtonHeight)
        ])
    }

    @objc func addData(_ sender: UIButton) {

    }
    @objc func deletePost() {

    }
}

extension PostFinderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostFields.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fieldCells = PostFields(rawValue: indexPath.row)
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as! TextFieldTableViewCell
        // swiftlint:enable force_cast
        switch fieldCells {
        case .startTime:
            cell.setLabelAndTextField()
            cell.theLabel.text = "開始時間"
            cell.theTextField.placeholder = "start time"
        case .endTime:
            cell.setLabelAndTextField()
            cell.theLabel.text = "結束時間"
            cell.theTextField.placeholder = "end time"
        case .place:
            cell.setLabelAndTextField()
            cell.theLabel.text = "地點"
            cell.theTextField.placeholder = "place"
        case .price:
            cell.setLabelAndTextField()
            cell.theLabel.text = "價錢"
            cell.theTextField.placeholder = "price"
        case .type:
            cell.setLabelAndTextField()
            cell.theLabel.text = "場種"
            cell.theTextField.placeholder = "X 網 X 排"
        case .lackAmount:
            // 還沒寫
            cell.setLabelAndTextField()
            cell.theLabel.text = "缺"
        case .levels:
            cell.setSABC()
        case .setBallCheckBoxes:
            cell.setCheckboxesList = cell.createCheckboxes(text: "舉球", action: #selector(cell.setCheckboxTapped))
        case .blockCheckBoxes:
            cell.blocCheckboxesList = cell.createCheckboxes(text: "攔網", action: #selector(cell.blockCheckboxTapped))
        case .digCheckBoxes:
            cell.digCheckboxesList = cell.createCheckboxes(text: "接球", action: #selector(cell.digCheckboxTapped))
        case .spikeCheckBoxes:
            cell.spikeCheckboxesList = cell.createCheckboxes(text: "攻擊", action: #selector(cell.spickCheckboxTapped))
        case .sumCheckBoxes:
            cell.sumCheckboxesList = cell.createCheckboxes(text: "綜合", action: #selector(cell.sumCheckboxTapped))
        case .none:
            cell.theLabel.text = "nothing"
        }
        return cell
    }
}
