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
    
    
    // MARK: - Properties
    var pageIndex = 0
    
    let smallerHeightMultiplier = CGFloat(0.14)
    let biggerHeightMultiplier = CGFloat(0.36)
    
    var stackView: UIStackView?
    
    var backgroundColor: UIColor? = #colorLiteral(red: 0.6588235294, green: 0.6352941176, blue: 0.9294117647, alpha: 1)
    var categoryTitle: String? = "Needs"
    var subcategoryTitle: String? = "The things in your life that are absolutely neccesary"
    
    var itemColorBackground: UIColor? = #colorLiteral(red: 0.7450980392, green: 0.7254901961, blue: 0.9568627451, alpha: 1)
    
    var askMoreTitle: String? = "Not sure? Ask this:"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
