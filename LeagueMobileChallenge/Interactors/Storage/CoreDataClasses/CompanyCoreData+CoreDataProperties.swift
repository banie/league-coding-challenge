//
//  CompanyCoreData+CoreDataProperties.swift
//  
//
//  Created by banie setijoso on 2023-04-03.
//
//

import Foundation
import CoreData


extension CompanyCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompanyCoreData> {
        return NSFetchRequest<CompanyCoreData>(entityName: "CompanyCoreData")
    }

    @NSManaged public var bs: String?
    @NSManaged public var catchPhrase: String?
    @NSManaged public var name: String

}
