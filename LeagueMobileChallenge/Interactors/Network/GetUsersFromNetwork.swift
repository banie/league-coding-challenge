//
//  GetUsersFromNetwork.swift
//  LeagueMobileChallenge
//
//  Created by banie setijoso on 2023-03-31.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation

class GetUsersFromNetwork: GetUsers {
    private let apiController: APIController
    private let decoder: JSONDecoder
    
    init(apiController: APIController = APIController.shared) {
        self.apiController = apiController
        decoder = JSONDecoder()
    }
    
    func get() async -> Result<[User], Error> {
        await withCheckedContinuation { continuation in
            apiController.fetchUsers(completion: { data, error in
                guard let data = data as? Data else {
                    return continuation.resume(returning: .failure(NSError()))
                }
                
                if let error = error {
                    return continuation.resume(returning: .failure(error))
                }
                
                do {
                    let models = try self.decoder.decode([User].self, from: data)
                    continuation.resume(returning: .success(models))
                } catch let parseError {
                    return continuation.resume(returning: .failure(parseError))
                }
            })
        }
    }
}
