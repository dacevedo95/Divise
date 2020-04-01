//
//  BudgetSelectorViewController.swift
//  Pingd
//
//  Created by David Acevedo on 3/22/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class BudgetSelectorViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var topStaticLabel: InsetLabel!{
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5.0
            
            let attrString = NSMutableAttributedString(string: topStaticLabel.text!)
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
            
            topStaticLabel.attributedText = attrString
        }
    }
    
    let data: [CustomData] = [
        CustomData(title: "signs", image: #imageLiteral(resourceName: "Calendar"), bgColor: #colorLiteral(red: 0.6588235294, green: 0.6352941176, blue: 0.9294117647, alpha: 1)),
        CustomData(title: "grafetti", image: #imageLiteral(resourceName: "ShoppingBag"), bgColor: #colorLiteral(red: 0.7568627451, green: 0.6509803922, blue: 0.9333333333, alpha: 1)),
        CustomData(title: "view", image: #imageLiteral(resourceName: "PiggyBank"), bgColor: #colorLiteral(red: 0.6078431373, green: 0.6745098039, blue: 0.9490196078, alpha: 1))
    ]
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cv.backgroundColor = .blue
        
        return cv
    }()
    
    var previousIndex: Int = 0
    var selectedIndex: Int = 0
    
    var xPos: CGFloat = 0.0
    var xPosSelected: CGFloat = 0.0
    
    let sideMargins: CGFloat = 20.0
    let spacingMargin: CGFloat = 10.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        container.addSubview(collectionView)
        
        collectionView.backgroundColor = .clear
        collectionView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 1.0).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension BudgetSelectorViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = container.frame.width - (2 * sideMargins)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Basic logging stuff
        print("Getting Cell")
        print(previousIndex)
        print(selectedIndex)
        
        // Gets the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        
        // Sets the shadow for each cell
        cell.layer.cornerRadius = 20.0
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4.0
        cell.data = self.data[indexPath.row]
        
        // We calculate the view width as the width of the phone minus the side margins
        let viewWidth = container.frame.width - (2 * sideMargins)
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
            
            
            
//            UIView.animate(withDuration: 0.2) {
//                cell.frame = CGRect(x: self.xPosSelected, y: cell.frame.origin.y, width: 2 * cellWidth + self.spacingMargin, height: cellWidth)
//            }
            xPosSelected += 2 * cellWidth + spacingMargin
        } else {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                cell.frame = CGRect(x: self.xPosSelected, y: cell.frame.origin.y, width: cellWidth, height: cellWidth)
            }, completion: nil)
            
//            UIView.animate(withDuration: 0.2) {
//                cell.frame = CGRect(x: self.xPosSelected, y: cell.frame.origin.y, width: cellWidth, height: cellWidth)
//            }
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
        print("Clicked")
        selectedIndex = indexPath.row
        
        xPos = 0
        xPosSelected = 0
        
        collectionView.reloadData()
    }
    
}

struct CustomData {
    var title: String
    var image: UIImage
    var bgColor: UIColor
}

class CustomCell: UICollectionViewCell {
    
    var data: CustomData? {
        didSet {
            guard let data = data else { return }
            // bg.image = data.image
            self.backgroundColor = data.bgColor
        }
    }
    
    fileprivate let bg: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    var isExpanded: Bool = false
    
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
    
    override func willTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout) {
        print("transitioning")
    }
}

class CategoryCell: UICollectionViewCell {
    
    var categoryImageView: UIImageView = UIImageView()
    var categoryTitle: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func willTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout) {
        print("transitioning")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
