//
//  GetAccesTokenFromNetwork.swift
//  LeagueMobileChallenge
//
//  Created by banie setijoso on 2023-03-31.
//  Copyright © 2023 Banie Setijoso. All rights reserved.
//

import Foundation

class GetUserTokenFromNetwork: GetUserToken {
    private let apiController: APIController
    
    init(apiController: APIController = APIController.shared) {
        self.apiController = apiController
    }
    
    func get() async -> Result<String, Error> {
        await withCheckedContinuation { continuation in
            apiController.fetchUserToken(completion: { token, error in
                guard let token = token else {
                    return continuation.resume(returning: .failure(NSError()))
                }
                
                if let error = error {
                    return continuation.resume(returning: .failure(error))
                }
                
                continuation.resume(returning: .success(token))
            })
        }
    }
}

