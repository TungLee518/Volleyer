//
//  PlayOneDataManager.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/28.
//

import Foundation
import FirebaseFirestore
import FirebaseCore
import FirebaseStorage

protocol PlayOneDataManagerDelegate {
    func manager(_ manager: PlayOneDataManager, didget playOne: [PlayOne])
}

protocol PlayOneFinderDataManagerDelegate {
    func manager(_ manager: PlayOneDataManager, didget playerN: [PlayerN])
}

class PlayOneDataManager {

    var playOneDataDelegate: PlayOneDataManagerDelegate?
    var playOneFinderDataDelegate: PlayOneFinderDataManagerDelegate?

    let users = Firestore.firestore().collection("users")
    let playOneCourts = Firestore.firestore().collection("play_one_courts")
    let playOneFinders = Firestore.firestore().collection("play_one_finders")
    private let storage = Storage.storage().reference()

    var updatePlayOneTableView: ((Bool) -> Void)?

    func getPlayOneCourts() {
        playOneCourts.getDocuments { (querySnapshot, err) in
            if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var playOneDataArray: [PlayOne] = []
                    for document in querySnapshot!.documents {
                        print("pppp\(querySnapshot!.documents.count)")
                        let userIds: [String] = document.data()["finder_ids"] as? [String] ?? []
                        print("=====", userIds)
                        let order: Int = document.data()["order"] as? Int ?? 0
                        if userIds.count == 0 {
                            playOneDataArray.append(PlayOne(court: document.documentID, finders: [], order: order))
                            if querySnapshot!.documents.count == playOneDataArray.count {
                                self.playOneDataDelegate?.manager(self, didget: playOneDataArray)
                            }
                        } else {
                            var finders: [User] = []
                            for i in 0..<userIds.count {
                                self.users.whereField(UserTitle.firebaseId.rawValue, isEqualTo: userIds[i]).getDocuments() { (userQuerySnapshot, err) in
                                        if let err = err {
                                            print("Error getting documents: \(err)")
                                        } else {
                                            for userDocument in userQuerySnapshot!.documents {
                                                var thisUser = self.decodeUser(userDocument)
                                                thisUser.playN = i
                                                finders.insert(thisUser, at: 0)
                                                print("===\(finders)")
                                                if finders.count == userIds.count {
                                                    finders.sort { $0.playN < $1.playN }
                                                    playOneDataArray.append(PlayOne(court: document.documentID, finders: finders, order: order))
                                                    if querySnapshot!.documents.count == playOneDataArray.count {
                                                        self.playOneDataDelegate?.manager(self, didget: playOneDataArray)
                                                    }
                                                }
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
        }
    }

    func addFinderOFACourt(finder: String, court: String) {
        playOneCourts.document(court).getDocument { document, error in
            if let document = document, document.exists {
                var userIds: [String] = document.data()?["finder_ids"] as? [String] ?? []
                userIds.append(finder)
                self.playOneCourts.document(court).updateData([
                    "finder_ids": userIds
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }

    func deleteFinderOFACourt(finder: String, court: String) {
        playOneCourts.document(court).getDocument { document, error in
            if let document = document, document.exists {
                var userIds: [String] = document.data()?["finder_ids"] as? [String] ?? []
                let finderIndex = userIds.firstIndex(of: finder)
                if let finderIndex = finderIndex {
                    userIds.remove(at: finderIndex)
                }
                self.playOneCourts.document(court).updateData([
                    "finder_ids": userIds
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }

    func savePlayOneImage(finder: User, playerN: String, imageData: Data, playerName: String, completion: @escaping (Error?) -> Void) {
        let savePath = "playOneImages/\(finder.firebaseId) \(playerN).png"
        storage.child(savePath).putData(imageData) { _, error in
            guard error == nil else {
                print("Upload Photo Fail")
                completion(error)
                return
            }
            self.storage.child(savePath).downloadURL { url, error in
                guard let url = url, error == nil else {
                    completion(error)
                    return
                }
                let urlString = url.absoluteString
                print("Image dounload string: \(urlString)")
                self.playOneFinders.document(finder.firebaseId).updateData([
                    playerN: [
                    "name": playerName,
                    "image": urlString
                    ]
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                        completion(err)
                    } else {
                        print("Document successfully written!")
                        completion(nil)
                    }
                }
            }
        }
    }

    func createPlayOneFinder(finder: String) {
        playOneFinders.document(finder).setData([
            "player1": [
                "name": "",
                "image": ""
            ],
            "player2": [
                "name": "",
                "image": ""
            ],
            "player3": [
                "name": "",
                "image": ""
            ],
            "player4": [
                "name": "",
                "image": ""
            ],
            "player5": [
                "name": "",
                "image": ""
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }

    func deletaPlayOnefinder(finder: String) {
        playOneFinders.document(finder).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }

    func listenPlayOne() {
        playOneCourts.addSnapshotListener { documentSnapshot, error in
            if let error = error {
                print("Error retreiving collection: \(error)")
            }
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            print("Current data: \(document)")
            self.updatePlayOneTableView?(true)
        }
    }

    func getPlayOneFinderData(finder: String) {
        playOneFinders.document(finder).getDocument { (document, error) in
            if let document = document, document.exists {
                let playersTitle = ["player1", "player2", "player3", "player4", "player5"]
                var fivePlayersData: [PlayerN] = []
                for playern in playersTitle {
                    let player = document.data()?[playern] as? [String: String]
                    fivePlayersData.append(PlayerN(name: player?["name"] ?? "", image: player?["image"] ?? ""))
                }
                self.playOneFinderDataDelegate?.manager(self, didget: fivePlayersData)
            } else {
                print("Document does not exist")
            }
        }
    }
}

extension PlayOneDataManager {
    func decodePlay(_ document: QueryDocumentSnapshot) -> Play {
        let levelDict = document.data()[PlayTitle.levelRange.rawValue] as? [String: Int]
        let levelRange = LevelRange(
            setBall: levelDict?[LevelTitle.set.rawValue] ?? 0,
            block: levelDict?[LevelTitle.block.rawValue] ?? 0,
            dig: levelDict?[LevelTitle.dig.rawValue] ?? 0,
            spike: levelDict?[LevelTitle.spike.rawValue] ?? 0,
            sum: levelDict?[LevelTitle.sum.rawValue] ?? 0
        )
        let lackDict = document.data()[PlayTitle.lackAmount.rawValue] as? [String: Int]
        let lackAmount = LackAmount(
            male: lackDict?[LackGender.male.rawValue] ?? 0,
            female: lackDict?[LackGender.female.rawValue] ?? 0,
            unlimited: lackDict?[LackGender.unlimited.rawValue] ?? 0
        )
        let startTime = document.data()[PlayTitle.startTime.rawValue] as? Timestamp
        let endTime = document.data()[PlayTitle.endTime.rawValue] as? Timestamp
        let aPlay = Play(
            id: document.documentID,
            finderId: document.data()[PlayTitle.finderId.rawValue] as? String ?? "no firebase id",
            startTime: startTime?.dateValue() ?? Date(),
            endTime: endTime?.dateValue() ?? Date(),
            place: document.data()[PlayTitle.place.rawValue] as? String ?? "no place",
            price: document.data()[PlayTitle.price.rawValue] as? Int ?? -1,
            type: document.data()[PlayTitle.type.rawValue] as? Int ?? 0,
            levelRange: levelRange,
            lackAmount: lackAmount,
            playerInfo: document.data()[PlayTitle.playerInfo.rawValue] as? [String] ?? [],
            status: document.data()[PlayTitle.status.rawValue] as? Int ?? 0
        )
        return aPlay
    }
    func decodePlayDS(_ document: DocumentSnapshot) -> Play {
        let levelDict = document.data()?[PlayTitle.levelRange.rawValue] as? [String: Int]
        let levelRange = LevelRange(
            setBall: levelDict?[LevelTitle.set.rawValue] ?? 0,
            block: levelDict?[LevelTitle.block.rawValue] ?? 0,
            dig: levelDict?[LevelTitle.dig.rawValue] ?? 0,
            spike: levelDict?[LevelTitle.spike.rawValue] ?? 0,
            sum: levelDict?[LevelTitle.sum.rawValue] ?? 0
        )
        let lackDict = document.data()?[PlayTitle.lackAmount.rawValue] as? [String: Int]
        let lackAmount = LackAmount(
            male: lackDict?[LackGender.male.rawValue] ?? 0,
            female: lackDict?[LackGender.female.rawValue] ?? 0,
            unlimited: lackDict?[LackGender.unlimited.rawValue] ?? 0
        )
        let startTime = document.data()?[PlayTitle.startTime.rawValue] as? Timestamp
        let endTime = document.data()?[PlayTitle.endTime.rawValue] as? Timestamp
        let aPlay = Play(
            id: document.documentID,
            finderId: document.data()?[PlayTitle.finderId.rawValue] as? String ?? "no firebase id",
            startTime: startTime?.dateValue() ?? Date(),
            endTime: endTime?.dateValue() ?? Date(),
            place: document.data()?[PlayTitle.place.rawValue] as? String ?? "no place",
            price: document.data()?[PlayTitle.price.rawValue] as? Int ?? -1,
            type: document.data()?[PlayTitle.type.rawValue] as? Int ?? 0,
            levelRange: levelRange,
            lackAmount: lackAmount,
            playerInfo: document.data()?[PlayTitle.playerInfo.rawValue] as? [String] ?? [],
            status: document.data()?[PlayTitle.status.rawValue] as? Int ?? 0
        )
        return aPlay
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
            blockList: document.data()[UserTitle.blockList.rawValue] as? [String] ?? []
        )
        return aUser
    }

    func appendPlayIdToUserPlayList(_ documentId: String) {
        self.users.whereField(UserTitle.firebaseId.rawValue, isEqualTo: UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) as Any)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for userDocument in querySnapshot!.documents {
                        let myPlayList = userDocument.data()[UserTitle.myPlayList.rawValue] as? [String]
                        if var myPlayList = myPlayList {
                            myPlayList.append(documentId)
                            self.users.document(userDocument.data()[UserTitle.firebaseId.rawValue] as? String ?? "no id").updateData([
                                UserTitle.myPlayList.rawValue: myPlayList
                            ]) { err in
                                if let err = err {
                                    print("Error updating document: \(err)")
                                } else {
                                    print("Document successfully updated")
                                }
                            }
                        }
                    }
                }
            }
    }
}
