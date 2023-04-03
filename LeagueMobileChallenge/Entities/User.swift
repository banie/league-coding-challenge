//
//  User.swift
//  LeagueMobileChallenge
//
//  Created by banie setijoso on 2023-03-30.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let avatar: URL?
    let name: String
    let username: String
    let email: String
    let address: Address?
    let phone: String
    let website: URL?
    let company: Company?
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo?
}

struct Geo: Codable {
    let lat: String
    let lng: String
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}
