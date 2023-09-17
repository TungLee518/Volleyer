//
//  ViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/13.
//

import UIKit
import FirebaseFirestore

class FindPlayerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var db: Firestore!
    var findPlayerTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        setNavBar()
        setTableView()

    }

    func setNavBar() {
        navigationItem.title = NavBarEnum.finderPage.rawValue
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .systemBlue
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 20)
         ]
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushToEstablishVC))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    @objc func pushToEstablishVC() {
        let nextVC = EstablishFinderViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

    func setTableView() {
        findPlayerTableView = UITableView()
        findPlayerTableView.dataSource = self
        findPlayerTableView.delegate = self
        findPlayerTableView.register(PlayInfoTableViewCell.self, forCellReuseIdentifier: PlayInfoTableViewCell.identifier)
        findPlayerTableView.separatorStyle = .singleLine
        view.addSubview(findPlayerTableView)

        findPlayerTableView.translatesAutoresizingMaskIntoConstraints = false
        findPlayerTableView.rowHeight = UITableView.automaticDimension
        findPlayerTableView.estimatedRowHeight = 50
        NSLayoutConstraint.activate([
            findPlayerTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            findPlayerTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            findPlayerTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            findPlayerTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func addTestDataToFirebase() {
        let settings = FirestoreSettings()

        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()

        var ref: DocumentReference? = nil
        ref = db.collection("tests").addDocument(data: [
            "first": "May",
            "middle": "",
            "last": "Lee",
            "born": 1999
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayInfoTableViewCell.identifier, for: indexPath) as! PlayInfoTableViewCell
        // swiftlint:enable force_cast
        return cell
    }

}