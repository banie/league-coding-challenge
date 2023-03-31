//
//  MainPresenter.swift
//  LeagueMobileChallenge
//
//  Created by banie setijoso on 2023-03-31.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation

class MainPresenter {
    weak var delegate: MainPresenterDelegate?
    
    var items: [PostItem]
    
    init() {
        items = []
    }
    
    func load() async {
        let tokenResult = await GetUserTokenFromNetwork().get()
        switch tokenResult {
        case .success(let token):
            print("XXXX token: \(token)")
        case .failure(let error):
            delegate?.tokenFetchDidFail(with: error)
            return
        }
        
        var users: [User] = []
        let usersResult = await GetUsersFromNetwork().get()
        switch usersResult {
        case .success(let userList):
            users = userList
        case .failure(let error):
            delegate?.loadDidFail(with: error)
        }
        
        var posts: [Post] = []
        let postsResult = await GetPostsFromNetwork().get()
        switch postsResult {
        case .success(let postList):
            posts = postList
        case .failure(let error):
            delegate?.loadDidFail(with: error)
        }
        
        items = posts.map { post in
            if let user = users.first(where: { user in
                post.userId == user.id
            }) {
                return PostItem(id: post.id, userName: user.name, avatar: user.avatar, title: post.title, body: post.body)
            } else {
                return PostItem(id: post.id, userName: "", avatar: URL(fileURLWithPath: ""), title: post.title, body: post.body)
            }
        }
        
        print("XXXX items: \(items)")
    }
}

protocol MainPresenterDelegate: AnyObject {
    func tokenFetchDidFail(with error: Error)
    func loadDidFail(with error: Error)
}
