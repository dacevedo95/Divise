//
//  UIButton.swift
//  Pingd
//
//  Created by David Acevedo on 1/21/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func disable() {
        self.isEnabled = false
        UIView.animate(withDuration: 0.2) {
            self.layer.backgroundColor =  UIColor.lightGray.cgColor
        }
    }
    
    func enable() {
        self.isEnabled = true
        UIView.animate(withDuration: 0.2) {
            self.layer.backgroundColor =  UIColor.pingPurple.cgColor
        }
    }
}
