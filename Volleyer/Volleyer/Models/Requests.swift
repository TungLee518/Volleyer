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

enum RequestEnum: String {
    case sentARequestToYou = "寄給你打場邀請"
    case requestSentTo = "已寄送邀請給"
    case sentAt = "寄送時間"
    case invite = "邀請"
    case accept = "接受"
    case deny = "拒絕"
    case accepted = "已接受"
    case denied = "已拒絕"
    case cancelRequest = "取消邀請"
    case cancelAddPlay = "取消加場"
    case canceled = "已取消"
}

let requestStatus = ["等待中", "已接受", "已拒絕", "已取消"]
