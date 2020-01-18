//
//  UITextField.swift
//  Pingd
//
//  Created by David Acevedo on 1/18/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import Foundation

extension UITextField {
    func setUnderLine() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width-10, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
