//
//  User.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/19.
//

import Foundation

enum UserTitle: String {
    case firebaseId = "firebase_id"
    case loginWay = "login_way"
    case id = "id"
    case userIdentifier = "user_identifier"
    case email = "email"
    case name = "name"
    case gender = "gender"
    case level = "self_level"
    case myPlayList = "my_play_list"
    case image = "image"
    case blockList = "block_list"
    case status = "status"
}

struct User {
    var firebaseId: String = ""
    var loginWay: Int = -1
    var userIdentifier: String = ""
    var id: String
    var email: String
    var gender: Int
    var name: String
    var level: LevelRange = LevelRange(setBall: 4, block: 4, dig: 4, spike: 4, sum: 4)
    var myPlayList: [String] = [] // play id
    var image: String = "https://firebasestorage.googleapis.com/v0/b/volleyer-a15b6.appspot.com/o/defaults%2Fplaceholder.png?alt=media&token=d686707b-7b55-4291-8d67-c809c14f9528&_gl=1*gmtbad*_ga*MTE1Njk3OTU3Ny4xNjkxNjU1MTk0*_ga_CW55HF8NVT*MTY5NjA2MDc1Ni45Mi4xLjE2OTYwNjEwMTguNTQuMC4w"
    var playN: Int = 0
    var blockList: [String] = [] // user id
    var status: Int = 0
}

enum Level: String {
    case setBall = "SetBall"
    case block = "Block"
    case dig = "Dig"
    case spike = "Spike"
    case sum = "Sum"
}

let genderList = ["男", "女"]
let launchAppDate = "launchAppDate"
let placeholderImage = "https://firebasestorage.googleapis.com/v0/b/volleyer-a15b6.appspot.com/o/defaults%2Fplaceholder.png?alt=media&token=d686707b-7b55-4291-8d67-c809c14f9528&_gl=1*gmtbad*_ga*MTE1Njk3OTU3Ny4xNjkxNjU1MTk0*_ga_CW55HF8NVT*MTY5NjA2MDc1Ni45Mi4xLjE2OTYwNjEwMTguNTQuMC4w"
let loginWay = ["Fake", "Apple", "Instagram"]
let addUsers: [User] = [
    User(id: "May", email: "May", gender: 1, name: "May", level:
            LevelRange(setBall: 1, block: 2, dig: 0, spike: 1, sum: 1)),
    User(id: "Emma", email: "Emma", gender: 1, name: "Emma", level:
            LevelRange(setBall: 2, block: 1, dig: 0, spike: 1, sum: 1)),
    User(id: "Olivia", email: "Olivia", gender: 1, name: "Olivia", level:
            LevelRange(setBall: 3, block: 2, dig: 3, spike: 2, sum: 3)),
    User(id: "Sophia", email: "Sophia", gender: 1, name: "Sophia", level:
            LevelRange(setBall: 3, block: 3, dig: 3, spike: 3, sum: 3)),
    User(id: "Ava", email: "Ava", gender: 1, name: "Ava", level:
            LevelRange(setBall: 2, block: 2, dig: 2, spike: 2, sum: 2)),
    User(id: "Mia", email: "Mia", gender: 1, name: "Mia", level:
            LevelRange(setBall: 3, block: 2, dig: 2, spike: 1, sum: 1)),
    User(id: "Isabella", email: "Isabella", gender: 1, name: "Isabella", level:
            LevelRange(setBall: 3, block: 0, dig: 3, spike: 0, sum: 2)), // 攻擊手
    User(id: "Amelia", email: "Amelia", gender: 1, name: "Amelia", level:
            LevelRange(setBall: 1, block: 3, dig: 0, spike: 3, sum: 1)), // 自由球員
    User(id: "Doris", email: "Doris", gender: 1, name: "Doris", level:
            LevelRange(setBall: 2, block: 2, dig: 2, spike: 2, sum: 2)),
    User(id: "Harper", email: "Harper", gender: 1, name: "Harper", level:
            LevelRange(setBall: 0, block: 0, dig: 0, spike: 0, sum: 0)), // 校隊
    User(id: "Liam", email: "Liam", gender: 0, name: "Liam", level:
            LevelRange(setBall: 1, block: 1, dig: 1, spike: 1, sum: 1)),
    User(id: "Noah", email: "Noah", gender: 0, name: "Noah", level:
            LevelRange(setBall: 3, block: 3, dig: 3, spike: 2, sum: 3)),
    User(id: "Oliver", email: "Oliver", gender: 0, name: "Oliver", level:
            LevelRange(setBall: 2, block: 2, dig: 3, spike: 2, sum: 2)),
    User(id: "Elijah", email: "Elijah", gender: 0, name: "Elijah", level:
            LevelRange(setBall: 1, block: 1, dig: 2, spike: 0, sum: 1)),
    User(id: "Ben", email: "Ben", gender: 0, name: "Ben", level:
            LevelRange(setBall: 0, block: 2, dig: 1, spike: 3, sum: 2)),
    User(id: "Mason", email: "Mason", gender: 0, name: "Mason", level:
            LevelRange(setBall: 2, block: 3, dig: 0, spike: 3, sum: 2)),
    User(id: "James", email: "James", gender: 0, name: "James", level:
            LevelRange(setBall: 1, block: 1, dig: 0, spike: 0, sum: 1)),
    User(id: "Alex", email: "Alex", gender: 0, name: "Alex", level:
            LevelRange(setBall: 2, block: 1, dig: 2, spike: 1, sum: 2))
]
