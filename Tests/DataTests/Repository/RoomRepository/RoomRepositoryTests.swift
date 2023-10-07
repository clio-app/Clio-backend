//
//  RoomRepositoryTests.swift
//  
//
//  Created by Thiago Henrique on 06/10/23.
//

import XCTest
import ClioEntities
@testable import DataLayer

final class RoomRepositoryTests: XCTestCase {
    
    func test_createRoom_should_append_new_room_in_array() async throws {
        let sut = makeSUT()
        let inputReq = CreateRoomRequest(name: "name", theme: Theme(title: "theme"))
        let _ = sut.createRoom(inputReq)
        XCTAssertEqual(sut.getAllRooms().count, 1)
    }

}

extension RoomRepositoryTests {
    func makeSUT() -> DefaultRoomRepository {
        let sut = DefaultRoomRepository()
        return sut
    }
}
