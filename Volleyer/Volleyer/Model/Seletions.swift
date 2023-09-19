//
//  Seletions.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/16.
//

import Foundation

let playTypes = ["女網女排", "女網混排", "男網男排", "男網混排"]

enum PlayType: String, Codable {
    case girls
    case girlsAll
    case boys
    case boysAll
    
    func title() -> String {
        switch self {
        case .girls: return "女網女排"
        case .girlsAll: return "女網混排"
        case .boys: return "男網男排"
        case .boysAll: return "男網混排"
        }
    }
}
