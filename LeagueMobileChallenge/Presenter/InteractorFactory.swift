//
//  InteractorFactory.swift
//  LeagueMobileChallenge
//
//  Created by banie setijoso on 2023-04-03.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation

protocol InteractorFactory {
    func interactorGetPostsFromNetwork() -> GetPosts
    func interactorGetUsersFromNetwork() -> GetUsers
    func interactorGetPostsFromStorage() -> GetPosts
    func interactorGetUsersFromStorage() -> GetUsers
    func interactorSavePostToStorage() -> SavePosts
    func interactorSaveUsersToStorage() -> SaveUsers
}

class DefaultInteractorFactory: InteractorFactory {
    func interactorGetPostsFromNetwork() -> GetPosts {
        GetPostsFromNetwork()
    }
    
    func interactorGetUsersFromNetwork() -> GetUsers {
        GetUsersFromNetwork()
    }
    
    func interactorGetPostsFromStorage() -> GetPosts {
        GetPostsFromCoreData(objectContext: PersistenceController.shared.viewContext)
    }
    
    func interactorGetUsersFromStorage() -> GetUsers {
        GetUsersFromCoreData(objectContext: PersistenceController.shared.viewContext)
    }
    
    func interactorSavePostToStorage() -> SavePosts {
        SavePostsToCoreData(objectContext: PersistenceController.shared.backgroundContext)
    }
    
    func interactorSaveUsersToStorage() -> SaveUsers {
        SaveUsersToCoreData(objectContext: PersistenceController.shared.backgroundContext)
    }
}
