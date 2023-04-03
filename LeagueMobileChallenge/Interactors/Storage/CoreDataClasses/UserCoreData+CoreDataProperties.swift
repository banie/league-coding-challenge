//
//  UserCoreData+CoreDataProperties.swift
//  
//
//  Created by banie setijoso on 2023-04-03.
//
//

import Foundation
import CoreData


extension UserCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCoreData> {
        return NSFetchRequest<UserCoreData>(entityName: "UserCoreData")
    }

    @NSManaged public var avatar: String?
    @NSManaged public var email: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String
    @NSManaged public var phone: String?
    @NSManaged public var username: String?
    @NSManaged public var website: String?
    @NSManaged public var address: AddressCoreData?
    @NSManaged public var company: CompanyCoreData?
    @NSManaged public var post: NSSet?

}

// MARK: Generated accessors for post
extension UserCoreData {

    @objc(addPostObject:)
    @NSManaged public func addToPost(_ value: PostCoreData)

    @objc(removePostObject:)
    @NSManaged public func removeFromPost(_ value: PostCoreData)

    @objc(addPost:)
    @NSManaged public func addToPost(_ values: NSSet)

    @objc(removePost:)
    @NSManaged public func removeFromPost(_ values: NSSet)

}
