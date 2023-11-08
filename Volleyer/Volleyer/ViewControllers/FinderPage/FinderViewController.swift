//
//  ViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/13.
//

import UIKit
import FirebaseFirestore
import MJRefresh
import Lottie

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
        label.accessibilityIdentifier = "Hi"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "快來找適合自己的場！"
        label.font = .semiboldNunito(size: 20)
        label.textColor = .purple2
        return label
    }()
    var noPostLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "目前沒有揪場"
        label.font = .regularNunito(size: 16)
        label.textColor = .gray2
        label.isHidden = true
        return label
    }()
    private var waitingAnimate: LottieAnimationView?
    var pleaseWaitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "請稍候"
        label.font = .regularNunito(size: 16)
        label.textColor = .gray2
        label.isHidden = true
        return label
    }()

    var finderTableView: UITableView!

    private let dataManager = FinderDataManager()
    var publicPlays = [Play]()

    let navigationBarAppearance = UINavigationBarAppearance()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.playDataDelegate = self
        setHeader()
        setTableView()
        setWatingAnimate()
        setLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataManager.getPublishPlay()
        setNavBar()
    }

    func setNavBar() {
        self.view.backgroundColor = UIColor.white
        navigationItem.title = "請稍候"
//        navigationController?.navigationBar.backgroundColor = .purple7
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .purple7
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.semiboldNunito(size: 20) as Any
         ]
        navigationBarAppearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushToEstablishVC))
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "postFinder"
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }

    func setWatingAnimate() {
        waitingAnimate = .init(name: "volleyHit")
        waitingAnimate?.frame = view.bounds
        waitingAnimate?.backgroundColor = .white
        waitingAnimate?.contentMode = .scaleAspectFit
        view.addSubview(waitingAnimate!)
        view.addSubview(pleaseWaitLabel)
        NSLayoutConstraint.activate([
            pleaseWaitLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pleaseWaitLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        waitingAnimate?.isHidden = false
        waitingAnimate?.loopMode = .loop
        waitingAnimate?.animationSpeed = 1.0
        waitingAnimate?.play()
    }
    func showNoPostLabel() {
        view.addSubview(noPostLabel)
        NSLayoutConstraint.activate([
            noPostLabel.centerXAnchor.constraint(equalTo: finderTableView.centerXAnchor),
            noPostLabel.centerYAnchor.constraint(equalTo: finderTableView.centerYAnchor)
        ])
        noPostLabel.isHidden = false
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
        if plays.count > 0 {
            publicPlays = plays
            finderTableView.reloadData()
            waitingAnimate?.stop()
            waitingAnimate?.isHidden = true
            pleaseWaitLabel.isHidden = true
            navigationItem.title = NavBarEnum.finderPage.rawValue
        } else {
            showNoPostLabel()
        }
    }
}
