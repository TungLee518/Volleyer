//
//  DataManager.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/16.
//

import Foundation
import FirebaseFirestore
import FirebaseCore
import FirebaseStorage

protocol PlayDataManagerDelegate: AnyObject {
    func manager(_ manager: FinderDataManager, didGet plays: [Play])
}

protocol ThisPlayDataManagerDelegate: AnyObject {
    func manager(_ manager: FinderDataManager, thisPlay play: Play)
}

protocol ThisUserDataManagerDelegate: AnyObject {
    func manager(_ manager: FinderDataManager, thisUser user: User)
}

protocol CompetitionDataManagerDelegate: AnyObject {
    func manager(_ manager: FinderDataManager, didGet competitions: [Competition])
}

class FinderDataManager {

    static let sharedDataMenager = FinderDataManager()

    weak var playDataDelegate: PlayDataManagerDelegate?
    weak var thisPlayDelegate: ThisPlayDataManagerDelegate?
    weak var thisUserDelegate: ThisUserDataManagerDelegate?
    weak var competitionDelegate: CompetitionDataManagerDelegate?
    weak var playOneDataDelegate: PlayOneDataManagerDelegate?

    let users = Firestore.firestore().collection("users")
    let plays = Firestore.firestore().collection("plays")
    let competitions = Firestore.firestore().collection("competitions")
    let addPlayRQs = Firestore.firestore().collection("requests")

    // MARK: save play
    func savePlay(_ play: Play) {
        let document = plays.document()
        let data: [String: Any] = [
            "id": document.documentID,
            "finder_id": play.finderId,
            "create_time": Date(),
            "start_time": play.startTime,
            "end_time": play.endTime,
            "place": play.place,
            "price": play.price,
            "type": play.type,
            "level_range": [
                "set": play.levelRange.setBall,
                "block": play.levelRange.block,
                "dig": play.levelRange.dig,
                "spike": play.levelRange.spike,
                "sum": play.levelRange.sum
            ],
            "lack_amount": [
                "male": play.lackAmount.male,
                "female": play.lackAmount.female,
                "unlimited": play.lackAmount.unlimited
            ],
            "player_info": [play.finderId], // 改成 user id
            "status": play.status,
            "level_filter": play.levelFilter,
            "follower_list_id": play.followerListId
        ]
        document.setData(data) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(document.documentID)")
                // finder must have to go to that play
                self.appendPlayIdToUserPlayList(document.documentID, userId: play.finderId)
            }
        }
        print("add data")
    }

    // MARK: update play
    func updatePlay(_ play: Play) {

        plays.document(play.id).updateData([
            "start_time": play.startTime,
            "end_time": play.endTime,
            "place": play.place,
            "price": play.price,
            "type": play.type,
            "level_range": [
                "set": play.levelRange.setBall,
                "block": play.levelRange.block,
                "dig": play.levelRange.dig,
                "spike": play.levelRange.spike,
                "sum": play.levelRange.sum
            ],
            "lack_amount": [
                "male": play.lackAmount.male,
                "female": play.lackAmount.female,
                "unlimited": play.lackAmount.unlimited
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }

    func deletePlay(_ play: Play, completion: @escaping (Error?) -> Void) {
        plays.document(play.id).delete { err in
            if let err = err {
                print("Error removing document: \(err)")
                completion(err)
            } else {
                print("Document successfully removed!")
                completion(nil)
            }
        }
        print(play.playerInfo)
        for userId in play.playerInfo {
            deletePlayIdToUserPlayList(playId: play.id, userId: userId)
        }
        deletaAllRequestOfPlayId(playId: play.id)
    }

    // MARK: get this user's play
    func getThisUserPlays() {
        users.document(UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "").getDocument {(document, error) in
            if let document = document, document.exists {
                let myPlayList = document.data()?[UserTitle.myPlayList.rawValue] as? [String]
                if let myPlayList = myPlayList {
                    if myPlayList.count == 0 {
                        self.playDataDelegate?.manager(self, didGet: [])
                    } else {
                        var playsArray: [Play] = []
                        for playId in myPlayList {
                            self.plays.document(playId).getDocument {(document, error) in
                                if let playDocument = document, playDocument.exists {
                                    playsArray.append(self.decodePlayDS(playDocument))
                                    if playsArray.count == myPlayList.count {
                                        self.playDataDelegate?.manager(self, didGet: playsArray)
                                    }
                                } else if let error = error {
                                    print("getPlayById error:", error)
                                } else {
                                    print("\(playId) Play Document does not exist")
                                }
                            }
                        }
                    }
                }
            } else if let error = error {
                print("getThisUserPlays error:", error)
            } else {
                print("User Document does not exist")
            }
        }
    }

    // MARK: get publish play
    func getPublishPlay() {
        users.document(UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "no my id").getDocument { (document, error) in
            if let document = document, document.exists {

                let myBlockList = document.data()?[UserTitle.blockList.rawValue] as? [String] ?? []

                self.plays.getDocuments { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        var playsArray: [Play] = []
                        var numOfDocument = 0
                        for document in querySnapshot!.documents {

                            // 之後若是有做只開場不發文就會用到
//                            if document.data()[PlayTitle.status.rawValue] as? Int == 1 {
//                                playsArray.append(self.decodePlay(document))
//                            }
                            let now = Date()
                            let startTime = document.data()[PlayTitle.startTime.rawValue] as? Timestamp
                            // 只顯示 start time 在未來的
                            if let startTime = startTime {
                                if startTime.seconds > Int64(now.timeIntervalSince1970) {
                                    let finderId = document.data()[PlayTitle.finderId.rawValue] as? String
                                    // 只顯示不再封鎖名單的貼文
                                    if myBlockList.firstIndex(of: finderId ?? "") == nil {
                                        playsArray.append(self.decodePlay(document))
                                        numOfDocument += 1
                                    } else {
                                        numOfDocument += 1
                                    }
                                    if numOfDocument == querySnapshot!.documents.count {
                                        playsArray.sort { $0.startTime < $1.startTime }
                                        self.playDataDelegate?.manager(self, didGet: playsArray)
                                    }
                                } else {
                                    numOfDocument += 1
                                    if numOfDocument == querySnapshot!.documents.count {
                                        playsArray.sort { $0.startTime < $1.startTime }
                                        self.playDataDelegate?.manager(self, didGet: playsArray)
                                    }
                                }
                            }
                        }
                    }
                }
            } else if let error = error {
                print("getPublishPlay error:", error)
            } else {
                print("User Document does not exist")
            }
        }
    }

    // MARK: get play by id
    func getPlayById(id: String, completion: @escaping (Play?, Error?) -> Void) {
        plays.document(id).getDocument { (document, error) in
            if let document = document, document.exists {
                let thisPlay = self.decodePlayDS(document)
                completion(thisPlay, nil)
            } else {
                print("Document does not exist")
                completion(nil, error)
            }
        }
    }

    // MARK: get user by id
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

    func getPlayersData(playersId: [String], completion: @escaping ([User]?, Error?) -> Void) {
        var players: [User] = []
        for playerId in playersId {
            getUserByFirebaseId(id: playerId) { gotUser, err in
                if let gotUser = gotUser {
                    players.append(gotUser)
                    if players.count == playersId.count {
                        players.sort { $0.gender < $1.gender }
                        completion(players, nil)
                    }
                } else if let err = err {
                    print("getUserByFirebaseId fail:", err)
                    completion(nil, err)
                }
            }
        }
    }

    // MARK: get competitions
    func getCompetion() {
        competitions.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var competitionsArray: [Competition] = []
                for document in querySnapshot!.documents {
                    let aCompetition = Competition(
                        title: document.data()[CompetitionTitle.title.rawValue] as? String ?? "Internet Error",
                        date: document.data()[CompetitionTitle.date.rawValue] as? String ?? "Internet Error",
                        county: document.data()[CompetitionTitle.county.rawValue] as? String ?? "Internet Error",
                        url: document.data()[CompetitionTitle.url.rawValue] as? String ?? "Internet Error",
                        isEnrolling: document.data()[CompetitionTitle.isEnrolling.rawValue] as? Bool ?? false
                    )
                    competitionsArray.append(aCompetition)
                }
                competitionsArray.sort { $0.date > $1.date }
                print(competitionsArray)
                self.competitionDelegate?.manager(self, didGet: competitionsArray)
            }
        }
    }

    func getImageFromUserId(id: String, completion: @escaping (String?, Error?) -> Void) {
        users.whereField(UserTitle.firebaseId.rawValue, isEqualTo: id)
            .getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion(nil, err)
                } else {
                    for userDocument in querySnapshot!.documents {
                        let imageUrl = userDocument.data()[UserTitle.image.rawValue] as? String
                        completion(imageUrl, nil)
                        return
                    }
                    completion(nil, nil)
                }
            }
    }
}

// function used only in DataManager
extension FinderDataManager {
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

    func appendPlayIdToUserPlayList(_ playId: String, userId: String) {
        self.users.whereField(UserTitle.firebaseId.rawValue, isEqualTo: userId)
            .getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for userDocument in querySnapshot!.documents {
                        let myPlayList = userDocument.data()[UserTitle.myPlayList.rawValue] as? [String]
                        if var myPlayList = myPlayList {
                            myPlayList.append(playId)
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

    func deletePlayIdToUserPlayList(playId: String, userId: String) {
        self.users.whereField(UserTitle.firebaseId.rawValue, isEqualTo: userId)
            .getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for userDocument in querySnapshot!.documents {
                        let myPlayList = userDocument.data()[UserTitle.myPlayList.rawValue] as? [String]
                        if var myPlayList = myPlayList {
                            if let deleteIndex = myPlayList.firstIndex(of: playId) {
                                myPlayList.remove(at: deleteIndex)
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

    func appendUserIdToPlayPlayerInfo(userId: String, playId: String) {
        plays.document(playId).getDocument { (document, error) in
            if let document = document, document.exists {
                let playInfo = document.data()?[PlayTitle.playerInfo.rawValue] as? [String]
                if var playInfo = playInfo {
                    playInfo.append(userId)
                    self.plays.document(playId).updateData([
                        PlayTitle.playerInfo.rawValue: playInfo
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                        }
                    }
                }
            } else if let error = error {
                print("appendUserIdToPlayPlayerInfo error:", error)
            } else {
                print("Document does not exist")
            }
        }
    }
    func deleteUserIdToPlayPlayerInfo(userId: String, playId: String) {
        plays.document(playId).getDocument { (document, error) in
            if let document = document, document.exists {
                let playInfo = document.data()?[PlayTitle.playerInfo.rawValue] as? [String]
                if var playInfo = playInfo {
                    if let deleteIndex = playInfo.firstIndex(of: userId) {
                        playInfo.remove(at: deleteIndex)
                    }
                    self.plays.document(playId).updateData([
                        PlayTitle.playerInfo.rawValue: playInfo
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                        }
                    }
                }
            } else if let error = error {
                print("deleteUserIdToPlayPlayerInfo error:", error)
            } else {
                print("Document does not exist")
            }
        }
    }

    func deletaAllRequestOfPlayId(playId: String) {
        addPlayRQs.whereField("play_id", isEqualTo: playId).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let thisRequestId = document.documentID
                    self.addPlayRQs.document(thisRequestId).delete { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            print("Request successfully removed!")
                        }
                    }
                }
            }
        }
    }
}
