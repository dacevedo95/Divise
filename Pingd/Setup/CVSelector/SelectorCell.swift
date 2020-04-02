//
//  SelectorCell.swift
//  Pingd
//
//  Created by David Acevedo on 4/2/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import UIKit

struct SelectorData {
    var image: UIImage
    var bgColor: UIColor
    var title: String
    var description: String
}

class SelectorCell: UICollectionViewCell {
    
    var isExpanded: Bool = false
    var data: SelectorData? {
        didSet {
            guard let data = data else { return }
            // bg.image = data.image
            self.backgroundColor = data.bgColor
        }
    }
    
    private let bg: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bg)
        
        bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bg.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        bg.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        bg.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
