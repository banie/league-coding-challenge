//
//  GetUsersMock.swift
//  LeagueMobileChallengeTests
//
//  Created by banie setijoso on 2023-04-02.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation
@testable import LeagueMobileChallenge

class GetUsersMock: GetUsers {
    var users: Result<[User], Error>?
    func get() async -> Result<[User], Error> {
        users ?? .success([])
    }
}
