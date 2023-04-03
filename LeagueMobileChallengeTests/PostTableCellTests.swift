//
//  PostTableCellTests.swift
//  LeagueMobileChallengeTests
//
//  Created by banie setijoso on 2023-04-02.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import XCTest
@testable import LeagueMobileChallenge

final class PostTableCellTests: XCTestCase {

    private var tableView: UITableView!
    
    override func setUpWithError() throws {
        tableView = UITableView()
        tableView.register(UINib(nibName: "PostTableCell", bundle: nil), forCellReuseIdentifier: "PostTableCell")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCellUISetup() throws {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableCell", for: IndexPath(row: 0, section: 0)) as? PostTableCell
        
        XCTAssertEqual(cell?.usernameLabel.font.fontDescriptor, UIFont.preferredFont(forTextStyle: .title3).fontDescriptor)
        XCTAssertEqual(cell?.titleLabel.font.fontDescriptor, UIFont.preferredFont(forTextStyle: .headline).fontDescriptor)
        XCTAssertEqual(cell?.descLabel.font.fontDescriptor, UIFont.preferredFont(forTextStyle: .body).fontDescriptor)
        
        XCTAssertTrue(cell?.usernameLabel.adjustsFontForContentSizeCategory ?? false)
        XCTAssertTrue(cell?.titleLabel.adjustsFontForContentSizeCategory ?? false)
        XCTAssertTrue(cell?.descLabel.adjustsFontForContentSizeCategory ?? false)
        
        XCTAssertEqual(cell?.usernameLabel.textColor, UIColor.label)
        XCTAssertEqual(cell?.titleLabel.textColor, UIColor.label)
        XCTAssertEqual(cell?.descLabel.textColor, UIColor.label)
        
        // make sure it word wraps into multiple lines if needed
        XCTAssertEqual(cell?.usernameLabel.numberOfLines, 0)
        XCTAssertEqual(cell?.titleLabel.numberOfLines, 0)
        XCTAssertEqual(cell?.descLabel.numberOfLines, 0)
        XCTAssertEqual(cell?.usernameLabel.lineBreakMode, .byWordWrapping)
        XCTAssertEqual(cell?.titleLabel.lineBreakMode, .byWordWrapping)
        XCTAssertEqual(cell?.descLabel.lineBreakMode, .byWordWrapping)
    }
    
    func testCellDecoration() throws {
        let postItem = PostItem(id: 1, userName: "Test User", avatar: URL(string: "https://i.pravatar.cc/150?u=1")!, title: "Test Title", body: "Test Body")
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableCell", for: IndexPath(row: 0, section: 0)) as? PostTableCell
        cell?.decorate(with: postItem)
        
        XCTAssertEqual(cell?.usernameLabel.text, "Test User")
        XCTAssertEqual(cell?.titleLabel.text, "Test Title")
        XCTAssertEqual(cell?.descLabel.text, "Test Body")
    }
}
