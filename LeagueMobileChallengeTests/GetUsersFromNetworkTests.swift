//
//  GetUsersFromNetworkTests.swift
//  LeagueMobileChallengeTests
//
//  Created by banie setijoso on 2023-04-01.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import XCTest
@testable import LeagueMobileChallenge

final class GetUsersFromNetworkTests: XCTestCase {
    
    private var apiMock: NetworkApiMock!
    private var interactor: GetUsersFromNetwork!

    override func setUpWithError() throws {
        apiMock = NetworkApiMock()
        interactor = GetUsersFromNetwork(networkApi: apiMock)
    }

    override func tearDownWithError() throws {
        apiMock.fetchUsersSpy = nil
    }

    func testGetUsers() async {
        let sampleResponse = """
            [
                {
                    "id": 1,
                    "avatar": "https://i.pravatar.cc/150?u=1",
                    "name": "Leanne Graham",
                    "username": "Bret",
                    "email": "Sincere@april.biz",
                    "address": {
                        "street": "Kulas Light",
                        "suite": "Apt. 556",
                        "city": "Gwenborough",
                        "zipcode": "92998-3874",
                        "geo": {
                            "lat": "-37.3159",
                            "lng": "81.1496"
                        }
                    },
                    "phone": "1-770-736-8031 x56442",
                    "website": "hildegard.org",
                    "company": {
                        "name": "Romaguera-Crona",
                        "catchPhrase": "Multi-layered...",
                        "bs": "harness real-time e-markets"
                    }
                },
                {
                    "id": 2,
                    "avatar": "https://i.pravatar.cc/150?u=1",
                    "name": "Leanne Graham 2",
                    "username": "Bret 2",
                    "email": "Sincere@april.biz",
                    "address": {
                        "street": "Kulas Light",
                        "suite": "Apt. 556",
                        "city": "Gwenborough",
                        "zipcode": "92998-3874",
                        "geo": {
                            "lat": "-37.3159",
                            "lng": "81.1496"
                        }
                    },
                    "phone": "1-770-736-8031 x56442",
                    "website": "hildegard.org",
                    "company": {
                        "name": "Romaguera-Crona",
                        "catchPhrase": "Multi-layered...",
                        "bs": "harness real-time e-markets"
                    }
                }
            ]
        """.data(using: .utf8)!
        
        apiMock.fetchUsersSpy = { completion in
            completion?(sampleResponse, nil)
        }
        
        let result = await interactor.get()
        switch result {
        case .failure(_):
            return
        case .success(let users):
            XCTAssertEqual(users.count, 2)
            XCTAssertEqual(users[0].id, 1)
            XCTAssertEqual(users[0].name, "Leanne Graham")
            XCTAssertEqual(users[0].address?.street, "Kulas Light")
            XCTAssertEqual(users[0].address?.zipcode, "92998-3874")
            XCTAssertEqual(users[0].address?.geo?.lat, "-37.3159")
            XCTAssertEqual(users[0].address?.geo?.lng, "81.1496")
            XCTAssertEqual(users[0].name, "Leanne Graham")
            XCTAssertEqual(users[1].id, 2)
            XCTAssertEqual(users[1].name, "Leanne Graham 2")
            XCTAssertEqual(users[0].company?.name, "Romaguera-Crona")
            XCTAssertEqual(users[0].company?.bs, "harness real-time e-markets")
        }
    }
}
