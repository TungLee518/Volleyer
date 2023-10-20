//
//  PostFinderViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/19.
//

import UIKit

class PostFinderViewController: UIViewController {

    private var postFinderTableView: UITableView!

    private lazy var publishButton: UIButton = {
        let button = UIButton()
        button.purpleButton()
        button.setTitle(EstablishPageEnum.publish.rawValue, for: .normal)
//         button.addTarget(self, action: #selector(addData), for: .touchUpInside)
        return button
    }()
    private lazy var deletePostButton: UIButton = {
        let button = UIButton()
        button.whiteButton()
        button.setTitle(EstablishPageEnum.deletePost.rawValue, for: .normal)
//        button.addTarget(self, action: #selector(deletePost), for: .touchUpInside)
        button.isHidden = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
//        postFinderTableView.register(postFinderTableViewCell.self, forCellReuseIdentifier: postFinderTableViewCell.identifier)
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

            deletePostButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: standardMargin),
            deletePostButton.trailingAnchor.constraint(equalTo: publishButton.leadingAnchor, constant: -standardMargin/2),
            deletePostButton.centerYAnchor.constraint(equalTo: publishButton.centerYAnchor),
            deletePostButton.heightAnchor.constraint(equalToConstant: standardButtonHeight)
        ])
    }
}


extension PostFinderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: FinderTableViewCell.identifier, for: indexPath) as! FinderTableViewCell
        // swiftlint:enable force_cast
        return cell
    }
    
    
}
