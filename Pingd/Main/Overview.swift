//
//  Overview.swift
//  Pingd
//
//  Created by David Acevedo on 8/23/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation

struct Overview {
    let header: String
    let amountSpent: Float
    let monthlyIncome: Float
    let totalPercentage: Int
    let daysLeft: Int
    let showInfo: Bool
    let showTransactions: Bool
    let settings: Settings
}

extension Overview: Decodable {
    
    private enum OverviewCodingKeys: String, CodingKey {
        case header
        case amountSpent
        case monthlyIncome
        case totalPercentage
        case daysLeft
        case showInfo
        case showTransactions
        case settings
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OverviewCodingKeys.self)
        
        header = try container.decode(String.self, forKey: .header)
        amountSpent = try container.decode(Float.self, forKey: .amountSpent)
        monthlyIncome = try container.decode(Float.self, forKey: .monthlyIncome)
        totalPercentage = try container.decode(Int.self, forKey: .totalPercentage)
        daysLeft = try container.decode(Int.self, forKey: .daysLeft)
        showInfo = try container.decode(Bool.self, forKey: .showInfo)
        showTransactions = try container.decode(Bool.self, forKey: .showTransactions)
        settings = try container.decode(Settings.self, forKey: .settings)
    }
    
}


struct Settings {
    let needs: Setting
    let wants: Setting
    let savings: Setting
}

extension Settings: Decodable {
    
    public enum SettingsCodingKeys: String, CodingKey {
        case needs
        case wants
        case savings
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SettingsCodingKeys.self)
        
        needs = try container.decode(Setting.self, forKey: .needs)
        wants = try container.decode(Setting.self, forKey: .wants)
        savings = try container.decode(Setting.self, forKey: .savings)
    }
}

struct Setting {
    let spent: Float
    let allowed: Float
    let percentage: Int
}

extension Setting: Decodable {
    
    public enum SettingCodingKeys: String, CodingKey {
        case spent
        case allowed
        case percentage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SettingCodingKeys.self)
        
        spent = try container.decode(Float.self, forKey: .spent)
        allowed = try container.decode(Float.self, forKey: .allowed)
        percentage = try container.decode(Int.self, forKey: .percentage)
    }
    
}
