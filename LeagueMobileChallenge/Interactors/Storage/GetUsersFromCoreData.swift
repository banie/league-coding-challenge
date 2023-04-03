//
//  GetUsersFromCoreData.swift
//  LeagueMobileChallenge
//
//  Created by banie setijoso on 2023-04-03.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation
import CoreData

class GetUsersFromCoreData: GetUsers {

    let objectContext: NSManagedObjectContext
    
    init(objectContext: NSManagedObjectContext) {
        self.objectContext = objectContext
    }
    
    func get() async -> Result<[User], Error> {
        let usersCoreData: [UserCoreData]
        let sortById = NSSortDescriptor(key: #keyPath(UserCoreData.id), ascending: true)
        let fetchRequest: NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [sortById]
        
        do {
            usersCoreData = try objectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            return .failure(error)
        }

        let users = usersCoreData.map { userCoreData in
            var geo: Geo?
            if let geoCoreData = userCoreData.address?.geo {
                geo = Geo(lat: geoCoreData.lat, lng: geoCoreData.lng)
            }
            
            var address: Address?
            if let addressCoreData = userCoreData.address {
                address = Address(street: addressCoreData.street ?? "", suite: addressCoreData.suite ?? "", city: addressCoreData.city ?? "", zipcode: addressCoreData.zipcode ?? "", geo: geo)
            }
            
            var company: Company?
            if let companyCoreData = userCoreData.company {
                company = Company(name: companyCoreData.name, catchPhrase: companyCoreData.catchPhrase ?? "", bs: companyCoreData.bs ?? "")
            }
            
            var avatar: URL?
            if let avatarUrl = userCoreData.avatar {
                avatar = URL(string: avatarUrl)
            }
            
            var website: URL?
            if let websiteUrl = userCoreData.website {
                website = URL(string: websiteUrl)
            }
            
            return User(id: Int(userCoreData.id), avatar: avatar, name: userCoreData.name, username: userCoreData.username ?? "", email: userCoreData.email ?? "", address: address, phone: userCoreData.phone ?? "", website: website, company: company)
        }
        
        return .success(users)
    }
}
