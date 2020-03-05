//
//  ParameterEncoding.swift
//  Pingd
//
//  Created by David Acevedo on 2/25/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameter encoding failed"
    case missingURL = "URL is nil"
}
