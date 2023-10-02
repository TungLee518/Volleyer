//
//  MyDataManager.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/30.
//

import Foundation
import FirebaseFirestore
import FirebaseCore
import FirebaseStorage

class MyDataManager {

    let users = Firestore.firestore().collection("users")
    private let storage = Storage.storage().reference()

    func saveProfileImage(imageData: Data) {
        let savePath = "profileImages/\(UserDefaults.standard.string(forKey: UserTitle.id.rawValue) ?? "user_default_error").png"
        storage.child(savePath).putData(imageData) { _, error in
            guard error == nil else {
                print("Upload Photo Fail")
                return
            }
            self.storage.child(savePath).downloadURL { url, error in
                guard let url = url, error == nil else {
                    return
                }
                let urlString = url.absoluteString
                print("Image dounload string: \(urlString)")
                UserDefaults.standard.set(urlString, forKey: UserTitle.image.rawValue)
                self.users.document(UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "user_default_error").updateData([
                    "image": urlString
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
    }

    func getProfileData() {
        users.whereField("id", isEqualTo: "maymmm518").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    // swiftlint:disable force_cast
                    for document in querySnapshot!.documents {
                        let documentLevel = document.data()["self_level"] as! [String: Int]
                        let thisUser = User(firebaseId: document.documentID,
                                            id: document.data()["id"] as! String,
                                            email: document.data()["email"] as! String,
                                            gender: document.data()["gender"] as! Int,
                                            name: document.data()["name"] as! String,
                                            level: LevelRange(setBall: documentLevel["set"]!,
                                                              block: documentLevel["block"]!,
                                                              dig: documentLevel["dig"]!,
                                                              spike: documentLevel["spike"]!,
                                                              sum: documentLevel["sum"]!
                                                             ),
                                            image: document.data()["image"] as! String
                        )
                        print("success get user data \(document.documentID) => \(document.data())")
                        print(thisUser)
                        // all strings
                        UserDefaults.standard.set(thisUser.firebaseId, forKey: UserTitle.firebaseId.rawValue)
                        UserDefaults.standard.set(thisUser.id, forKey: UserTitle.id.rawValue)
                        UserDefaults.standard.set(thisUser.name, forKey: UserTitle.name.rawValue)
                        UserDefaults.standard.set(thisUser.image, forKey: UserTitle.image.rawValue)
                        UserDefaults.standard.set(thisUser.email, forKey: UserTitle.email.rawValue)
                        UserDefaults.standard.set(thisUser.gender, forKey: UserTitle.gender.rawValue)
                        UserDefaults.standard.set(thisUser.level.setBall, forKey: Level.setBall.rawValue)
                        UserDefaults.standard.set(thisUser.level.block, forKey: Level.block.rawValue)
                        UserDefaults.standard.set(thisUser.level.dig, forKey: Level.dig.rawValue)
                        UserDefaults.standard.set(thisUser.level.spike, forKey: Level.spike.rawValue)
                        UserDefaults.standard.set(thisUser.level.sum, forKey: Level.sum.rawValue)
                    }
                    // swiftlint:enable force_cast
                }
        }
    }
}
