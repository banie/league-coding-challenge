//
//  GetPostsFromNetworkTests.swift
//  LeagueMobileChallengeTests
//
//  Created by banie setijoso on 2023-04-02.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import XCTest
@testable import LeagueMobileChallenge

final class GetPostsFromNetworkTests: XCTestCase {
    
    private var apiMock: NetworkApiMock!
    private var interactor: GetPostsFromNetwork!

    override func setUpWithError() throws {
        apiMock = NetworkApiMock()
        interactor = GetPostsFromNetwork(networkApi: apiMock)
    }

    override func tearDownWithError() throws {
        apiMock.fetchPostsSpy = nil
    }

    func testGetPosts() async {
        let sampleResponse = """
        [
            {
                "userId": 3,
                "id": 26,
                "title": "est et quae odit qui non",
                "body": "similique esse doloribus nihil ..."
            },
            {
                "userId": 4,
                "id": 27,
                "title": "title post 27",
                "body": "body description for post 27 ..."
            }
        ]
        """.data(using: .utf8)!
        
        apiMock.fetchPostsSpy = { completion in
            completion?(sampleResponse, nil)
        }
        
        let result = await interactor.get()
        switch result {
        case .failure(_):
            return
        case .success(let posts):
            XCTAssertEqual(posts.count, 2)
            XCTAssertEqual(posts[0].userId, 3)
            XCTAssertEqual(posts[0].id, 26)
            XCTAssertEqual(posts[0].title, "est et quae odit qui non")
            XCTAssertEqual(posts[0].body, "similique esse doloribus nihil ...")
            XCTAssertEqual(posts[1].userId, 4)
            XCTAssertEqual(posts[1].id, 27)
            XCTAssertEqual(posts[1].title, "title post 27")
            XCTAssertEqual(posts[1].body, "body description for post 27 ...")
        }
    }
}
