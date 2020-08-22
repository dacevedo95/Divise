//
//  EditCategoryModel.swift
//  Pingd
//
//  Created by David Acevedo on 7/4/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import UIKit

class EditCategoryModel {
    var name: String
    var description: String
    var percentage: Int
    var color: UIColor
    
    init(name: String, description: String, percentage: Int, color: UIColor) {
        self.name = name
        self.description = description
        self.percentage = percentage
        self.color = color
    }
}
