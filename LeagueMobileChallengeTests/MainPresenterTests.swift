//
//  MainPresenterTests.swift
//  LeagueMobileChallengeTests
//
//  Created by banie setijoso on 2023-04-03.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import XCTest
import Combine
@testable import LeagueMobileChallenge

final class MainPresenterTests: XCTestCase {
    
    private var getUsersMock: GetUsersMock!
    private var getPostsMock: GetPostsMock!
    private var interactorFactory: InteractorFactoryMock!
    private var presenter: MainPresenter!
    private var subscribers = [AnyCancellable]()
    
    override func setUpWithError() throws {
        getUsersMock = GetUsersMock()
        getPostsMock = GetPostsMock()
        interactorFactory = InteractorFactoryMock(getPostsFromNetworkMock: getPostsMock, getUsersFromNetworkMock: getUsersMock, getPostsFromStorageMock: getPostsMock, getUsersFromStorageMock: getUsersMock, savePostsToStorageMock: SavePostsMock(), saveUsersToStoragekMock: SaveUsersMock())
        presenter = MainPresenter(interactorFactory: interactorFactory)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGettingPostItems() async throws {
        let users = [User(id: 1, avatar: URL(string: "https://i.pravatar.cc/150?u=1")!, name: "User 1", username: "Username 1", email: "test1.user@email", address: Address(street: "1 Test Street", suite: "", city: "Test 1 City", zipcode: "Test 2 Zipcode", geo: Geo(lat: "-1.0", lng: "1.0")), phone: "111-222-3333", website: URL(string: "test1.com")!, company: Company(name: "Test 1 Company", catchPhrase: "Test 1 catchphrase", bs: "Test 1 BS")),
                     User(id: 2, avatar: URL(string: "https://i.pravatar.cc/150?u=1")!, name: "User 2", username: "Username 2", email: "test2.user@email", address: Address(street: "2 Test Street", suite: "", city: "Test 2 City", zipcode: "Test 2 Zipcode", geo: Geo(lat: "-2.0", lng: "2.0")), phone: "444-555-6666", website: URL(string: "test2.com")!, company: Company(name: "Test 2 Company", catchPhrase: "Test 2 catchphrase", bs: "Test 2 BS"))]
        
        getUsersMock.users = .success(users)
        
        let posts = [Post(userId: 1, id: 11, title: "Test 1 Post", body: "Test 1 Body"), Post(userId: 2, id: 22, title: "Test 2 Post", body: "Test 2 Body")]
        
        getPostsMock.posts = .success(posts)
        
        presenter.listChanged.sink { snapshot in
            XCTAssertEqual(snapshot.sectionIdentifiers, [0])
            
            let postItems = snapshot.itemIdentifiers(inSection: 0)
            XCTAssertEqual(postItems.count, 2)
            
            XCTAssertEqual(postItems[0].id, posts[0].id)
            XCTAssertEqual(postItems[0].userName, users[0].name)
            XCTAssertEqual(postItems[0].avatar, users[0].avatar)
            XCTAssertEqual(postItems[0].title, "Test 1 Post")
            XCTAssertEqual(postItems[0].body, "Test 1 Body")
            
            XCTAssertEqual(postItems[1].id, posts[1].id)
            XCTAssertEqual(postItems[1].userName, users[1].name)
            XCTAssertEqual(postItems[1].avatar, users[1].avatar)
            XCTAssertEqual(postItems[1].title, "Test 2 Post")
            XCTAssertEqual(postItems[1].body, "Test 2 Body")
        }.store(in: &subscribers)
        
        await presenter.load()
    }

}
