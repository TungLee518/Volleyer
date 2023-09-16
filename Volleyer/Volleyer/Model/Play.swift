//
//  Play.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/16.
//

import Foundation

struct Play {
    var id: String
    var startTime, endTime: Date
    var place: String
    var price, type: Int
    var levelRange: LevelRange
    var lackAmount: LackAmount
    var playerInfo: [Player]
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
