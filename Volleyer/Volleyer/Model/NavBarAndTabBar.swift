//
//  NavBarAndTabBar.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/15.
//

import Foundation

enum NavBarEnum: String {
    case finderPage = "Volleyer"
    case establishFinderPage = "我要揪打球"
    case addOnePage = "我要加"
    case myPage = "My Page"
    case myProfile = "My Profile"
    case myFinders = "我的揪場"
    case myPlays = "我要打的場"
    case myRequests = "我收到的 requests"
    case myRequestsSent = "我寄出的 requests"
    case myFinderInfo = "我的揪場資訊"
    case randomTeam = "分隊嘍"
    case myPlayInfo = "我要打的場資訊"
    case communityPage = "Community"
    case playOnePage = "Play One"
    case competitionPage = "Competitions"
    case info = "詳細資訊"
}

enum TabBarEnum: String {
    case finderPage = "Find Play"
    case myPage = "My Page"
    case communityPage = "Community"
    case playOnePage = "Play One"
    case competitionPage = "Competitions"
}

enum TabBarImageEnum: String {
    case plus
    case profile
    case medal
    case players

    private var description: String {
           return self.rawValue
       }
}

let placeholderPic = "placeholder"
