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
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .purple2
        return label
    }()
    
    var finderTableView: UITableView!

    private let dataManager = DataManager()
    var publicPlays = [Play]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        dataManager.playDataDelegate = self
        setHeader()
        setTableView()
        setLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        dataManager.getPublishPlay()
    }

    func setNavBar() {
        self.view.backgroundColor = UIColor.white
        navigationItem.title = NavBarEnum.finderPage.rawValue
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .purple7
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.semiboldNunito(size: 20)
         ]
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushToEstablishVC))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
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
//        finderTableView.allowsSelection = false
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
            finderTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
//        cell.selectionStyle = .none
//        cell.layer.cornerRadius = 10
//        cell.layer.borderColor = UIColor.gray3.cgColor
//        cell.layer.borderWidth = 2
        cell.clipsToBounds = true
//        cell.layer.masksToBounds = false
//        cell.layer.shadowRadius = 4
//        cell.layer.shadowOffset = CGSize(width: 0, height: 3)
//        cell.layer.shadowOpacity = 0.3
//        cell.layer.shadowColor = UIColor.gray2.cgColor
        return cell
    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UITableViewHeaderFooterView()
//        headerView.translatesAutoresizingMaskIntoConstraints = false
//        headerView.backgroundView = {
//            let view = UIView()
//            view.backgroundColor = .purple7
//            return view
//        }()
//        let ballImage = UIImageView()
//        ballImage.image = UIImage(named: "players")
//        ballImage.translatesAutoresizingMaskIntoConstraints = false
//        headerView.contentView.addSubview(ballImage)
//        NSLayoutConstraint.activate([
//            ballImage.trailingAnchor.constraint(equalTo: headerView.contentView.trailingAnchor, constant: -16),
//            ballImage.topAnchor.constraint(equalTo: headerView.contentView.topAnchor, constant: 12),
//            ballImage.bottomAnchor.constraint(equalTo: headerView.contentView.bottomAnchor, constant: -12),
//            ballImage.heightAnchor.constraint(equalToConstant: 60),
//            ballImage.widthAnchor.constraint(equalToConstant: 60)
//        ])
//        let headerLabel = UILabel()
//        headerLabel.translatesAutoresizingMaskIntoConstraints = false
//        headerLabel.text = "快來找適合自己的場！"
//        headerLabel.font = .boldSystemFont(ofSize: 20)
//        headerLabel.textColor = .purple2
//        headerView.contentView.addSubview(headerLabel)
//
//        NSLayoutConstraint.activate([
//            headerLabel.leadingAnchor.constraint(equalTo: headerView.contentView.leadingAnchor, constant: 16),
//            headerLabel.topAnchor.constraint(equalTo: headerView.contentView.topAnchor, constant: 12),
//            headerLabel.bottomAnchor.constraint(equalTo: headerView.contentView.bottomAnchor, constant: -12)
//        ])
//
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = AddPlayViewController()
        nextVC.thisPlay = publicPlays[indexPath.section]
        nextVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

// not determine public or not yet
extension FinderViewController: PlayDataManagerDelegate {
    func manager(_ manager: DataManager, didGet plays: [Play]) {
        publicPlays = plays
        finderTableView.reloadData()
    }
}
