//
//  UserExistenceModel.swift
//  Pingd
//
//  Created by David Acevedo on 3/4/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation

struct UserExistenceResponse {
    let exists: Bool
}

extension UserExistenceResponse: Decodable {
    private enum UserExistenceResponseCodingKeys: String, CodingKey {
        case exists
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserExistenceResponseCodingKeys.self)
        
        exists = try container.decode(Bool.self, forKey: .exists)
    }
}
