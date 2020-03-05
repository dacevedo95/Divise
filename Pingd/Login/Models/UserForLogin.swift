//
//  UserForLogin.swift
//  Pingd
//
//  Created by David Acevedo on 2/20/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import Alamofire
import os

class UserForLogin: Encodable {
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
