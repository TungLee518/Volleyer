//
//  GetUserByIdTest.swift
//  VolleyerTests
//
//  Created by 李童 on 2023/10/22.
//

import XCTest

@testable import Volleyer

final class GetUserByIdTest: XCTestCase {

    var sut: FinderDataManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = FinderDataManager()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testGetUserById() {
        var getUser: User?
        var error: Error?
        sut.getUserByFirebaseId(id: "7SyEE93yJY5mF6lIfUio") { gotUser, err in
            getUser = gotUser
            error = err
            let idGot = getUser?.id
            XCTAssertNil(error)
            XCTAssertEqual(idGot, "mayleetung")
        }
    }

    func testGetPlayById() {
        var getPlay: Play?
        var error: Error?
        sut.getPlayById(id: "VnxcGIEFUG0Nstb6Pj7r") { gotPlay, err in
            getPlay = gotPlay
            error = err
            let idGot = getPlay?.finderId
            XCTAssertNil(error)
            XCTAssertEqual(idGot, "7SyEE93yJY5mF6lIfUio")
        }
    }
}
