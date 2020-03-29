//
//  CategoryCell.swift
//  Pingd
//
//  Created by David Acevedo on 3/28/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import UIKit

struct CategoryData {
    var title: String
    var image: UIImage
    var backgroundColor: UIColor
}

class CategoryCell: UICollectionViewCell {
    
    var data: CategoryData? {
        didSet {
            guard let data = data else { return }
            
            categoryImageView.image = data.image
            titleLabel.text = data.title
            backgroundColor = data.backgroundColor
        }
    }
    
    fileprivate var isExpanded: Bool = false
    fileprivate var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Calendar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    fileprivate var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        categoryImageView.layer.cornerRadius = contentView.frame.height/5
        contentView.addSubview(categoryImageView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        categoryImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        categoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        categoryImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        categoryImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7).isActive = true
    }

}
