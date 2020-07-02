//
//  ScrollerCell.swift
//  Pingd
//
//  Created by David Acevedo on 4/12/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class ScrollerCell: UICollectionViewCell {
    
    var number: Int? {
        didSet {
            self.label.text = self.number?.description
        }
    }
    
    private var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
