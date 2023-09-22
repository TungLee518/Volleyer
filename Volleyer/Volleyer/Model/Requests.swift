//
//  Requests.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/21.
//

import Foundation

struct PlayRequest {
    var requestPlayerList: [Player]
    var requestReceverId: String
    var requestSenderId: String
//     var requestIdStatus: [String: Int]
    var playId: String
    var status: Int = 0
    var createTime: Date
    var id: String = ""
}

enum PlayRequestTitle: String {
    case requestPlayerList = "request_player_list"
    // TODO 拼錯了
    case requestReceiverId = "request_reveiver_id"
    case requestSenderId = "request_sender_id"
//    case requestIdStatus = "requests_Id_Status"
    case playId = "play_id"
    case status = "status"
    case createTime = "create_time"
}

let requestStatus = ["Pending", "Accept", "Deny"]
