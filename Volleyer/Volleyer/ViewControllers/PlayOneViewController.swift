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
            User(id: "iamAngus", email: "angus@gmail.com", gender: 0, name: "Angus")
        ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
    }

    private func setNavBar() {
        self.view.backgroundColor = UIColor.white
        self.title = NavBarEnum.playOnePage.rawValue
        let backButton = UIBarButtonItem()
        backButton.title = ""
    }
}

extension PlayOneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        playOneData.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        playOneData[section].court
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
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .green
    }
}
