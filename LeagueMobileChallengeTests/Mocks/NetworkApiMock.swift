//
//  NetworkApiMock.swift
//  LeagueMobileChallengeTests
//
//  Created by banie setijoso on 2023-03-31.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation
@testable import LeagueMobileChallenge

class NetworkApiMock: NetworkApi {
    var fetchPostsSpy: ((((Any?, Error?) -> Void)?) -> Void)?
    func fetchPosts(completion: @escaping (Any?, Error?) -> Void) {
        fetchPostsSpy?(completion)
    }
    
    var fetchUsersSpy: ((((Any?, Error?) -> Void)?) -> Void)?
    func fetchUsers(completion: @escaping (Any?, Error?) -> Void) {
        fetchUsersSpy?(completion)
    }
}
