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
    var myPlayList: [String] = []
    var image: String = "https://firebasestorage.googleapis.com/v0/b/volleyer-a15b6.appspot.com/o/defaults%2Fplaceholder.png?alt=media&token=d686707b-7b55-4291-8d67-c809c14f9528&_gl=1*gmtbad*_ga*MTE1Njk3OTU3Ny4xNjkxNjU1MTk0*_ga_CW55HF8NVT*MTY5NjA2MDc1Ni45Mi4xLjE2OTYwNjEwMTguNTQuMC4w"
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
let loginWay = ["Apple", "Instagram"]
