//
//  PostItem.swift
//  LeagueMobileChallenge
//
//  Created by banie setijoso on 2023-03-31.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation

struct PostItem: Identifiable {
    let id: Int
    let userName: String
    let avatar: URL
    let title: String
    let body: String
}
