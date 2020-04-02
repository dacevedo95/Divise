//
//  InsetLabel.swift
//  Pingd
//
//  Created by David Acevedo on 3/29/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import UIKit

class InsetLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 0.0))
        super.drawText(in: insetRect)
    }
    
}
