//
//  BudgetSelectorViewController.swift
//  Pingd
//
//  Created by David Acevedo on 3/22/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class BudgetSelectorViewController: UIViewController {

    // MARK: - Outlets
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
    @IBOutlet weak var bottomView: UIView! {
        didSet {
            self.bottomView.backgroundColor = .clear
        }
    }
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            self.nextButton.layer.cornerRadius = 25.0
            self.nextButton.enable()
        }
    }
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            self.backButton.layer.cornerRadius = 25.0
        }
    }
    
    private let collectionView: CVSelector = {
        return CVSelector()
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
        
        let roundedView = RoundedView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: bottomView.frame.size.height + 44))
        bottomView.insertSubview(roundedView, at: 0)
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


