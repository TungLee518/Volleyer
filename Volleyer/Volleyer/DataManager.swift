//
//  DataManager.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/16.
//

import Foundation
import FirebaseFirestore
import FirebaseCore

protocol PlayDataManagerDelegate {
    func manager(_ manager: DataManager, didGet plays: [Play])
}

protocol CompetitionDataManagerDelegate {
    func manager(_ manager: DataManager, didGet competitions: [Competition])
}

protocol RequestsDataManagerDelegate {
    func manager(_ manager: DataManager, iReceive playRequests: [PlayRequest])
    func manager(_ manager: DataManager, iSent playRequests: [PlayRequest])
}

// swiftlint:disable force_cast
class DataManager {

    static let sharedDataMenager = DataManager()

    var delegate: PlayDataManagerDelegate?
    var competitionDelegate: CompetitionDataManagerDelegate?
    var playRequestDelegate: RequestsDataManagerDelegate?

    let plays = Firestore.firestore().collection("plays")
    let competitions = Firestore.firestore().collection("competitions")
    let addPlayRQs = Firestore.firestore().collection("add_play_requests")
    
    var updateRequestsSentTableView: ((PlayRequest) -> Void)?

    func savePlay(_ play: Play) {
        let document = plays.document()
        var playerDictList: [[String: String]] = []
        for player in play.playerInfo {
            let playerDict = ["Name": player.name, "Gender": player.gender]
            playerDictList.append(playerDict)
        }
        let data: [String: Any] = [
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
            "palyer_info": playerDictList,
            "status": play.status,
            "level_filter": play.levelFilter,
            "follower_list_id": play.followerListId
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

    func getPlay() {
        plays.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var playsArray: [Play] = []
                for document in querySnapshot!.documents {
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
                    playsArray.append(aPlay)
                }
                // playsArray.sort { $0.time > $1.time }
                self.delegate?.manager(self, didGet: playsArray)
            }
        }
    }

    func getPublishPlay() {
        plays.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var playsArray: [Play] = []
                for document in querySnapshot!.documents {
                    if document.data()[PlayTitle.status.rawValue] as! Int == 1 {
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
                        playsArray.append(aPlay)
                    }
                }
                playsArray.sort { $0.startTime < $1.startTime }
                self.delegate?.manager(self, didGet: playsArray)
            }
        }
    }

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
                        url: document.data()[CompetitionTitle.url.rawValue] as! String
                    )
                    competitionsArray.append(aCompetition)
                }
                competitionsArray.sort { $0.date > $1.date }
                print(competitionsArray)
                self.competitionDelegate?.manager(self, didGet: competitionsArray)
            }
        }
    }

    func saveRequest(_ play: Play, playerList: [Player]) {
        let document = addPlayRQs.document()
        var playerDictList: [[String: String]] = []
        for player in playerList {
            let playerDict = ["Name": player.name, "Gender": player.gender]
            playerDictList.append(playerDict)
        }
        let data: [String: Any] = [
            PlayRequestTitle.requestSenderId.rawValue: UserDefaults.standard.string(forKey: User.id.rawValue) as Any,
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
                    if aPlayRequest.requestReceverId == UserDefaults.standard.string(forKey: User.id.rawValue) {
                        playRequestsReceiveArray.append(aPlayRequest)
                    } else if aPlayRequest.requestSenderId == UserDefaults.standard.string(forKey: User.id.rawValue) {
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

    func listenPlayRequests() {
        addPlayRQs.whereField(PlayRequestTitle.requestReceiverId.rawValue, isEqualTo: UserDefaults.standard.string(forKey: User.id.rawValue) as Any).addSnapshotListener { querySnapshot, error in
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
        addPlayRQs.whereField(PlayRequestTitle.requestSenderId.rawValue, isEqualTo: UserDefaults.standard.string(forKey: User.id.rawValue) as Any).addSnapshotListener { querySnapshot, error in
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
                }
                if (diff.type == .removed) {
                    print("Removed request: \(diff.document.data())")
                }
            }
        }
    }
    
    func updateRequest(_ request: PlayRequest, status: Int) {
        addPlayRQs.document(request.id).updateData([
            PlayRequestTitle.status.rawValue: status
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Request Document successfully updated")
            }
        }
    }
}
// swiftlint:enable force_cast
