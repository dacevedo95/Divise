//
//  KeychainHelper.swift
//  Pingd
//
//  Created by David Acevedo on 3/9/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation

public class KeychainHelper {
    
    /**
     Adds a key/value pair to the Keychain
     */
    public static func addKeychainItem(key: String, value: String) -> OSStatus {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrService as String: key,
                                    kSecValueData as String: value.data(using: String.Encoding.utf8)!]
        let status = SecItemAdd(query as CFDictionary, nil)
        return status
    }
    
    /**
     Updates a value in the Keychain given the key
     */
    public static func updateKeychainItem(key: String, updatedValue: String) -> OSStatus {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrService as String: key]
        let attributes: [String: Any] = [kSecValueData as String: updatedValue.data(using: String.Encoding.utf8)!]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        return status
    }
    
    /**
     Retrieves a key value pair from the Keychain
     */
    public static func getKeychainItem(key: String) throws -> String? {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrService as String: key,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { return nil }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        
        let existingItem = item as? [String : Any]
        let itemData = existingItem![kSecValueData as String] as! Data
        return String(data: itemData, encoding: String.Encoding.utf8)!
    }
}
