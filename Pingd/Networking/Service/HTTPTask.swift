//
//  HTTPTask.swift
//  Pingd
//
//  Created by David Acevedo on 2/25/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeader(bodyParameters: Parameters?, urlParameters: Parameters?, headers: HTTPHeaders?)
}
