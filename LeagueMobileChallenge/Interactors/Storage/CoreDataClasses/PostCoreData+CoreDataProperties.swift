//
//  PostCoreData+CoreDataProperties.swift
//  
//
//  Created by banie setijoso on 2023-04-03.
//
//

import Foundation
import CoreData


extension PostCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostCoreData> {
        return NSFetchRequest<PostCoreData>(entityName: "PostCoreData")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var userId: Int64
    @NSManaged public var user: UserCoreData?

}
