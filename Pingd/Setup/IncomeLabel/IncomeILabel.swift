//
//  IncomeILabel.swift
//  Pingd
//
//  Created by David Acevedo on 7/3/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class IncomeLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func setIncomeLabel(amount: String) {
        let sizeOfDollarSign = self.font.pointSize * 0.6
        let baselineOffset = round((self.font.pointSize * 0.28125) * 1000.0) / 1000.0
        
        let amountText = NSMutableAttributedString.init(string: "$" + amount)
        amountText.setAttributes([NSAttributedString.Key.font: UIFont(name: "Arial Rounded MT Bold", size: sizeOfDollarSign)!,
                                  NSAttributedString.Key.foregroundColor: UIColor.init(red: 203, green: 203, blue: 203),
                                  NSAttributedString.Key.baselineOffset: baselineOffset], range: NSMakeRange(0, 1))
        
        self.attributedText = amountText
    }
    
}
