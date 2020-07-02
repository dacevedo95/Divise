//
//  viewss.swift
//  Pingd
//
//  Created by David Acevedo on 4/5/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import SnapKit
class viewss: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func setSmoothSelected(_ selected: Bool) {
        if selected {
            self.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        }else{
            self.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)

        }
        print(selected)
    }

}
