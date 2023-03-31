//
//  GetPosts.swift
//  LeagueMobileChallenge
//
//  Created by banie setijoso on 2023-03-31.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation

protocol GetPosts {
    func get() async -> Result<[Post], Error>
}
