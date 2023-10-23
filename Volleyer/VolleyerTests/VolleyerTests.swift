//
//  VolleyerTests.swift
//  VolleyerTests
//
//  Created by 李童 on 2023/10/21.
//

import XCTest

@testable import Volleyer

final class VolleyerTests: XCTestCase {

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
