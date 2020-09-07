//
//  MoreInfoContentViewController.swift
//  Pingd
//
//  Created by David Acevedo on 9/2/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//
import UIKit

class MoreInfoContentViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var firstExampleView: UIView! {
        didSet {
            self.firstExampleView.layer.cornerRadius = self.firstExampleView.frame.height / 2
        }
    }
    @IBOutlet weak var secondExampleView: UIView! {
        didSet {
            self.secondExampleView.layer.cornerRadius = self.secondExampleView.frame.height / 2
        }
    }
    @IBOutlet weak var thirdExampleView: UIView! {
        didSet {
            self.thirdExampleView.layer.cornerRadius = self.thirdExampleView.frame.height / 2
        }
    }
    
    @IBOutlet weak var firstExampleLabel: UILabel!
    @IBOutlet weak var secondExampleLabel: UILabel!
    @IBOutlet weak var thirdExampleLabel: UILabel!
    
    @IBOutlet weak var askMoreTitleLabel: UILabel!
    @IBOutlet weak var firstAskMoreView: UIView! {
        didSet {
            self.firstAskMoreView.layer.cornerRadius = self.firstAskMoreView.frame.height / 2
        }
    }
    @IBOutlet weak var secondAskMoreView: UIView! {
        didSet {
            self.secondAskMoreView.layer.cornerRadius = self.secondAskMoreView.frame.height / 2
        }
    }
    
    @IBOutlet weak var firstAskMoreLabel: UILabel!
    @IBOutlet weak var secondAskMoreLabel: UILabel!
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var subcategoryTitleLabel: UILabel!
    
    // MARK: - Properties
    var pageIndex = 0
    
    let smallerHeightMultiplier = CGFloat(0.14)
    let biggerHeightMultiplier = CGFloat(0.36)
    
    var stackView: UIStackView?
    
    var backgroundColor: UIColor?
    var categoryIcon: UIImage?
    var categoryTitle: String?
    var subcategoryTitle: String?
    
    var itemColorBackground: UIColor?
    
    var examples: [String]?
    
    var askMoreTitle: String?
    var askMoreLabels: [String?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets all the base stuff
        self.view.backgroundColor = backgroundColor
        self.categoryImageView.image = categoryIcon
        self.categoryTitleLabel.text = categoryTitle
        self.subcategoryTitleLabel.text = subcategoryTitle
        
        self.firstExampleView.backgroundColor = itemColorBackground
        self.secondExampleView.backgroundColor = itemColorBackground
        self.thirdExampleView.backgroundColor = itemColorBackground
        
        if let examples = examples {
            self.firstExampleLabel.text = examples[0]
            self.secondExampleLabel.text = examples[1]
            self.thirdExampleLabel.text = examples[2]
        }
        
        self.askMoreTitleLabel.text = askMoreTitle
        
        self.firstAskMoreView.backgroundColor = itemColorBackground
        if let askMore = askMoreLabels {
            if askMore[1] == nil {
                secondAskMoreView.alpha = 0.0
            } else {
                secondAskMoreView.alpha = 1.0
                self.secondAskMoreView.backgroundColor = itemColorBackground
            }
            
            firstAskMoreLabel.text = askMore[0] ?? ""
            secondAskMoreLabel.text = askMore[1] ?? ""
        }
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
