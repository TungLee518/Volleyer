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
        setTableView()
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayInfoTableViewCell.identifier, for: indexPath) as! PlayInfoTableViewCell
        
        
        return cell
    }

}

