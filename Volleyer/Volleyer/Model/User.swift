//
//  User.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/19.
//

import Foundation

enum UserTitle: String {
    case firebaseId = "firebase_id"
    case id = "id"
    case name = "name"
    case gender = "gender"
    case level = "self_level"
    case email = "email"
    case myPlayList = "my_play_list"
}

struct User {
    var firebaseId: String = ""
    var id: String
    var email: String
    var gender: Int
    var name: String
    var level: LevelRange = LevelRange(setBall: 4, block: 4, dig: 4, spike: 4, sum: 4)
    var myPlayList: [String] = []
}

enum Level: String {
    case setBall = "SetBall"
    case block = "Block"
    case dig = "Dig"
    case spike = "Spike"
    case sum = "Sum"
}

let genderList = ["Male", "Female"]
let launchAppDate = "launchAppDate"
