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
    
    private let interactorFactory: InteractorFactory
    private var items: [PostItem]
    
    init(interactorFactory: InteractorFactory = DefaultInteractorFactory()) {
        self.interactorFactory = interactorFactory
        items = []
    }
    
    func load() async {
        await loadFromStorage()
        await loadFromNetwork()
    }
    
    private func loadFromStorage() async {
        var users: [User]?
        let usersResult = await interactorFactory.interactorGetUsersFromStorage().get()
        switch usersResult {
        case .success(let userList):
            users = userList
        case .failure(_):
            break
        }
        
        var posts: [Post]?
        let postsResult = await interactorFactory.interactorGetPostsFromStorage().get()
        switch postsResult {
        case .success(let postList):
            posts = postList
        case .failure(_):
            break
        }
        
        if let posts = posts {
            let postItems = makePostItemsFrom(posts: posts, users: users)
            notifyItemsChanged(postItems)
        }
    }
    
    private func loadFromNetwork() async {
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
        
        var users: [User]?
        let usersResult = await interactorFactory.interactorGetUsersFromNetwork().get()
        switch usersResult {
        case .success(let userList):
            users = userList
            do {
                try interactorFactory.interactorSaveUsersToStorage().save(userList)
            } catch let error as NSError {
                print("Fetch error: \(error) description: \(error.userInfo)")
            }
        case .failure(_):
            break
        }
        
        var posts: [Post]?
        let postsResult = await interactorFactory.interactorGetPostsFromNetwork().get()
        switch postsResult {
        case .success(let postList):
            posts = postList
            do {
                try interactorFactory.interactorSavePostToStorage().save(postList)
            } catch let error as NSError {
                print("Fetch error: \(error) description: \(error.userInfo)")
            }
        case .failure(let error):
            await MainActor.run {
                delegate?.loadDidFail(with: error)
            }
        }
        
        if let posts = posts {
            let postItems = makePostItemsFrom(posts: posts, users: users)
            notifyItemsChanged(postItems)
        }
    }
    
    private func makePostItemsFrom(posts: [Post], users: [User]?) -> [PostItem] {
        posts.map { post in
            if let user = users?.first(where: { user in
                post.userId == user.id
            }) {
                return PostItem(id: post.id, userName: user.name, avatar: user.avatar, title: post.title, body: post.body)
            } else {
                return PostItem(id: post.id, userName: "", avatar: nil, title: post.title, body: post.body)
            }
        }
    }
    
    private func notifyItemsChanged(_ postItems: [PostItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PostItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(postItems)
        
        listChangedSubject.send(snapshot)
    }
}

protocol MainPresenterDelegate: AnyObject {
    @MainActor
    func tokenFetchDidFail(with error: Error)
    
    @MainActor
    func loadDidFail(with error: Error)
}
