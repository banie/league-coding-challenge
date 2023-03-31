//
//  Post.swift
//  LeagueMobileChallenge
//
//  Created by banie setijoso on 2023-03-30.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
