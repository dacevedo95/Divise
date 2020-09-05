//
//  NSLayoutConstraint.swift
//  Pingd
//
//  Created by David Acevedo on 9/2/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
