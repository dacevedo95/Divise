//
//  SignInEndpoint.swift
//  Pingd
//
//  Created by David Acevedo on 2/28/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation


enum Environment {
    case development
    case staging
    case production
}

public enum UserManagementEndpoint {
    case logIn(countryCode: String, phoneNumber: String, password: String)
    case createAccount(firstName: String, lastName: String, countryCode: String, phoneNumber: String, password: String)
    case checkUserExistance(countryCode: String, phoneNumber: String)
    case sendVerification(countryCode: String, phoneNumber: String)
    case checkVerification(countryCode: String, phoneNumber: String, code: String)
    case resetPassword(countryCode: String, phoneNumber: String, newPassword: String)
}

extension UserManagementEndpoint: EndPointType {
    
    var environmentBaseUrl: String {
        switch UserManagementManager.environment {
        case .development:
            return "http://PingdBackend-dev.us-east-1.elasticbeanstalk.com/api/v1/"
        case .staging:
            return "http://PingdBackend-dev.us-east-1.elasticbeanstalk.com/api/v1/"
        case .production:
            return "http://PingdBackend-dev.us-east-1.elasticbeanstalk.com/api/v1/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseUrl) else { fatalError("baseURL could not be confirgured") }
        return url
    }
    
    var path: String {
        switch self {
        case .logIn(_, _, _):
            return "login"
        case .sendVerification(_, _):
            return "users/verification"
        case .createAccount(_, _, _, _, _):
            return "users"
        case .checkVerification(_, _, _):
            return "users/verification/check"
        case .checkUserExistance(_, _):
            return "users/exists"
        case .resetPassword(_, _, _):
            return "users/reset-password"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var task: HTTPTask {
        switch self {
        case .logIn(let countryCode, let phoneNumber, let password):
            return .requestParameters(bodyParameters: ["countryCode": countryCode, "phoneNumber": phoneNumber, "password": password], urlParameters: nil)
        case .sendVerification(let countryCode, let phoneNumber):
            return .requestParameters(bodyParameters: ["countryCode": countryCode, "phoneNumber": phoneNumber], urlParameters: nil)
        case .createAccount(let firstName, let lastName, let countryCode, let phoneNumber, let password):
            return .requestParameters(bodyParameters: ["firstName": firstName, "lastName": lastName, "countryCode": countryCode, "phoneNumber": phoneNumber, "password": password], urlParameters: nil)
        case .checkVerification(let countryCode, let phoneNumber, let code):
            return .requestParameters(bodyParameters: ["countryCode": countryCode, "phoneNumber": phoneNumber, "code": code], urlParameters: nil)
        case .checkUserExistance(let countryCode, let phoneNumber):
            return .requestParameters(bodyParameters: ["countryCode": countryCode, "phoneNumber": phoneNumber], urlParameters: nil)
        case .resetPassword(let countryCode, let phoneNumber, let newPassword):
            return .requestParameters(bodyParameters: ["countryCode": countryCode, "phoneNumber": phoneNumber, "newPassword": newPassword], urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var shouldAuthorize: Bool {
        switch self {
        case .logIn(_, _, _):
            return false
        case .sendVerification:
            return false
        case .createAccount:
            return true
        case .checkVerification(_, _, _):
            return false
        case .checkUserExistance:
            return false
        case .resetPassword:
            return true
        }
    }
    
    var signpostName: StaticString {
        switch self {
        case .logIn(_, _, _):
            return "Log In"
        case .sendVerification:
            return "Send Verification"
        case .createAccount:
            return "Create Account"
        case .checkVerification(_, _, _):
            return "Check Verification"
        case .checkUserExistance:
            return "Check User Exists"
        case .resetPassword:
            return "Reset Password"
        }
    }
}
