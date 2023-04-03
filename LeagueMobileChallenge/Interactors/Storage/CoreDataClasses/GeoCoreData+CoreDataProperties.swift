//
//  GeoCoreData+CoreDataProperties.swift
//  
//
//  Created by banie setijoso on 2023-04-03.
//
//

import Foundation
import CoreData


extension GeoCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GeoCoreData> {
        return NSFetchRequest<GeoCoreData>(entityName: "GeoCoreData")
    }

    @NSManaged public var lat: String
    @NSManaged public var lng: String
    @NSManaged public var address: AddressCoreData?

}
