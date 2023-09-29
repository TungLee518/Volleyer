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
    let player1: PlayerN?
    let player2: PlayerN?
    let player3: PlayerN?
    let player4: PlayerN?
    let player5: PlayerN?
}

struct PlayerN {
    let name: String
    let image: String
}
