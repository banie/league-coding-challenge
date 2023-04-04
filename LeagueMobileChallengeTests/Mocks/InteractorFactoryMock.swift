//
//  InteractorFactoryMock.swift
//  LeagueMobileChallengeTests
//
//  Created by banie setijoso on 2023-04-04.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation
@testable import LeagueMobileChallenge

class InteractorFactoryMock: InteractorFactory {
    private let getPostsFromNetworkMock: GetPostsMock
    private let getUsersFromNetworkMock: GetUsersMock
    private let getPostsFromStorageMock: GetPostsMock
    private let getUsersFromStorageMock: GetUsersMock
    private let savePostsToStorageMock: SavePostsMock
    private let saveUsersToStoragekMock: SaveUsersMock
    
    init(getPostsFromNetworkMock: GetPostsMock, getUsersFromNetworkMock: GetUsersMock,
         getPostsFromStorageMock: GetPostsMock, getUsersFromStorageMock: GetUsersMock,
         savePostsToStorageMock: SavePostsMock, saveUsersToStoragekMock: SaveUsersMock) {
        self.getPostsFromNetworkMock = getPostsFromNetworkMock
        self.getUsersFromNetworkMock = getUsersFromNetworkMock
        self.getPostsFromStorageMock = getPostsFromStorageMock
        self.getUsersFromStorageMock = getUsersFromStorageMock
        self.savePostsToStorageMock = savePostsToStorageMock
        self.saveUsersToStoragekMock = saveUsersToStoragekMock
    }
    
    func interactorGetPostsFromNetwork() -> GetPosts {
        getPostsFromNetworkMock
    }
    
    func interactorGetUsersFromNetwork() -> GetUsers {
        getUsersFromNetworkMock
    }
    
    func interactorGetPostsFromStorage() -> GetPosts {
        getPostsFromStorageMock
    }
    
    func interactorGetUsersFromStorage() -> GetUsers {
        getUsersFromStorageMock
    }
    
    func interactorSavePostToStorage() -> SavePosts {
        savePostsToStorageMock
    }
    
    func interactorSaveUsersToStorage() -> SaveUsers {
        saveUsersToStoragekMock
    }
    
    
}
