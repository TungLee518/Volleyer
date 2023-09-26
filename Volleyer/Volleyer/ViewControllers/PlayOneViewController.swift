//
//  PlayOneViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/24.
//

import UIKit

class PlayOneViewController: UIViewController {

    @IBOutlet weak var playOneTableView: UITableView!

    let playOneData: [PlayOne] = [
        PlayOne(court: "場一", finders: [
            User(id: "maymmm518", email: "maymmm518@gmail.com", gender: 1, name: "May"),
            User(id: "iamMandy", email: "mandy@gmail.com", gender: 0, name: "Mandy"),
            User(id: "iamIris", email: "iris@gmail.com", gender: 1, name: "Iris"),
            User(id: "iamRuby", email: "ruby@gmail.com", gender: 1, name: "Ruby"),
            User(id: "iamAaron", email: "aaron@gmail.com", gender: 0, name: "Aaron"),
            User(id: "iamSteven", email: "steven@gmail.com", gender: 0, name: "Steven")
        ]),
        PlayOne(court: "場三", finders: [
            User(id: "iamShuyu", email: "shuyu@gmail.com", gender: 0, name: "Shuyu")
        ]),
        PlayOne(court: "場四", finders: [
            User(id: "iamAngus", email: "angus@gmail.com", gender: 0, name: "Angus")
        ]),
        PlayOne(court: "場五", finders: [
            User(id: "iamAngus", email: "angus@gmail.com", gender: 0, name: "Angus")
        ]),
        PlayOne(court: "場六", finders: [
            User(id: "iamAngus", email: "angus@gmail.com", gender: 0, name: "Angus")
        ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
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
            nextVC.court = "\(playOneData[whichCourt].court) play\(whichFinder+1)"
            nextVC.finderInfo = playOneData[whichCourt].finders[whichFinder]
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension PlayOneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        playOneData.count
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        playOneData[section].court
//    }
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
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        view.tintColor = .purple2
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.heightAnchor.constraint(equalToConstant: standardButtonHeight).isActive = true
//        guard let header = view as? UITableViewHeaderFooterView else { return }
//        header.textLabel?.textColor = .gray7
//        header.textLabel?.font = .semiboldNunito(size: 20)
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
            headerLabel.trailingAnchor.constraint(equalTo: headerView.contentView.trailingAnchor, constant: -16),
            headerLabel.topAnchor.constraint(equalTo: headerView.contentView.topAnchor, constant: 12),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.contentView.bottomAnchor, constant: -12)
        ])

        return headerView
    }
}
