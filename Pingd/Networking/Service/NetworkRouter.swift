//
//  NetworkRouter.swift
//  Pingd
//
//  Created by David Acevedo on 2/25/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request (_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
