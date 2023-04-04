//
//  SaveUsersMock.swift
//  LeagueMobileChallengeTests
//
//  Created by banie setijoso on 2023-04-04.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation
@testable import LeagueMobileChallenge

class SaveUsersMock: SaveUsers {
    var saveSpy: (() -> Void)?
    func save(_ users: [User]) throws {
        saveSpy?()
    }
}
