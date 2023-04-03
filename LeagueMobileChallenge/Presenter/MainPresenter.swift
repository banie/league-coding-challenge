//
//  MainPresenter.swift
//  LeagueMobileChallenge
//
//  Created by banie setijoso on 2023-03-31.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation
import Combine
import UIKit

class MainPresenter {
    weak var delegate: MainPresenterDelegate?
    
    private let listChangedSubject = PassthroughSubject<NSDiffableDataSourceSnapshot<Int, PostItem>, Never>()
    var listChanged: AnyPublisher<NSDiffableDataSourceSnapshot<Int, PostItem>, Never> {
        listChangedSubject.eraseToAnyPublisher()
    }
    
    private let getUsersInteractor: GetUsers
    private let getPostsInteractor: GetPosts
    private var items: [PostItem]
    
    init(getUsersInteractor: GetUsers = GetUsersFromNetwork(), getPostsInteractor: GetPosts = GetPostsFromNetwork()) {
        self.getUsersInteractor = getUsersInteractor
        self.getPostsInteractor = getPostsInteractor
        items = []
    }
    
    func load() async {
        let tokenResult = await GetUserTokenFromNetwork().get()
        switch tokenResult {
        case .success(let token):
            print("XXXX token: \(token)")
        case .failure(let error):
            await MainActor.run {
                delegate?.tokenFetchDidFail(with: error)
            }
            return
        }
        
        var users: [User] = []
        let usersResult = await getUsersInteractor.get()
        switch usersResult {
        case .success(let userList):
            users = userList
        case .failure(_):
            break
        }
        
        var posts: [Post] = []
        let postsResult = await getPostsInteractor.get()
        switch postsResult {
        case .success(let postList):
            posts = postList
        case .failure(let error):
            await MainActor.run {
                delegate?.loadDidFail(with: error)
            }
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
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, PostItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        
        listChangedSubject.send(snapshot)
    }
}

protocol MainPresenterDelegate: AnyObject {
    @MainActor
    func tokenFetchDidFail(with error: Error)
    
    @MainActor
    func loadDidFail(with error: Error)
}
