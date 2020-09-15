//
//  TransactionCarousel.swift
//  Pingd
//
//  Created by David Acevedo on 9/13/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import UIKit

class TransactionCarouselFlowLayout: UICollectionViewFlowLayout {
    
    private var previousOffset: CGFloat = 0
    private var currentPage: Int = 0

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let totalCellWidth = collectionView.frame.width * 0.85 // 352
        let benchmark = totalCellWidth / 2 // 176
        let proposedContentOffsetX = proposedContentOffset.x // 700

        let itemsCount = collectionView.numberOfItems(inSection: 0) // 3
        
        let rem = proposedContentOffsetX.truncatingRemainder(dividingBy: totalCellWidth) // 348
        var newContentOffsetX = rem < benchmark ? CGFloat(Int(proposedContentOffsetX / totalCellWidth)) * totalCellWidth : CGFloat(Int(proposedContentOffsetX / totalCellWidth) + 1) * totalCellWidth
        
        if newContentOffsetX < 0 {
            newContentOffsetX = 0.0
        }
        
        if newContentOffsetX > CGFloat(itemsCount - 1) * totalCellWidth {
            newContentOffsetX = CGFloat(itemsCount - 1) * totalCellWidth
        }
        
        return CGPoint(x: newContentOffsetX, y: proposedContentOffset.y)
    }
    
}

class TransactionCarousel: UICollectionView {
    
    private var data: [Transaction]?
    
    var cellWidthPercentage: CGFloat = 0.8
    var cellHeightPercentage: CGFloat = 0.9
    
    init() {
        // Creates the layout object
        let layout = TransactionCarouselFlowLayout()
        layout.scrollDirection = .horizontal
        // Initiates the super class
        super.init(frame: .zero, collectionViewLayout: layout)
        // sets properties for the parent class
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(TransactionCell.self, forCellWithReuseIdentifier: "transctionCell")
        self.showsHorizontalScrollIndicator = false
        
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TransactionCarousel: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sideInset = ((1.0 - cellWidthPercentage) / 2) * self.frame.width
        return UIEdgeInsets(top: 0.0, left: sideInset, bottom: 0, right: sideInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width * cellWidthPercentage
        let cellHeight = collectionView.frame.height * cellHeightPercentage
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ((1.0 - cellWidthPercentage) / 4) * self.frame.width
    }
    
}

extension TransactionCarousel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "transctionCell", for: indexPath) as! TransactionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 2
        
        if let transactionData = data {
            count = transactionData.count
        }
        
        return count + 1
    }
    
}
