//
//  RoundedView.swift
//  Pingd
//
//  Created by David Acevedo on 3/25/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let shape = CAShapeLayer()
        shape.fillColor = UIColor(red: 168, green: 162, blue: 237).cgColor
        
        let viewPath = generatePath()
        shape.path = viewPath.cgPath
        self.layer.addSublayer(shape)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func generatePath() -> UIBezierPath {
        let path = UIBezierPath(roundedRect: frame,
                                byRoundingCorners: .topLeft,
                                cornerRadii: CGSize(width: frame.size.width/5, height: 0.0))
        
        return path
    }
    
}
