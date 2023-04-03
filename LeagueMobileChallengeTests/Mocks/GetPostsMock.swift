//
//  GetPostsMock.swift
//  LeagueMobileChallengeTests
//
//  Created by banie setijoso on 2023-04-02.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation
@testable import LeagueMobileChallenge

class GetPostsMock: GetPosts {
    var posts: Result<[Post], Error>?
    func get() async -> Result<[Post], Error> {
        posts ?? .success([])
    }
}
