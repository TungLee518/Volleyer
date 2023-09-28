//
//  PlayOne.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/24.
//

import Foundation

struct PlayOne {
    let court: String
    let finders: [User]
    let order: Int
}

struct PlayOneFinder {
    let finderId: String
    let court: String
    let player1: PlayerN = PlayerN(name: "", image: "")
    let player2: PlayerN = PlayerN(name: "", image: "")
    let player3: PlayerN = PlayerN(name: "", image: "")
    let player4: PlayerN = PlayerN(name: "", image: "")
    let player5: PlayerN = PlayerN(name: "", image: "")
}

struct PlayerN {
    let name: String
    let image: String
}
