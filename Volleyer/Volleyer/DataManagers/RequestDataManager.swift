//
//  RequestDataManager.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/2.
//

import Foundation
import FirebaseFirestore
import FirebaseCore
import FirebaseStorage

protocol RequestsDataManagerDelegate {
    func manager(_ manager: RequestDataManager, iReceive playRequests: [PlayRequest])
    func manager(_ manager: RequestDataManager, iSent playRequests: [PlayRequest])
}

// swiftlint:disable force_cast
class RequestDataManager {

    static let sharedDataMenager = RequestDataManager()

    var playRequestDelegate: RequestsDataManagerDelegate?

    let users = Firestore.firestore().collection("users")
    let plays = Firestore.firestore().collection("plays")
    let addPlayRQs = Firestore.firestore().collection("add_play_requests")

    var updateRequestsSentTableView: ((PlayRequest) -> Void)?

    // MARK: save request
    func saveRequest(_ play: Play, playerList: [Player]) {
        let document = addPlayRQs.document()
        var playerDictList: [[String: String]] = []
        for player in playerList {
            let playerDict = ["Name": player.name, "Gender": player.gender]
            playerDictList.append(playerDict)
        }
        let data: [String: Any] = [
            PlayRequestTitle.requestSenderId.rawValue: UserDefaults.standard.string(forKey: UserTitle.id.rawValue) as Any,
            PlayRequestTitle.requestReceiverId.rawValue: play.finderId,
            PlayRequestTitle.playId.rawValue: play.id,
            PlayRequestTitle.status.rawValue: 0,
            PlayRequestTitle.requestPlayerList.rawValue: playerDictList,
            PlayRequestTitle.createTime.rawValue: Date()
        ]
        document.setData(data) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(document.documentID)")
            }
        }
        print("add data")
    }

    // MARK: get play requests
    func getPlayRequests() {
        addPlayRQs.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var playRequestsReceiveArray: [PlayRequest] = []
                var playRequestsSentArray: [PlayRequest] = []
                for document in querySnapshot!.documents {
                    let requestPlayerList = document.data()[PlayRequestTitle.requestPlayerList.rawValue] as! [[String: String]]
                    var requestPlayerArray = [Player]()
                    for player in requestPlayerList {
                        requestPlayerArray.append(Player(name: player["Name"]!, gender: player["Gender"]!))
                    }
                    let createdTime = document.data()[PlayRequestTitle.createTime.rawValue] as! Timestamp
                    let aPlayRequest = PlayRequest(
                        requestPlayerList: requestPlayerArray,
                        requestReceverId: document.data()[PlayRequestTitle.requestReceiverId.rawValue] as! String,
                        requestSenderId: document.data()[PlayRequestTitle.requestSenderId.rawValue] as! String,
                        playId: document.data()[PlayRequestTitle.playId.rawValue] as! String,
                        status: document.data()[PlayRequestTitle.status.rawValue] as! Int,
                        createTime: createdTime.dateValue(),
                        id: document.documentID
                    )
                    if aPlayRequest.requestReceverId == UserDefaults.standard.string(forKey: UserTitle.id.rawValue) {
                        playRequestsReceiveArray.append(aPlayRequest)
                    } else if aPlayRequest.requestSenderId == UserDefaults.standard.string(forKey: UserTitle.id.rawValue) {
                        playRequestsSentArray.append(aPlayRequest)
                    }
                }
                playRequestsReceiveArray.sort { $0.createTime < $1.createTime }
                playRequestsSentArray.sort { $0.createTime < $1.createTime }
                self.playRequestDelegate?.manager(self, iReceive: playRequestsReceiveArray)
                self.playRequestDelegate?.manager(self, iSent: playRequestsSentArray)
            }
        }
    }

    // MARK: listen play requests
    func listenPlayRequests() {
        // bug
        addPlayRQs.whereField(PlayRequestTitle.requestReceiverId.rawValue, isEqualTo: UserDefaults.standard.string(forKey: UserTitle.id.rawValue) as Any).addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    print("New request: \(diff.document.data())")
                    let launchTime = UserDefaults.standard.value(forKey: launchAppDate) as! Date
                    let firebaseTime = diff.document.data()["create_time"] as! Timestamp
                    if Int32(launchTime.timeIntervalSince1970) < firebaseTime.seconds {
                        NotificationManager.notifyDelegate.successNotificationContent(id: diff.document.data()["request_sender_id"] as! String)
                    }
                }
                if (diff.type == .modified) {
                    print("Modified request: \(diff.document.data())")
                }
                if (diff.type == .removed) {
                    print("Removed request: \(diff.document.data())")
                }
            }
        }
        addPlayRQs.whereField(PlayRequestTitle.requestSenderId.rawValue, isEqualTo: UserDefaults.standard.string(forKey: UserTitle.id.rawValue) as Any).addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    print("New request: \(diff.document.data())")
                }
                if (diff.type == .modified) {
                    print("Modified request: \(diff.document.data())")
                    let requestPlayerList = diff.document.data()[PlayRequestTitle.requestPlayerList.rawValue] as! [[String: String]]
                    var requestPlayerArray = [Player]()
                    for player in requestPlayerList {
                        requestPlayerArray.append(Player(name: player["Name"]!, gender: player["Gender"]!))
                    }
                    let createdTime = diff.document.data()[PlayRequestTitle.createTime.rawValue] as! Timestamp
                    let aPlayRequest = PlayRequest(
                        requestPlayerList: requestPlayerArray,
                        requestReceverId: diff.document.data()[PlayRequestTitle.requestReceiverId.rawValue] as! String,
                        requestSenderId: diff.document.data()[PlayRequestTitle.requestSenderId.rawValue] as! String,
                        playId: diff.document.data()[PlayRequestTitle.playId.rawValue] as! String,
                        status: diff.document.data()[PlayRequestTitle.status.rawValue] as! Int,
                        createTime: createdTime.dateValue(),
                        id: diff.document.documentID
                    )
                    self.updateRequestsSentTableView?(aPlayRequest)
                    // if accept, add playId to myPlayList
                    if aPlayRequest.status == 99 {
//                        self.appendPlayIdToUserPlayList(aPlayRequest.playId)
//                        self.appendUserIdToPlayPlayerInfo(userId: aPlayRequest.requestSenderId, playId: aPlayRequest.playId)
                    }
                }
                if (diff.type == .removed) {
                    print("Removed request: \(diff.document.data())")
                }
            }
        }
    }

    // MARK: update request
    func updateRequest(_ request: PlayRequest, status: Int) {
        addPlayRQs.document(request.id).updateData([
            PlayRequestTitle.status.rawValue: status
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Request Document successfully updated")
                if status == 99 {
                    self.appendPlayIdToUserPlayList(request.playId, userId: request.requestSenderId)
                    self.appendUserIdToPlayPlayerInfo(userId: request.requestSenderId, playId: request.playId)
                }
            }
        }
    }
}

// function used only in DataManager
extension RequestDataManager {
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
