//
//  RoundedView.swift
//  Pingd
//
//  Created by David Acevedo on 3/25/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    
    var fillColor = UIColor(red: 168, green: 162, blue: 237)
    var fillLayer = CAShapeLayer()
    var maskLayer = CAShapeLayer()
    
    func changeBackgroundColor(to color: UIColor) {
        fillLayer.fillColor = color.cgColor
    }
    
    override func layoutSubviews() {
        let path = generatePath()
        
        fillLayer.path = path.cgPath
        maskLayer.path = path.cgPath
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fillLayer.fillColor = fillColor.cgColor
        fillLayer.fillRule = .evenOdd
        
        layer.addSublayer(fillLayer)
        
        maskLayer.fillRule = .evenOdd
        layer.mask = maskLayer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func generatePath() -> UIBezierPath {
        let path = UIBezierPath(roundedRect: frame, byRoundingCorners: .topLeft, cornerRadii: CGSize(width: frame.size.width/7, height: 0.0))
        return path
    }
    
}
