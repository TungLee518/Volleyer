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
// swiftlint:disable force_cast
class MyDataManager {

    static let shared = MyDataManager()

    let users = Firestore.firestore().collection("users")
    private let storage = Storage.storage().reference()

    var canGoToTabbarVC: ((Bool) -> Void)?

    func saveProfileInfo(_ user: User) {
        let document = users.document()
        let data: [String: Any] = [
            UserTitle.firebaseId.rawValue: document.documentID,
            UserTitle.loginWay.rawValue: user.loginWay,
            UserTitle.id.rawValue: user.id,
            UserTitle.userIdentifier.rawValue: user.userIdentifier,
            UserTitle.email.rawValue: user.email,
            UserTitle.name.rawValue: user.name,
            UserTitle.gender.rawValue: user.gender,
            UserTitle.level.rawValue: [
                "set": user.level.setBall,
                "block": user.level.block,
                "dig": user.level.dig,
                "spike": user.level.spike,
                "sum": user.level.sum
            ],
            UserTitle.myPlayList.rawValue: user.myPlayList,
            UserTitle.image.rawValue: user.image
        ]
        users.whereField(UserTitle.id.rawValue, isEqualTo: user.id).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if querySnapshot!.documents.count > 0 {
                    print("此 ID 已存在")
                    LKProgressHUD.showFailure(text: "此 ID 已存在")
                } else {
                    document.setData(data) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("User Document added with ID: \(document.documentID)")
//                            LKProgressHUD.showSuccess(text: "儲存成功")
                            self.saveUserDefault(user)
                            UserDefaults.standard.set(user.userIdentifier, forKey: UserTitle.userIdentifier.rawValue)
                            self.canGoToTabbarVC?(true)
                        }
                    }
                }
            }
        }
    }
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

    func getSimulatorProfileData() {
        users.whereField("id", isEqualTo: "maymmm518").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
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
                        self.saveUserDefault(thisUser)
                    }
                   
                }
        }
    }

    func getProfileData(userId: String) {
        users.whereField(UserTitle.userIdentifier.rawValue, isEqualTo: userId).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let thisUser = self.decodeUser(document)
                        print("success get user data \(document.documentID) => \(document.data())")
                        self.saveUserDefault(thisUser)
                    }
                }
        }
    }

    func decodeUser(_ document: QueryDocumentSnapshot) -> User {
        let levelDict = document.data()[UserTitle.level.rawValue] as! [String: Int]
        let levelRange = LevelRange(
            setBall: levelDict[LevelTitle.set.rawValue]!,
            block: levelDict[LevelTitle.block.rawValue]!,
            dig: levelDict[LevelTitle.dig.rawValue]!,
            spike: levelDict[LevelTitle.spike.rawValue]!,
            sum: levelDict[LevelTitle.sum.rawValue]!
        )
        let aUser = User(
            firebaseId: document.documentID,
            loginWay: document.data()[UserTitle.loginWay.rawValue] as! Int,
            userIdentifier: document.data()[UserTitle.userIdentifier.rawValue] as! String,
            id: document.data()[UserTitle.id.rawValue] as! String,
            email: document.data()[UserTitle.email.rawValue] as! String,
            gender: document.data()[UserTitle.gender.rawValue] as! Int,
            name: document.data()[UserTitle.name.rawValue] as! String,
            level: levelRange,
            myPlayList: document.data()[UserTitle.myPlayList.rawValue] as! [String],
            image: document.data()[UserTitle.image.rawValue] as! String
        )
        return aUser
    }

    func saveUserDefault(_ thisUser: User) {
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
}
// swiftlint:enable force_cast
