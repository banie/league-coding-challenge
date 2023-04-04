//
//  SaveUsersToCoreData.swift
//  LeagueMobileChallenge
//
//  Created by banie setijoso on 2023-04-03.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation
import CoreData

class SaveUsersToCoreData: SaveUsers {
    let objectContext: NSManagedObjectContext
    
    init(objectContext: NSManagedObjectContext) {
        self.objectContext = objectContext
    }
    
    func save(_ users: [User]) throws {
        for user in users {
            let fetchRequest: NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", user.id)

            // since we don't want to save the same user with the same id, find it first
            // in the db, if one exist then just update that entity with the newest
            // properties from the network
            let userCoreData: UserCoreData
            do {
                let results = try objectContext.fetch(fetchRequest)
                if let firstEntity = results.first {
                    userCoreData = firstEntity
                } else {
                    userCoreData = UserCoreData(context: objectContext)
                }
            } catch let error as NSError {
                print("Fetch error: \(error) description: \(error.userInfo)")
                userCoreData = UserCoreData(context: objectContext)
            }
            
            userCoreData.id = Int64(user.id)
            userCoreData.name = user.name
            userCoreData.username = user.username
            userCoreData.email = user.email
            userCoreData.phone = user.phone
            userCoreData.avatar = user.avatar?.absoluteString
            userCoreData.website = user.website?.absoluteString
            
            if let company = user.company {
                let companyCoreData = CompanyCoreData(context: objectContext)
                companyCoreData.name = company.name
                companyCoreData.catchPhrase = company.catchPhrase
                companyCoreData.bs = company.bs
                userCoreData.company = companyCoreData
            }
            
            if let address = user.address {
                let addressCoreData = AddressCoreData(context: objectContext)
                if let geo = address.geo {
                    let geoUserData = GeoCoreData(context: objectContext)
                    geoUserData.lat = geo.lat
                    geoUserData.lng = geo.lng
                    addressCoreData.geo = geoUserData
                }
                
                addressCoreData.street = address.street
                addressCoreData.city = address.city
                addressCoreData.suite = address.suite
                addressCoreData.zipcode = address.zipcode
                userCoreData.address = addressCoreData
            }
        }
        
        try objectContext.save()
    }
}
