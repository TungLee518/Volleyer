//
//  VolleyerTests.swift
//  VolleyerTests
//
//  Created by 李童 on 2023/10/21.
//

import XCTest

@testable import Volleyer

final class VolleyerTests: XCTestCase {

    let fakeUsers: [User] = [
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

    var sut: RandomTeamViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = RandomTeamViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testMaxAverageDifference() {
        let maxAveDiff = sut.calculateMaxAverageLevelDifference(players: fakeUsers)
        XCTAssertLessThanOrEqual(maxAveDiff, 0.5)
        let maxAveDiff2 = sut.calculateMaxAverageLevelDifference(players: fakeUsers)
        XCTAssertLessThanOrEqual(maxAveDiff2, 0.5)
        let maxAveDiff3 = sut.calculateMaxAverageLevelDifference(players: fakeUsers)
        XCTAssertLessThanOrEqual(maxAveDiff3, 0.5)
    }
}
