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

protocol RequestsDataManagerDelegate: AnyObject {
    func manager(_ manager: RequestDataManager, iReceive playRequests: [PlayRequest])
    func manager(_ manager: RequestDataManager, iSent playRequests: [PlayRequest])
}

class RequestDataManager {

    static let sharedDataMenager = RequestDataManager()

    weak var playRequestDelegate: RequestsDataManagerDelegate?

    let users = Firestore.firestore().collection("users")
    let plays = Firestore.firestore().collection("plays")
    let addPlayRQs = Firestore.firestore().collection("requests")

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
            PlayRequestTitle.requestSenderId.rawValue: UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) as Any,
            PlayRequestTitle.requestReceiverId.rawValue: play.finderId,
            PlayRequestTitle.playId.rawValue: play.id,
            PlayRequestTitle.status.rawValue: 0,
            PlayRequestTitle.requestPlayerList.rawValue: [String](),
            PlayRequestTitle.createTime.rawValue: Date()
        ]
        addPlayRQs.whereField(PlayRequestTitle.playId.rawValue, isEqualTo: play.id).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if querySnapshot!.documents.count == 0 { // 這個場沒有被邀請過
                    document.setData(data) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(document.documentID)")
                        }
                    }
                    print("add data")
                    LKProgressHUD.showSuccess(text: AlertTitile.requestSent.rawValue)
                } else { // 這個場有被邀請過
                    var canSendRequest = true
                    for document in querySnapshot!.documents {
                        let theSender = document.data()[PlayRequestTitle.requestSenderId.rawValue] as? String
                        let theReceiver = document.data()[PlayRequestTitle.requestReceiverId.rawValue] as? String
                        if theSender == UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) && theReceiver == play.finderId {
                            canSendRequest = false
                            break
                        }
                    }
                    if canSendRequest {
                        document.setData(data) { err in
                            if let err = err {
                                print("Error adding document: \(err)")
                            } else {
                                print("Document added with ID: \(document.documentID)")
                            }
                        }
                        print("add data")
                        LKProgressHUD.showSuccess(text: AlertTitile.requestSent.rawValue)
                    } else {
                        LKProgressHUD.showFailure(text: AlertTitile.requestAlreadyExist.rawValue)
                    }
                }
            }
        }
    }

    // MARK: get play requests
    func getPlayRequests() {
        addPlayRQs.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var playRequestsReceiveArray: [PlayRequest] = []
                var playRequestsSentArray: [PlayRequest] = []
                for document in querySnapshot!.documents {
//                    let requestPlayerList =
                    var requestPlayerArray = [Player]()
                    if let requestPlayerList = document.data()[PlayRequestTitle.requestPlayerList.rawValue] as? [[String: String]] {
                        for player in requestPlayerList {
                            requestPlayerArray.append(Player(name: player["Name"]!, gender: player["Gender"]!))
                        }
                        let createdTime = document.data()[PlayRequestTitle.createTime.rawValue] as? Timestamp
                        let aPlayRequest = PlayRequest(
                            requestPlayerList: requestPlayerArray,
                            requestReceverId: document.data()[PlayRequestTitle.requestReceiverId.rawValue] as? String ?? "no receiver id",
                            requestSenderId: document.data()[PlayRequestTitle.requestSenderId.rawValue] as? String ?? "no sender id",
                            playId: document.data()[PlayRequestTitle.playId.rawValue] as? String ?? "no play id",
                            status: document.data()[PlayRequestTitle.status.rawValue] as? Int ?? 400,
                            createTime: createdTime?.dateValue() ?? Date(),
                            id: document.documentID
                        )
                        if aPlayRequest.requestReceverId == UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) {
                            playRequestsReceiveArray.append(aPlayRequest)
                        } else if aPlayRequest.requestSenderId == UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) {
                            playRequestsSentArray.append(aPlayRequest)
                        }
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
        addPlayRQs.whereField(PlayRequestTitle.requestReceiverId.rawValue, isEqualTo: UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) as Any).addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if diff.type == .added {
                    print("New request: \(diff.document.data())")
                    if let launchTime = UserDefaults.standard.value(forKey: launchAppDate) as? Date,
                       let firebaseTime = diff.document.data()["create_time"] as? Timestamp {
                        if Int32(launchTime.timeIntervalSince1970) < firebaseTime.seconds {
                            NotificationManager.notifyDelegate.successNotificationContent(id: diff.document.data()["request_sender_id"] as? String ?? "no sender id")
                        }
                    }
                }
                if diff.type == .modified {
                    print("Modified request: \(diff.document.data())")
                }
                if diff.type == .removed {
                    print("Removed request: \(diff.document.data())")
                }
            }
        }
        addPlayRQs.whereField(PlayRequestTitle.requestSenderId.rawValue, isEqualTo: UserDefaults.standard.string(forKey: UserTitle.firebaseId.rawValue) as Any).addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if diff.type == .added {
                    print("New request: \(diff.document.data())")
                }
                if diff.type == .modified {
                    print("Modified request: \(diff.document.data())")
                    if let requestPlayerList = diff.document.data()[PlayRequestTitle.requestPlayerList.rawValue] as? [[String: String]] {
                        var requestPlayerArray = [Player]()
                        for player in requestPlayerList {
                            requestPlayerArray.append(Player(name: player["Name"] ?? "name error", gender: player["Gender"] ?? "gender error"))
                        }
                        let createdTime = diff.document.data()[PlayRequestTitle.createTime.rawValue] as? Timestamp
                        let aPlayRequest = PlayRequest(
                            requestPlayerList: requestPlayerArray,
                            requestReceverId: diff.document.data()[PlayRequestTitle.requestReceiverId.rawValue] as? String ?? "no receiver id",
                            requestSenderId: diff.document.data()[PlayRequestTitle.requestSenderId.rawValue] as? String ?? "no sender id",
                            playId: diff.document.data()[PlayRequestTitle.playId.rawValue] as? String ?? "no play id",
                            status: diff.document.data()[PlayRequestTitle.status.rawValue] as? Int ?? 400,
                            createTime: createdTime?.dateValue() ?? Date(),
                            id: diff.document.documentID
                        )
                        self.updateRequestsSentTableView?(aPlayRequest)
                    }
                }
                if diff.type == .removed {
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

    func cancelRequest(_ request: PlayRequest) {
        addPlayRQs.document(request.id).updateData([
            PlayRequestTitle.status.rawValue: -1
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                if request.status == 99 {
                    self.deletePlayIdToUserPlayList(playId: request.playId, userId: request.requestSenderId)
                    self.deleteUserIdToPlayPlayerInfo(userId: request.requestSenderId, playId: request.playId)
                    LKProgressHUD.showSuccess(text: AlertTitile.successCancelRequest.rawValue)
                }
            }
        }
    }
}

// function used only in DataManager
extension RequestDataManager {
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

    func appendPlayIdToUserPlayList(_ playId: String, userId: String) {
        self.users.whereField(UserTitle.firebaseId.rawValue, isEqualTo: userId)
            .getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for userDocument in querySnapshot!.documents {
                        if var myPlayList = userDocument.data()[UserTitle.myPlayList.rawValue] as? [String] {
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
                        if var myPlayList = userDocument.data()[UserTitle.myPlayList.rawValue] as? [String] {
                            if let deleteIndex = myPlayList.firstIndex(of: playId) {
                                myPlayList.remove(at: deleteIndex)
                            }
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

    func appendUserIdToPlayPlayerInfo(userId: String, playId: String) {
        plays.document(playId).getDocument { (document, error) in
            if let document = document, document.exists {
                if var playInfo = document.data()?[PlayTitle.playerInfo.rawValue] as? [String] {
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
                if var playInfo = document.data()?[PlayTitle.playerInfo.rawValue] as? [String] {
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
