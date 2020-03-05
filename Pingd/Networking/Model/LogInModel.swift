//
//  LogInModel.swift
//  Pingd
//
//  Created by David Acevedo on 2/29/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation

struct LogInResponse {
    let token: String
    let expiresAt: Int
    let refreshToken: String
}

extension LogInResponse: Decodable {
    private enum LogInResponseCodingKeys: String, CodingKey {
        case token
        case expiresAt = "expires_at"
        case refreshToken  = "refresh_token"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LogInResponseCodingKeys.self)
        
        token = try container.decode(String.self, forKey: .token)
        expiresAt = try container.decode(Int.self, forKey: .expiresAt)
        refreshToken = try container.decode(String.self, forKey: .refreshToken)
    }
}
