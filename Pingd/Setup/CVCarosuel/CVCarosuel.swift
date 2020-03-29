//
//  CVCarosuel.swift
//  Pingd
//
//  Created by David Acevedo on 3/28/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import UIKit

class CVCarosuel: UICollectionView {
    
    let data: [CategoryData] = [
        CategoryData(title: "Needs", image: #imageLiteral(resourceName: "Calendar"), backgroundColor: #colorLiteral(red: 0.6588235294, green: 0.6352941176, blue: 0.9294117647, alpha: 1)),
        CategoryData(title: "Wants", image: #imageLiteral(resourceName: "ShoppingBag"), backgroundColor: #colorLiteral(red: 0.7568627451, green: 0.6509803922, blue: 0.9333333333, alpha: 1)),
        CategoryData(title: "Savings", image: #imageLiteral(resourceName: "PiggyBank"), backgroundColor: #colorLiteral(red: 0.6078431373, green: 0.6745098039, blue: 0.9490196078, alpha: 1))
    ]
    
    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(CategoryCell.self, forCellWithReuseIdentifier: "categoryCell")
        self.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CVCarosuel: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.height, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        cell.data = self.data[indexPath.row]
        return cell
    }
    
    
}
