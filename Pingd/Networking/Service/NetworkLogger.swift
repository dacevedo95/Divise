//
//  NetworkLogger.swift
//  Pingd
//
//  Created by David Acevedo on 3/2/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import os

class NetworkLogger {
    static func log(request: URLRequest) {
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod
        let path = urlComponents?.path
        let query = urlComponents?.query
        let host = urlComponents?.host
        
        var output = "\(method ?? "") \(host ?? "")\(path ?? "")\(query ?? "")"
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            output += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            output += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        os_log("Request: %{public}s", output)
    }
    
    static func log(response: URLResponse?, data: Data?) {
        guard response != nil else { return }
        guard data != nil else { return }
        
        let httpResponse = response as? HTTPURLResponse
        
        let output = "\(httpResponse?.statusCode ?? 0) \(data?.description ?? "")"
        os_log("Response: %{public}s", output)
    }
}
