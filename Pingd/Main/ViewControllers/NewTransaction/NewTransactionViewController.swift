//
//  NewTransactionViewController.swift
//  Pingd
//
//  Created by David Acevedo on 9/11/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class NewTransactionViewController: UIViewController, NewTransactionPageViewControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var staticLabel: UILabel! {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 7.0
            
            let attrString = NSMutableAttributedString(string: "How frequent are these payment(s)?")
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
            
            staticLabel.attributedText = attrString
        }
    }
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var selectButton: UIButton!{
        didSet {
            self.selectButton.layer.cornerRadius = self.selectButton.frame.height / 2
        }
    }
    
    // MARK: - Properties
    var pageControl = UIPageControl()
    var newTransactionPageViewController: NewTransactionPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        let yIndex = bottomView.frame.origin.y
        // Do any additional setup after loading the view.
        pageControl = UIPageControl(frame: CGRect(x: 0, y: yIndex, width: UIScreen.main.bounds.width, height: 50.0))
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.32)
        pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    func updatePageIndex(currentIndex: Int) {
        if let index = newTransactionPageViewController?.currentIndex {
            pageControl.currentPage = index
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
        if let pageViewController = destination as? NewTransactionPageViewController {
            newTransactionPageViewController = pageViewController
            newTransactionPageViewController?.newTeansactionDelegate = self
        }
    }

}
