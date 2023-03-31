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
        APIController.shared.fetchUserToken { token, error in
            print("XXX token: \(String(describing: token))")
        }
        
        APIController.shared.fetchUsers { users, error in
            print("XXX users: \(String(describing: users))")
        }
        
        APIController.shared.fetchPosts { posts, error in
            print("XXX users: \(String(describing: posts))")
        }
    }
}
