//
//  TransactionCell.swift
//  Pingd
//
//  Created by David Acevedo on 9/13/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import UIKit

enum Category {
    case wants
    case needs
    case savings
}

struct Transaction {
    var category: Category?
    var price: Double?
    var description: String?
    var date: Date?
}

class TransactionCell: UICollectionViewCell {
    
    var data: Transaction = Transaction()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCategory(to category: Category) {
        data.category = category
    }
    
}
