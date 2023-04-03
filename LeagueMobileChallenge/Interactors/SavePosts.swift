//
//  SavePosts.swift
//  LeagueMobileChallenge
//
//  Created by banie setijoso on 2023-04-03.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation

protocol SavePosts {
    func save(_ posts: [Post]) throws
}
