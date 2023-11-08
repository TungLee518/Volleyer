//
//  PlayOneViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/24.
//

import UIKit
import MJRefresh

class PlayOneViewController: UIViewController {

    @IBOutlet weak var playOneTableView: UITableView!

    var playOneData: [PlayOne] = []

    let playOneDataManager = PlayOneDataManager()

    var canAddPlay = true
    var courtIAdded: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        LKProgressHUD.show()
        setNavBar()
        playOneDataManager.listenPlayOne()
        playOneDataManager.playOneDataDelegate = self
        playOneDataManager.updatePlayOneTableView = { [weak self] _ in
            guard let self = self else { return }
            playOneData = []
            playOneDataManager.getPlayOneCourts()
        }
        playOneTableView.sectionHeaderTopPadding = 0
        MJRefreshNormalHeader {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }
                playOneData = []
                playOneDataManager.getPlayOneCourts()
                playOneTableView.mj_header?.endRefreshing()
            }
        }.autoChangeTransparency(true).link(to: self.playOneTableView)
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        navigationItem.title = NavBarEnum.playOnePage.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
    }

    func pushToPlayOneFinderVC(whichCourt: Int, whichFinder: Int) {
        let storyboard = UIStoryboard(name: "PlayOne", bundle: nil)
        if let nextVC = storyboard.instantiateViewController(withIdentifier: "PlayOneFinderViewController") as? PlayOneFinderViewController {
            nextVC.court = "\(playOneData[whichCourt].court) play\(whichFinder + 1)"
            nextVC.finderInfo = playOneData[whichCourt].finders[whichFinder]
            nextVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }

    @objc func lineUp(_ sender: UIButton) {
        if canAddPlay {
            playOneDataManager.createPlayOneFinder(finder: UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "No Id")
            playOneDataManager.addFinderOFACourt(finder: UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "No Id", court: playOneData[sender.tag].court)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: RightBarTiems.cancelPlay.rawValue, style: .plain, target: self, action: #selector(cancelPlay))
        } else {
            // 跳個通知
            print("已經加過了")
        }
    }

    @objc func cancelPlay() {
        let controller = UIAlertController(title: "確定？", message: "要取消 Play？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "是", style: .default) { _ in
            print("確定要刪除")
            self.navigationItem.setRightBarButton(nil, animated: false)
            self.canAddPlay = true
            self.playOneDataManager.deleteFinderOFACourt(finder: UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "No User Id", court: self.courtIAdded!)
            self.playOneDataManager.deletaPlayOnefinder(finder: UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "No User Id")
            self.courtIAdded = nil
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        controller.addAction(cancelAction)
        present(controller, animated: true)
    }
}

extension PlayOneViewController: UITableViewDelegate, UITableViewDataSource, PlayOneDataManagerDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        playOneData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = playOneTableView.dequeueReusableCell(withIdentifier: "PlayOneTableViewCell", for: indexPath) as! PlayOneTableViewCell
        cell.playOneCollectionView.tag = indexPath.section
        cell.selectionStyle = .none
        // swiftlint:enable force_cast
        cell.playOneFinderData = playOneData[indexPath.section].finders
        cell.playOneData = playOneData
        cell.tapAFinder = { [weak self] indexPathInCV in
            guard let self = self else { return }
            pushToPlayOneFinderVC(whichCourt: indexPath.section, whichFinder: indexPathInCV.row)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundView = {
            let view = UIView()
            view.backgroundColor = .purple7
            return view
        }()

        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = playOneData[section].court
        headerLabel.font = .boldSystemFont(ofSize: 20)
        headerLabel.textColor = .purple2
        headerView.contentView.addSubview(headerLabel)

        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.contentView.leadingAnchor, constant: 16),
            headerLabel.topAnchor.constraint(equalTo: headerView.contentView.topAnchor, constant: 12),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.contentView.bottomAnchor, constant: -12)
        ])

        let lineUpButton = UIButton()
        lineUpButton.setTitle("+", for: .normal)
        lineUpButton.titleLabel?.font =  .regularNunito(size: 30)
        lineUpButton.titleLabel?.textAlignment = .center
        lineUpButton.backgroundColor = .purple7
        lineUpButton.setTitleColor(.purple1, for: .normal)
        lineUpButton.translatesAutoresizingMaskIntoConstraints = false
        lineUpButton.addTarget(self, action: #selector(lineUp), for: .touchUpInside)
        lineUpButton.tag = section
        headerView.contentView.addSubview(lineUpButton)

        NSLayoutConstraint.activate([
            lineUpButton.trailingAnchor.constraint(equalTo: headerView.contentView.trailingAnchor, constant: -16),
            lineUpButton.topAnchor.constraint(equalTo: headerView.contentView.topAnchor, constant: 12),
            lineUpButton.bottomAnchor.constraint(equalTo: headerView.contentView.bottomAnchor, constant: -12),
            lineUpButton.heightAnchor.constraint(equalToConstant: standardButtonHeight/2)
        ])

        if canAddPlay {
            lineUpButton.isHidden = false
        } else {
            lineUpButton.isHidden = true
        }

        return headerView
    }

    func manager(_ manager: PlayOneDataManager, didget playOne: [PlayOne]) {
        playOneData = playOne
        playOneData.sort { $0.order < $1.order }
        for playOne in playOneData {
            for finder in playOne.finders {
                print("ppppp\(finder.id)")
                if UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) == finder.firebaseId {
                    canAddPlay = false
                    courtIAdded = playOne.court
                    navigationItem.rightBarButtonItem = UIBarButtonItem(title: RightBarTiems.cancelPlay.rawValue, style: .plain, target: self, action: #selector(cancelPlay))
                    navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.purple2], for: .normal)
                    print(canAddPlay)
                }
            }
        }
        print("========\(playOneData)")
        playOneTableView.reloadData()
        LKProgressHUD.dismiss()
    }
}
