//
//  ViewController.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/13.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    
    var db: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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


}

