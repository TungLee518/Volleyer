//
//  DataManager.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/16.
//

import Foundation
import FirebaseFirestore

class DataManager {
    func savePlay(_ play: Play) {
        let plays = Firestore.firestore().collection("plays")
        let document = plays.document()
        let data: [String: Any] = [
            "id": play.id,
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
            "palyer_info": play.playerInfo,
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
}
