//
//  MainViewController.swift
//  LeagueMobileChallenge
//
//  Created by banie setijoso on 2023-03-31.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UITableViewController {
    override func viewDidLoad() {
        Task.detached {
            let token = await GetUserTokenFromNetwork().get()
            print("XXXX token: \(token)")
            
            let users = await GetUsersFromNetwork().get()
            print("XXXX users: \(users)")
            
            let posts = await GetPostsFromNetwork().get()
            print("XXXX posts: \(posts)")
        }
    }
}
