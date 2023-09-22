//
//  User.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/19.
//

import Foundation

enum User: String {
    case id = "UserID"
    case name = "UserName"
    case gender = "UserGender"
}

struct UserData {
    var id: String
    var email: String
    var gender: Int
    var name: String
}

let genderList = ["Male", "Female"]
let launchAppDate = "launchAppDate"
