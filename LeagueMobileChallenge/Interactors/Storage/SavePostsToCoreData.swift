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
            let fetchRequest: NSFetchRequest<PostCoreData> = PostCoreData.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", post.id)

            // since we don't want to save the same post with the same id, find it first
            // in the db, if one exist then just update that entity with the newest
            // properties from the network
            let postCoreData: PostCoreData
            do {
                let results = try objectContext.fetch(fetchRequest)
                if let firstEntity = results.first {
                    postCoreData = firstEntity
                } else {
                    postCoreData = PostCoreData(context: objectContext)
                }
            } catch let error as NSError {
                print("Fetch error: \(error) description: \(error.userInfo)")
                postCoreData = PostCoreData(context: objectContext)
            }
            
            postCoreData.id = Int64(post.id)
            postCoreData.userId = Int64(post.userId)
            postCoreData.title = post.title
            postCoreData.body = post.body
        }
        
        try objectContext.save()
    }
}
