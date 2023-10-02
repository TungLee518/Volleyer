//
//  Play.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/16.
//

import Foundation

struct Play {
    var id: String = ""
    var finderId: String
    var startTime, endTime: Date
    var place: String
    var price, type: Int
    var levelRange: LevelRange
    var lackAmount: LackAmount
    var playerInfo: [String]
    var status: Int
    var levelFilter: Bool = false
    var followerListId: [String] = []
}

struct LevelRange {
    var setBall: Int
    var block: Int
    var dig: Int
    var spike: Int
    var sum: Int
}

struct LackAmount {
    var male: Int
    var female: Int
    var unlimited: Int
}

enum EstablishPageEnum: String {
    case publish = "發文"
    case deletePost = "刪除貼文"
    case save = "儲存"
    case level = "程度"
}

enum AddPlayPageEnum: String {
    case sendRequest = "我要加"
    case addPlayer = "新增隊友"
    case level = "程度"
}

enum PlayTitle: String {
    case id = "id"
    case finderId = "finder_id"
    case createTime = "create_time"
    case startTime = "start_time"
    case endTime = "end_time"
    case place = "place"
    case price = "price"
    case type = "type"
    case levelRange = "level_range"
    case lackAmount = "lack_amount"
    case playerInfo = "player_info"
    case status = "status"
    case levelFilter = "level_filter"
    case followerListId = "follower_list_id"
}

enum LevelTitle: String {
    case set = "set"
    case block = "block"
    case dig = "dig"
    case spike = "spike"
    case sum = "sum"
}

enum LackGender: String {
    case male = "male"
    case female = "female"
    case unlimited = "unlimited"
}
