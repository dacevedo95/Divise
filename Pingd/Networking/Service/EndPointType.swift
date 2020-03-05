//
//  EndPointType.swift
//  Pingd
//
//  Created by David Acevedo on 2/25/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    var signpostName: StaticString { get }
}
