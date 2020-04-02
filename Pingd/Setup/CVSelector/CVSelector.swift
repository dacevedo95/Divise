//
//  CVSelector.swift
//  Pingd
//
//  Created by David Acevedo on 4/2/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import UIKit



class CVSelector: UICollectionView {
    
    private let data: [SelectorData] = [
        SelectorData(image: #imageLiteral(resourceName: "Calendar"), bgColor: #colorLiteral(red: 0.6588235294, green: 0.6352941176, blue: 0.9294117647, alpha: 1), title: "Needs", description: "The things in your life that are absolutely neccesary"),
        SelectorData(image: #imageLiteral(resourceName: "ShoppingBag"), bgColor: #colorLiteral(red: 0.7568627451, green: 0.6509803922, blue: 0.9333333333, alpha: 1), title: "Wants", description: "The things in your life that are nice to have, but not neccesary"),
        SelectorData(image: #imageLiteral(resourceName: "PiggyBank"), bgColor: #colorLiteral(red: 0.6078431373, green: 0.6745098039, blue: 0.9490196078, alpha: 1), title: "Savings", description: "The money left over to invest or pay off any debts")
    ]
    
    private var previousIndex: Int = 0
    private var selectedIndex: Int = 0
    private var xPos: CGFloat = 0.0
    private var xPosSelected: CGFloat = 0.0
    
    let sideMargins: CGFloat = 20.0
    let spacingMargin: CGFloat = 10.0
    
    init() {
        let layout =  UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(SelectorCell.self, forCellWithReuseIdentifier: "selectorCell")
        self.showsHorizontalScrollIndicator = false
        self.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CVSelector: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = superview!.frame.width - (2 * sideMargins)
        let cellWidth = (viewWidth - (3 * spacingMargin)) / 4
        
        if indexPath.row == 0 {
            return CGSize(width: 2 * cellWidth + 10, height: cellWidth)
        } else {
            return CGSize(width: cellWidth, height: cellWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacingMargin
    }
}

extension CVSelector: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Gets the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectorCell", for: indexPath) as! SelectorCell
        
        // Sets the shadow for each cell
        cell.layer.cornerRadius = 20.0
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4.0
        cell.data = data[indexPath.row]
        
        // We calculate the view width as the width of the phone minus the side margins
        let viewWidth = superview!.frame.width - (2 * sideMargins)
        // We then calculate the cell width
        let cellWidth = (viewWidth - (3 * spacingMargin)) / 4
        
        // Initiates the cells based on their previous index
        if indexPath.row == previousIndex {
            cell.frame = CGRect(x: xPos, y: cell.frame.origin.y, width: 2 * cellWidth + spacingMargin, height: cellWidth)
            xPos += 2 * cellWidth + spacingMargin
        } else {
            cell.frame = CGRect(x: xPos, y: cell.frame.origin.y, width: cellWidth, height: cellWidth)
            xPos += cellWidth
        }
        xPos += spacingMargin
        
        // Calculate destination frames
        if indexPath.row == selectedIndex {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                cell.frame = CGRect(x: self.xPosSelected, y: cell.frame.origin.y, width: 2 * cellWidth + self.spacingMargin, height: cellWidth)
            }, completion: nil)
            xPosSelected += 2 * cellWidth + spacingMargin
        } else {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                cell.frame = CGRect(x: self.xPosSelected, y: cell.frame.origin.y, width: cellWidth, height: cellWidth)
            }, completion: nil)
            xPosSelected += cellWidth
        }
        xPosSelected += spacingMargin
        
        // Updates the index and returns the cell
        if indexPath.row == data.count - 1 {
            previousIndex = selectedIndex
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        
        xPos = 0
        xPosSelected = 0
        
        collectionView.reloadData()
    }
}
