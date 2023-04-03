//
//  SavePostsToCoreData.swift
//  LeagueMobileChallenge
//
//  Created by banie setijoso on 2023-04-03.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation
import CoreData

class SavePostsToCoreData: SavePosts {
    let objectContext: NSManagedObjectContext
    
    init(objectContext: NSManagedObjectContext) {
        self.objectContext = objectContext
    }
    
    func save(_ posts: [Post]) throws {
        for post in posts {
            let postCoreData = PostCoreData(context: objectContext)
            postCoreData.id = Int64(post.id)
            postCoreData.userId = Int64(post.userId)
            postCoreData.title = post.title
            postCoreData.body = post.body
        }
        
        try objectContext.save()
    }
}
