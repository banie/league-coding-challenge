//
//  GetPostsFromCoreData.swift
//  LeagueMobileChallenge
//
//  Created by banie setijoso on 2023-04-03.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation
import CoreData

class GetPostsFromCoreData: GetPosts {

    let objectContext: NSManagedObjectContext
    
    init(objectContext: NSManagedObjectContext) {
        self.objectContext = objectContext
    }
    
    func get() async -> Result<[Post], Error> {
        let postsCoreData: [PostCoreData]
        let sortById = NSSortDescriptor(key: #keyPath(PostCoreData.id), ascending: true)
        let fetchRequest: NSFetchRequest<PostCoreData> = PostCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [sortById]
        
        do {
            postsCoreData = try objectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            return .failure(error)
        }

        let posts = postsCoreData.map { postCoreData in
            return Post(userId: Int(postCoreData.userId), id: Int(postCoreData.id), title: postCoreData.title ?? "", body: postCoreData.body ?? "")
        }
        
        return .success(posts)
    }
}
