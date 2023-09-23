//
//  User.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/19.
//

import Foundation

enum User: String {
    case id = "id"
    case name = "name"
    case gender = "gender"
    case level = "self_level"
    case email = "email"
}

struct UserData {
    var id: String
    var email: String
    var gender: Int
    var name: String
    var level: LevelRange
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
