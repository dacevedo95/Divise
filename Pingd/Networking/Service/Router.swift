//
//  Router.swift
//  Pingd
//
//  Created by David Acevedo on 2/25/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import os

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        // Creates a session
        let session = URLSession.shared
        
        do {
            // Builds the request and loggs it
            let request = try self.buildRequest(from: route)
            NetworkLogger.log(request: request)
            
            // Creates a signpost and generates the signpost id
            let signpostID = OSSignpostID(log: Log.networking)
            os_signpost(.begin, log: Log.networking, name: route.signpostName, signpostID: signpostID)
            
            // Makes the call
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                // Processes ending off request
                NetworkLogger.log(response: response, data: data)
                os_signpost(.end, log: Log.networking, name: route.signpostName, signpostID: signpostID)
                
                // Fires the completion handler
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters, let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            case .requestParametersAndHeader(let bodyParameters, let urlParameters, let additionalHeaders):
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    func cancel() {
        self.task?.cancel()
    }
}
