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

protocol PlayDataManagerDelegate {
    func manager(_ manager: DataManager, didGet plays: [Play])
}

protocol ThisPlayDataManagerDelegate {
    func manager(_ manager: DataManager, thisPlay play: Play)
}

protocol ThisUserDataManagerDelegate {
    func manager(_ manager: DataManager, thisUser user: User)
}

protocol CompetitionDataManagerDelegate {
    func manager(_ manager: DataManager, didGet competitions: [Competition])
}

// swiftlint:disable force_cast
class DataManager {

    static let sharedDataMenager = DataManager()

    var playDataDelegate: PlayDataManagerDelegate?
    var thisPlayDelegate: ThisPlayDataManagerDelegate?
    var thisUserDelegate: ThisUserDataManagerDelegate?
    var competitionDelegate: CompetitionDataManagerDelegate?
    var playOneDataDelegate: PlayOneDataManagerDelegate?

    let users = Firestore.firestore().collection("users")
    let plays = Firestore.firestore().collection("plays")
    let competitions = Firestore.firestore().collection("competitions")
    let addPlayRQs = Firestore.firestore().collection("add_play_requests")

    let dispatchSemaphore = DispatchSemaphore(value: 1)

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

    func deletePlay(_ play: Play) {
        plays.document(play.id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        for userId in play.playerInfo {
            deletePlayIdToUserPlayList(playId: play.id, userId: userId)
        }
        deletaAllRequestOfPlayId(playId: play.id)
        LKProgressHUD.showSuccess(text: "成功刪除貼文")
    }

    // MARK: get this user's play
    func getThisUserPlays() {
        users.document(UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) ?? "").getDocument {(document, error) in
            if let document = document, document.exists {
                let myPlayList = document.data()?[UserTitle.myPlayList.rawValue] as! [String]
                var playsArray: [Play] = []
                for playId in myPlayList {
                    self.plays.document(playId).getDocument {(document, error) in
                        if let playDocument = document, playDocument.exists {
                            playsArray.append(self.decodePlayDS(playDocument))
                            if playsArray.count == myPlayList.count {
                                self.playDataDelegate?.manager(self, didGet: playsArray)
                            }
                        } else {
                            print("\(playId) Play Document does not exist")
                        }
                    }
                }
            } else {
                print("User Document does not exist")
            }
        }
    }

    // MARK: get publish play
    func getPublishPlay() {
        plays.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var playsArray: [Play] = []
                for document in querySnapshot!.documents {
                    // 之後若是有做只開場不發文就會用到
//                    if document.data()[PlayTitle.status.rawValue] as! Int == 1 {
//                        playsArray.append(self.decodePlay(document))
//                    }
                    // 只顯示 start time 在未來的
                    let now = Date()
                    let startTime = document.data()[PlayTitle.startTime.rawValue] as! Timestamp
                    if startTime.seconds > Int64(now.timeIntervalSince1970) {
                        playsArray.append(self.decodePlay(document))
                    }
                }
                playsArray.sort { $0.startTime < $1.startTime }
                self.playDataDelegate?.manager(self, didGet: playsArray)
            }
        }
    }

    // MARK: get play by id
    func getPlayById(id: String) {
        plays.whereField(PlayTitle.id.rawValue, isEqualTo: id).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let thisPlay = self.decodePlay(document)
                        self.thisPlayDelegate?.manager(self, thisPlay: thisPlay)
                    }
                }
        }
    }

    // MARK: get user by id
    func getUserById(id: String) {
        users.whereField(UserTitle.id.rawValue, isEqualTo: id).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let thisUser = self.decodeUser(document)
                        self.thisUserDelegate?.manager(self, thisUser: thisUser)
                    }
                }
        }
    }

    // MARK: get competitions
    func getCompetion() {
        competitions.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var competitionsArray: [Competition] = []
                for document in querySnapshot!.documents {
                    let aCompetition = Competition(
                        title: document.data()[CompetitionTitle.title.rawValue] as! String,
                        date: document.data()[CompetitionTitle.date.rawValue] as! String,
                        county: document.data()[CompetitionTitle.county.rawValue] as! String,
                        url: document.data()[CompetitionTitle.url.rawValue] as! String,
                        isEnrolling: document.data()[CompetitionTitle.isEnrolling.rawValue] as! Bool
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
        users.whereField(UserTitle.id.rawValue, isEqualTo: id)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion(nil, err) // Pass error to the completion handler
                } else {
                    for userDocument in querySnapshot!.documents {
                        let imageUrl = userDocument.data()[UserTitle.image.rawValue] as! String
                        completion(imageUrl, nil) // Pass the imageUrl to the completion handler
                        return
                    }
                    // If no documents match the query, you can handle that case too
                    completion(nil, nil) // Pass nil for imageUrl and error to indicate no matching document
                }
            }
    }
}

// function used only in DataManager
extension DataManager {
    func decodePlay(_ document: QueryDocumentSnapshot) -> Play {
        let levelDict = document.data()[PlayTitle.levelRange.rawValue] as! [String: Int]
        let levelRange = LevelRange(
            setBall: levelDict[LevelTitle.set.rawValue]!,
            block: levelDict[LevelTitle.block.rawValue]!,
            dig: levelDict[LevelTitle.dig.rawValue]!,
            spike: levelDict[LevelTitle.spike.rawValue]!,
            sum: levelDict[LevelTitle.sum.rawValue]!
        )
        let lackDict = document.data()[PlayTitle.lackAmount.rawValue] as! [String: Int]
        let lackAmount = LackAmount(
            male: lackDict[LackGender.male.rawValue]!,
            female: lackDict[LackGender.female.rawValue]!,
            unlimited: lackDict[LackGender.unlimited.rawValue]!
        )
        let startTime = document.data()[PlayTitle.startTime.rawValue] as! Timestamp
        let endTime = document.data()[PlayTitle.endTime.rawValue] as! Timestamp
        let aPlay = Play(
            id: document.documentID,
            finderId: document.data()[PlayTitle.finderId.rawValue] as! String,
            startTime: startTime.dateValue(),
            endTime: endTime.dateValue(),
            place: document.data()[PlayTitle.place.rawValue] as! String,
            price: document.data()[PlayTitle.price.rawValue] as! Int,
            type: document.data()[PlayTitle.type.rawValue] as! Int,
            levelRange: levelRange,
            lackAmount: lackAmount,
            playerInfo: [],
            status: document.data()[PlayTitle.status.rawValue] as! Int
        )
        return aPlay
    }
    func decodePlayDS(_ document: DocumentSnapshot) -> Play {
        let levelDict = document.data()?[PlayTitle.levelRange.rawValue] as! [String: Int]
        let levelRange = LevelRange(
            setBall: levelDict[LevelTitle.set.rawValue]!,
            block: levelDict[LevelTitle.block.rawValue]!,
            dig: levelDict[LevelTitle.dig.rawValue]!,
            spike: levelDict[LevelTitle.spike.rawValue]!,
            sum: levelDict[LevelTitle.sum.rawValue]!
        )
        let lackDict = document.data()?[PlayTitle.lackAmount.rawValue] as! [String: Int]
        let lackAmount = LackAmount(
            male: lackDict[LackGender.male.rawValue]!,
            female: lackDict[LackGender.female.rawValue]!,
            unlimited: lackDict[LackGender.unlimited.rawValue]!
        )
        let startTime = document.data()?[PlayTitle.startTime.rawValue] as! Timestamp
        let endTime = document.data()?[PlayTitle.endTime.rawValue] as! Timestamp
        let aPlay = Play(
            id: document.documentID,
            finderId: document.data()?[PlayTitle.finderId.rawValue] as! String,
            startTime: startTime.dateValue(),
            endTime: endTime.dateValue(),
            place: document.data()?[PlayTitle.place.rawValue] as! String,
            price: document.data()?[PlayTitle.price.rawValue] as! Int,
            type: document.data()?[PlayTitle.type.rawValue] as! Int,
            levelRange: levelRange,
            lackAmount: lackAmount,
            playerInfo: document.data()?[PlayTitle.playerInfo.rawValue] as! [String],
            status: document.data()?[PlayTitle.status.rawValue] as! Int
        )
        return aPlay
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
            id: document.data()[UserTitle.id.rawValue] as! String,
            email: document.data()[UserTitle.email.rawValue] as! String,
            gender: document.data()[UserTitle.gender.rawValue] as! Int,
            name: document.data()[UserTitle.name.rawValue] as! String,
            level: levelRange,
            image: document.data()[UserTitle.image.rawValue] as! String
        )
        return aUser
    }

    func appendPlayIdToUserPlayList(_ playId: String, userId: String) {
        self.users.whereField(UserTitle.id.rawValue, isEqualTo: userId)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for userDocument in querySnapshot!.documents {
                        var myPlayList = userDocument.data()[UserTitle.myPlayList.rawValue] as! [String]
                        print("\(userDocument.documentID) => \(userDocument.data())")
                        myPlayList.append(playId)
                        self.users.document(userDocument.data()[UserTitle.firebaseId.rawValue] as! String).updateData([
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

    func deletePlayIdToUserPlayList(playId: String, userId: String) {
        self.users.whereField(UserTitle.id.rawValue, isEqualTo: userId)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for userDocument in querySnapshot!.documents {
                        var myPlayList = userDocument.data()[UserTitle.myPlayList.rawValue] as! [String]
                        print("\(userDocument.documentID) => \(userDocument.data())")
                        if let deleteIndex = myPlayList.firstIndex(of: playId) {
                            myPlayList.remove(at: deleteIndex)
                        }
                        self.users.document(userDocument.data()[UserTitle.firebaseId.rawValue] as! String).updateData([
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

    func appendUserIdToPlayPlayerInfo(userId: String, playId: String) {
        plays.document(playId).getDocument { (document, error) in
            if let document = document, document.exists {
                var playInfo = document.data()?[PlayTitle.playerInfo.rawValue] as! [String]
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
            } else {
                print("Document does not exist")
            }
        }
    }
    func deleteUserIdToPlayPlayerInfo(userId: String, playId: String) {
        plays.document(playId).getDocument { (document, error) in
            if let document = document, document.exists {
                var playInfo = document.data()?[PlayTitle.playerInfo.rawValue] as! [String]
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
                    self.addPlayRQs.document(thisRequestId).delete() { err in
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
// swiftlint:enable force_cast
