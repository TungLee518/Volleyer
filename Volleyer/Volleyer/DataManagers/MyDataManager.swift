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

protocol BlockListDataManagerDelegate {
    func manager(_ manager: MyDataManager, didGet blockList: [User])
}

class MyDataManager {

    static let shared = MyDataManager()

    let users = Firestore.firestore().collection("users")
    private let storage = Storage.storage().reference()

    var canGoToTabbarVC: ((Bool) -> Void)?

    var blockListDataManager: BlockListDataManagerDelegate?

    func saveProfileInfo(_ user: User) {
        var data: [String: Any] = [
            UserTitle.firebaseId.rawValue: user.firebaseId,
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
            UserTitle.image.rawValue: user.image,
            UserTitle.blockList.rawValue: user.blockList,
            UserTitle.status.rawValue: user.status
        ]
        // 檢查使用者輸入的 id 是否已經有人用了
        users.whereField(UserTitle.id.rawValue, isEqualTo: user.id).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if querySnapshot!.documents.count > 0 {
                    print("此 ID 已存在")
//                    LKProgressHUD.showFailure(text: "此 ID 已存在")
                    self.canGoToTabbarVC?(false)
                } else {
                    if user.firebaseId != "" { // 以前有過帳號
                        self.users.document(user.firebaseId).updateData(data) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            } else {
                                print("Document successfully updated")
                                self.saveUserDefault(user)
                                UserDefaults.standard.set(user.userIdentifier, forKey: UserTitle.userIdentifier.rawValue)
                                self.canGoToTabbarVC?(true)
                            }
                        }
                    } else { // 以前沒有帳號，要新增
                        let document = self.users.document()
                        data.updateValue(document.documentID, forKey: UserTitle.firebaseId.rawValue)
                        data["created_time"] = Date()
                        document.setData(data) { err in
                            if let err = err {
                                print("Error adding document: \(err)")
                            } else {
                                print("User Document added with ID: \(document.documentID)")
                                var userCopy = user
                                userCopy.firebaseId = document.documentID
                                self.saveUserDefault(userCopy)
                                UserDefaults.standard.set(user.userIdentifier, forKey: UserTitle.userIdentifier.rawValue)
                                self.canGoToTabbarVC?(true)
                            }
                        }
                    }
                }
            }
        }
    }

    func saveProfileImage(imageData: Data) {
        let savePath = "profileImages/\(UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "user_default_error").png"
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

    func updateProfileInfo(changedUser: User, completion: @escaping (Bool?, Error?) -> Void) {
        let data: [String: Any] = [
            UserTitle.id.rawValue: changedUser.id,
            UserTitle.email.rawValue: changedUser.email,
            UserTitle.name.rawValue: changedUser.name,
            UserTitle.gender.rawValue: changedUser.gender,
            UserTitle.level.rawValue: [
                "set": changedUser.level.setBall,
                "block": changedUser.level.block,
                "dig": changedUser.level.dig,
                "spike": changedUser.level.spike,
                "sum": changedUser.level.sum
            ]
        ]

        self.users.document(changedUser.firebaseId).updateData(data) { err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(nil, err)
            } else {
                print("Document successfully updated")
                self.saveUserDefault(changedUser)
                completion(true, nil)
            }
        }
    }

    func removeThisuser(firebaseId: String, userId: String) {
        users.document(firebaseId).updateData([
            "status": -1
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                self.deleteUserDefault()
            }
        }
    }
    func addToBlocklist(userId: String) {
        users.document(UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "no my id").getDocument { (document, error) in
            if let document = document, document.exists {
                var blockList = document.data()?[UserTitle.blockList.rawValue] as? [String]
                let blockListIdx = blockList?.firstIndex(of: userId)
                if blockListIdx == nil {
                    blockList?.append(userId)
                    self.users.document(UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "no my id").updateData([
                        UserTitle.blockList.rawValue: blockList as Any
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("BlockList successfully updated")
                            LKProgressHUD.showSuccess(text: "成功封鎖")
                        }
                    }
                } else {
                    LKProgressHUD.showFailure(text: "已封鎖此用戶")
                }
            } else {
                print("User Document does not exist")
            }
        }
    }

    func removeFromBlocklist(userId: String) {
        users.document(UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "no my id").getDocument { (document, error) in
            if let document = document, document.exists {
                var blockList = document.data()?[UserTitle.blockList.rawValue] as? [String]
                let blockListIdx = blockList?.firstIndex(of: userId)
                if let blockListIdx = blockListIdx {
                    blockList?.remove(at: blockListIdx)
                    self.users.document(UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "no my id").updateData([
                        UserTitle.blockList.rawValue: blockList
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("BlockList successfully updated")
                            LKProgressHUD.showSuccess(text: "成功解除封鎖")
                        }
                    }
                }
            } else {
                print("User Document does not exist")
            }
        }
    }

    func getBlockList() {
        users.document(UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "no my id").getDocument { (document, error) in
            if let document = document, document.exists {
                var blockList = document.data()?[UserTitle.blockList.rawValue] as? [String]
                if let blockList = blockList {
                    if blockList.count == 0 {
                        self.blockListDataManager?.manager(self, didGet: [])
                    } else {
                        var blockListUser = [User]()
                        for id in blockList {
                            self.getUserByFirebaseId(id: id) { theUser, err in
                                if let error = err {
                                    print("Error: \(error)")
                                } else if let theUser = theUser {
                                    blockListUser.append(theUser)
                                    if blockListUser.count == blockList.count {
                                        self.blockListDataManager?.manager(self, didGet: blockListUser)
                                    }
                                } else {
                                    print("No matching document found")
                                }
                            }
                        }
                    }
                }
            } else {
                print("User Document does not exist")
            }
        }
    }

    func getSimulatorProfileData() {
        users.whereField("id", isEqualTo: "iamMandy").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let documentLevel = document.data()["self_level"] as? [String: Int]
                        let thisUser = User(firebaseId: document.documentID,
                                            id: document.data()["id"] as? String ?? "no id",
                                            email: document.data()["email"] as? String ?? "no email",
                                            gender: document.data()["gender"] as? Int ?? 0,
                                            name: document.data()["name"] as? String ?? "no name",
                                            level: LevelRange(setBall: documentLevel?["set"] ?? 0,
                                            block: documentLevel?["block"] ?? 0,
                                            dig: documentLevel?["dig"] ?? 0,
                                            spike: documentLevel?["spike"] ?? 0,
                                            sum: documentLevel?["sum"] ?? 0
                                            ),
                                            image: document.data()["image"] as? String ?? placeholderImage
                        )
                        print("success get user data \(document.documentID) => \(document.data())")
                        print(thisUser)
                        // all strings
                        self.saveUserDefault(thisUser)
                    }
                }
        }
    }

    func getProfileData(appleUserId: String, completion: @escaping (User?, Error?) -> Void) {
        users.whereField(UserTitle.userIdentifier.rawValue, isEqualTo: appleUserId).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion(nil, err)
                } else {
                    for document in querySnapshot!.documents {
                        let thisUser = self.decodeUser(document)
                        print("success get user data \(document.documentID) => \(document.data())")
                        self.saveUserDefault(thisUser)
                        completion(thisUser, nil)
                    }
                }
        }
    }

    func decodeUser(_ document: QueryDocumentSnapshot) -> User {
        let levelDict = document.data()[UserTitle.level.rawValue] as? [String: Int]
        let levelRange = LevelRange(
            setBall: levelDict?[LevelTitle.set.rawValue] ?? 0,
            block: levelDict?[LevelTitle.block.rawValue] ?? 0,
            dig: levelDict?[LevelTitle.dig.rawValue] ?? 0,
            spike: levelDict?[LevelTitle.spike.rawValue] ?? 0,
            sum: levelDict?[LevelTitle.sum.rawValue] ?? 0
        )
        let aUser = User(
            firebaseId: document.documentID,
            loginWay: document.data()[UserTitle.loginWay.rawValue] as? Int ?? 0,
            userIdentifier: document.data()[UserTitle.userIdentifier.rawValue] as? String ?? "",
            id: document.data()[UserTitle.id.rawValue] as? String ?? "no id",
            email: document.data()[UserTitle.email.rawValue] as? String ?? "no email",
            gender: document.data()[UserTitle.gender.rawValue] as? Int ?? 0,
            name: document.data()[UserTitle.name.rawValue] as? String ?? "no name",
            level: levelRange,
            myPlayList: document.data()[UserTitle.myPlayList.rawValue] as? [String] ?? [],
            image: document.data()[UserTitle.image.rawValue] as? String ?? placeholderImage,
            blockList: document.data()[UserTitle.blockList.rawValue] as? [String] ?? [],
            status: document.data()[UserTitle.status.rawValue] as? Int ?? 0
        )
        return aUser
    }

    func decodeUserDS(_ document: DocumentSnapshot) -> User {
        let levelDict = document.data()?[UserTitle.level.rawValue] as? [String: Int]
        let levelRange = LevelRange(
            setBall: levelDict?[LevelTitle.set.rawValue] ?? 0,
            block: levelDict?[LevelTitle.block.rawValue] ?? 0,
            dig: levelDict?[LevelTitle.dig.rawValue] ?? 0,
            spike: levelDict?[LevelTitle.spike.rawValue] ?? 0,
            sum: levelDict?[LevelTitle.sum.rawValue] ?? 0
        )
        let aUser = User(
            firebaseId: document.documentID,
            loginWay: document.data()?[UserTitle.loginWay.rawValue] as? Int ?? 0,
            userIdentifier: document.data()?[UserTitle.userIdentifier.rawValue] as? String ?? "",
            id: document.data()?[UserTitle.id.rawValue] as? String ?? "no id",
            email: document.data()?[UserTitle.email.rawValue] as? String ?? "no email",
            gender: document.data()?[UserTitle.gender.rawValue] as? Int ?? 0,
            name: document.data()?[UserTitle.name.rawValue] as? String ?? "no name",
            level: levelRange,
            myPlayList: document.data()?[UserTitle.myPlayList.rawValue] as? [String] ?? [],
            image: document.data()?[UserTitle.image.rawValue] as? String ?? placeholderImage,
            blockList: document.data()?[UserTitle.blockList.rawValue] as? [String] ?? [],
            status: document.data()?[UserTitle.status.rawValue] as? Int ?? 0
        )
        return aUser
    }

    func getUserByFirebaseId(id: String, completion: @escaping (User?, Error?) -> Void) {
        users.document(id).getDocument { (document, error) in
            if let document = document, document.exists {
                let thisUser = self.decodeUserDS(document)
                completion(thisUser, nil)
            } else {
                print("Document does not exist")
                completion(nil, error)
            }
        }
    }

    func saveUserDefault(_ thisUser: User) {
        UserDefaults.standard.set(thisUser.firebaseId, forKey: UserTitle.firebaseId.rawValue)
//        UserDefaults.standard.set(thisUser.userIdentifier, forKey: UserTitle.userIdentifier.rawValue) 其他地方會存
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

    func deleteUserDefault() {
        UserDefaults.standard.set(nil, forKey: UserTitle.firebaseId.rawValue)
        UserDefaults.standard.set(nil, forKey: UserTitle.userIdentifier.rawValue)
        UserDefaults.standard.set(nil, forKey: UserTitle.id.rawValue)
        UserDefaults.standard.set(nil, forKey: UserTitle.name.rawValue)
        UserDefaults.standard.set(nil, forKey: UserTitle.image.rawValue)
        UserDefaults.standard.set(nil, forKey: UserTitle.email.rawValue)
        UserDefaults.standard.set(nil, forKey: UserTitle.gender.rawValue)
        UserDefaults.standard.set(nil, forKey: Level.setBall.rawValue)
        UserDefaults.standard.set(nil, forKey: Level.block.rawValue)
        UserDefaults.standard.set(nil, forKey: Level.dig.rawValue)
        UserDefaults.standard.set(nil, forKey: Level.spike.rawValue)
        UserDefaults.standard.set(nil, forKey: Level.sum.rawValue)
    }
}
