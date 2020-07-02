//
//  CVNumberScroler.swift
//  Pingd
//
//  Created by David Acevedo on 4/12/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class CVNumberScroller: UICollectionView {
    
    let layout: UICollectionViewFlowLayout = {
        let _layout = UICollectionViewFlowLayout()
        _layout.scrollDirection = .horizontal
        
        return _layout
    }()
    
    private var startIndex = 0
    private var length = 100
    
    private let cellIdentifer = "cell";
    
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        
        register(ScrollerCell.self, forCellWithReuseIdentifier: cellIdentifer)
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CVNumberScroller: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = (superview?.frame.height)!
        let cellWidth = (superview?.frame.width)! / 5
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}

extension CVNumberScroller: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return length
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // dequeues the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifer, for: indexPath) as! ScrollerCell
        
        let offsetNumber = indexPath.row + startIndex
        cell.number = offsetNumber
        
        // returns the call
        return cell
    }
    
}
