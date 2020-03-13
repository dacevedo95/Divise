//
//  NetworkManager.swift
//  Pingd
//
//  Created by David Acevedo on 2/29/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import UIKit
import os


enum NetworkResponse: String {
    case success
    case authError = "You need to be authenticated first"
    case forbidden = "Access denied"
    case badRequest = "Bad request"
    case internalServerError = "Internal Server error"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "Unable to decode response"
}

enum Result<String> {
    case success
    case failure(String)
}

var service: String {
    return "com.davidacevedo.Centsable"
}

struct UserManagementManager {
    static let environment: Environment = .production
    private let router = Router<UserManagementEndpoint>()
    
    
    func logIn(countryCode: String, phoneNumber: String, password: String, completion: @escaping (_ error: String?) -> ()) {
        router.request(.logIn(countryCode: countryCode, phoneNumber: phoneNumber, password: password)) { (data, response, error) in
            if error != nil {
                completion("An error occured. Please try again later")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let apiResponse = try JSONDecoder().decode(LogInResponse.self, from: responseData)
                        try self.storeCredentials(account: phoneNumber, token: apiResponse.token, expiresAt: apiResponse.expiresAt, refreshToken: apiResponse.refreshToken)
                        completion(nil)
                    } catch {
                        os_log("Error: %{public}s", error.localizedDescription)
                        completion("An error occured. Please try again later")
                    }
                case .failure(let networkFailureError):
                    if networkFailureError == NetworkResponse.authError.rawValue {
                        completion("Invalid email or password. Please try again")
                    } else {
                        completion("An error occured. Please try again later")
                    }
                }
            }
        }
    }
    
    func checkVerification(countryCode: String, phoneNumber: String, code: String, completion: @escaping (_ error: String?) -> ()) {
        router.request(.checkVerification(countryCode: countryCode, phoneNumber: phoneNumber, code: code)) { (data, response, error) in
            if error != nil {
                completion("An error occured. Please try again later")
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    guard let responseData = data else {
                        completion(NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let apiResponse = try JSONDecoder().decode(LogInResponse.self, from: responseData)
                        try self.storeCredentials(account: phoneNumber, token: apiResponse.token, expiresAt: apiResponse.expiresAt, refreshToken: apiResponse.refreshToken)
                        completion(nil)
                    } catch {
                        os_log("Error: %{public}s", error.localizedDescription)
                        completion("An error occured. Please try again later")
                    }
                case 400:
                    completion("Incorrect verification code. Please check that the code or phone number is correct")
                case 500:
                    completion("An error occured. Please try again later")
                default:
                    completion("An error occured. Please try again later")
                }
            }
        }
    }
    
    func sendVerification(countryCode: String, phoneNumber: String, completion: @escaping (_ error: String?) -> ()) {
        router.request(.sendVerification(countryCode: countryCode, phoneNumber: phoneNumber)) { (data, response, error) in
            if error != nil {
                completion("An error occured. Please try again later")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    completion(nil)
                case .failure(_):
                    completion("An error occured. Please try again later")
                }
            }
        }
    }
    
    func checkUserExistence(countryCode: String, phoneNumber: String, completion: @escaping (_ exists: Bool?, _ error: String?) -> ()) {
        router.request(.checkUserExistance(countryCode: countryCode, phoneNumber: phoneNumber)) { (data, response, error) in
            if error != nil {
                completion(nil, "An error occured. Please try again later")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, "An error occured. Please try again later")
                        return
                    }
                    
                    do {
                        let apiResponse = try JSONDecoder().decode(UserExistenceResponse.self, from: responseData)
                        completion(apiResponse.exists, nil)
                    } catch {
                        os_log("Error: %{public}s", error.localizedDescription)
                        completion(nil, "An error occured. Please try again later")
                    }
                    
                case .failure(_):
                    completion(nil, "An error occured. Please try again later")
                }
            }
        }
    }
    
    func createUser(firstName: String, lastName: String, countryCode: String, phoneNumber: String, password: String, completion: @escaping (_ error: String?) -> ()) {
        router.request(.createAccount(firstName: firstName, lastName: lastName, countryCode: countryCode, phoneNumber: phoneNumber, password: password)) { (data, response, error) in
            if error != nil {
                completion("An error occured. Please try again later")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    completion(nil)
                case .failure(_):
                    completion("An error occured. Please try again later")
                }
            }
        }
    }
    
    func resetPassword(countryCode: String, phoneNumber: String, newPassword: String, completion: @escaping (_ error: String?) -> ()) {
        router.request(.resetPassword(countryCode: countryCode, phoneNumber: phoneNumber, newPassword: newPassword)) { (data, response, error) in
            if error != nil {
                completion("An error occured. Please try again later")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    completion(nil)
                case .failure(_):
                    completion("An error occured. Please try again later")
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 400:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 401:
            return .failure(NetworkResponse.authError.rawValue)
        case 403:
            return .failure(NetworkResponse.forbidden.rawValue)
        case 500:
            return .failure(NetworkResponse.internalServerError.rawValue)
        default:
            return .failure("Network request failed")
        }
    }
    
    fileprivate func storeCredentials(account: String, token: String, expiresAt: Int, refreshToken: String) throws {

        var tokenStatus: OSStatus?
        let currToken = try KeychainHelper.getKeychainItem(key: "Access Token")
        if currToken != nil {
            tokenStatus = KeychainHelper.updateKeychainItem(key: "Access Token", updatedValue: token)
        } else {
            tokenStatus = KeychainHelper.addKeychainItem(key: "Access Token", value: token)
        }
        guard tokenStatus == errSecSuccess else { throw KeychainError.unhandledError(status: tokenStatus!) }
        
        
        var refreshTokenStatus: OSStatus?
        let currRefreshToken = try KeychainHelper.getKeychainItem(key: "Refresh Token")
        if currRefreshToken != nil {
            refreshTokenStatus = KeychainHelper.updateKeychainItem(key: "Refresh Token", updatedValue: refreshToken)
        } else {
            refreshTokenStatus = KeychainHelper.addKeychainItem(key: "Refresh Token", value: refreshToken)
        }
        guard refreshTokenStatus == errSecSuccess else { throw KeychainError.unhandledError(status: refreshTokenStatus!) }
        
        
        var timestampStatus: OSStatus?
        let currTimestamp = try KeychainHelper.getKeychainItem(key: "Timestamp")
        if currTimestamp != nil {
            timestampStatus = KeychainHelper.updateKeychainItem(key: "Timestamp", updatedValue: String(expiresAt))
        } else {
            timestampStatus = KeychainHelper.addKeychainItem(key: "Timestamp", value: String(expiresAt))
        }
        guard timestampStatus == errSecSuccess else { throw KeychainError.unhandledError(status: timestampStatus!) }
        
    }
    
}
