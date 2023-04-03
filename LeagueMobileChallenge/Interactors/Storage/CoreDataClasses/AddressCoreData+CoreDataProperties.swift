//
//  AddressCoreData+CoreDataProperties.swift
//  
//
//  Created by banie setijoso on 2023-04-03.
//
//

import Foundation
import CoreData


extension AddressCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddressCoreData> {
        return NSFetchRequest<AddressCoreData>(entityName: "AddressCoreData")
    }

    @NSManaged public var city: String?
    @NSManaged public var street: String?
    @NSManaged public var suite: String?
    @NSManaged public var userId: Int64
    @NSManaged public var zipcode: String?
    @NSManaged public var geo: GeoCoreData?

}
