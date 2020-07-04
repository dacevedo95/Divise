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
    
    func setIncomeLabel(amount: String, specifiedPointSize: CGFloat) {
        let sizeOfDollarSign = specifiedPointSize * 0.6
        let baselineOffset = round((specifiedPointSize * 0.2) * 1000.0) / 1000.0
        
        guard let n = NumberFormatter().number(from: amount) else {
            let amountText = NSMutableAttributedString.init(string: "$" + amount)
            amountText.setAttributes([NSAttributedString.Key.font: UIFont(name: "Arial Rounded MT Bold", size: CGFloat(sizeOfDollarSign))!,
                                      NSAttributedString.Key.foregroundColor: UIColor.init(red: 203, green: 203, blue: 203),
                                      NSAttributedString.Key.baselineOffset: baselineOffset], range: NSMakeRange(0, 1))
            
            self.attributedText = amountText
            return
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedAmount = numberFormatter.string(from: n) ?? amount
        
        let amountText = NSMutableAttributedString.init(string: "$" + formattedAmount)
        amountText.setAttributes([NSAttributedString.Key.font: UIFont(name: "Arial Rounded MT Bold", size: CGFloat(sizeOfDollarSign))!,
                                  NSAttributedString.Key.foregroundColor: UIColor.init(red: 203, green: 203, blue: 203),
                                  NSAttributedString.Key.baselineOffset: baselineOffset], range: NSMakeRange(0, 1))
        
        self.attributedText = amountText
    }
    
}
