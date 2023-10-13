//
//  ViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/13.
//

import UIKit
import FirebaseFirestore
import MJRefresh

class FinderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var db: Firestore!
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let ballImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "players")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "快來找適合自己的場！"
        label.font = .semiboldNunito(size: 20)
        label.textColor = .purple2
        return label
    }()
    var pullDownRefreshLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "下拉更新貼文"
        label.font = .regularNunito(size: 16)
        label.textColor = .gray2
        return label
    }()

    var finderTableView: UITableView!

    private let dataManager = FinderDataManager()
    var publicPlays = [Play]()

    let navigationBarAppearance = UINavigationBarAppearance()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pullDownRefreshLabel)
        dataManager.playDataDelegate = self
        setHeader()
        setTableView()
        setLayout()
        setNavBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pullDownRefreshLabel.isHidden = false
        pullDownRefreshLabel.text = "下拉更新貼文"
        dataManager.getPublishPlay()
        setNavBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
//        setDisapearNavBar()
    }

    func setNavBar() {
        self.view.backgroundColor = UIColor.white
        navigationItem.title = NavBarEnum.finderPage.rawValue
//        navigationController?.navigationBar.backgroundColor = .purple7
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .purple7
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.semiboldNunito(size: 20)
         ]
        navigationBarAppearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
//        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        // establish post button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushToEstablishVC))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }
    func setDisapearNavBar() {
//        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
//        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }

    @objc func pushToEstablishVC() {
        let nextVC = EstablishFinderViewController()
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
    }

    func setHeader() {
        view.addSubview(headerView)
        headerView.addSubview(headerLabel)
        headerView.addSubview(ballImage)
    }

    func setTableView() {
        finderTableView = UITableView()
        finderTableView.dataSource = self
        finderTableView.delegate = self
        finderTableView.register(FinderTableViewCell.self, forCellReuseIdentifier: FinderTableViewCell.identifier)
        finderTableView.separatorStyle = .none
        finderTableView.showsVerticalScrollIndicator = false
        view.addSubview(finderTableView)

        finderTableView.translatesAutoresizingMaskIntoConstraints = false
        finderTableView.rowHeight = UITableView.automaticDimension
        finderTableView.estimatedRowHeight = 50
        MJRefreshNormalHeader {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }
                dataManager.getPublishPlay()
                self.finderTableView.mj_header?.endRefreshing()
            }
        }.autoChangeTransparency(true).link(to: self.finderTableView)
    }

    func setLayout() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100),
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: standardMargin),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            ballImage.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -standardMargin),
            ballImage.heightAnchor.constraint(equalToConstant: 60),
            ballImage.widthAnchor.constraint(equalToConstant: 60),
            ballImage.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            finderTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            finderTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            finderTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            finderTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pullDownRefreshLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pullDownRefreshLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            pullDownRefreshLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: standardMargin)
        ])
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        publicPlays.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: FinderTableViewCell.identifier, for: indexPath) as! FinderTableViewCell
        // swiftlint:enable force_cast
        let thisPlay = publicPlays[indexPath.section]
        cell.thisPlay = thisPlay
        cell.parent = self
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = AddPlayViewController()
        nextVC.thisPlay = publicPlays[indexPath.section]
        nextVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

// not determine public or not yet
extension FinderViewController: PlayDataManagerDelegate {
    func manager(_ manager: FinderDataManager, didGet plays: [Play]) {
        pullDownRefreshLabel.isHidden = true
        if plays.count > 0 {
            publicPlays = plays
            finderTableView.reloadData()
        } else {
            pullDownRefreshLabel.text = "目前沒有揪場"
            pullDownRefreshLabel.isHidden = false
        }
    }
}
