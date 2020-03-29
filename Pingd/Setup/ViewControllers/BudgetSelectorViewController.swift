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
    
    let data = [
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
        cv.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        return cv
    }()
    
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
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return container.frame.height / 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.data = self.data[indexPath.row]
        cell.layer.cornerRadius = 20.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.data = self.data[indexPath.row]
        print(cell.data?.title ?? "")
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
            bg.image = data.image
            self.backgroundColor = data.bgColor
        }
    }
    
    fileprivate let bg: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "ShoppingBag")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    fileprivate var view: UIView = {
       return UIView()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bg)
        
        bg.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        bg.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        bg.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        bg.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
