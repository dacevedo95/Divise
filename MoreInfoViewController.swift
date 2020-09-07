//
//  MoreInfoViewController.swift
//  Pingd
//
//  Created by David Acevedo on 9/2/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//
import UIKit

class MoreInfoViewController: UIViewController, MoreInfoPageViewControllerDelegate {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var closeButtonView: UIView!
    
    var pageControl = UIPageControl()
    
    var moreInfoPageViewController: MoreInfoPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let yIndex = closeButtonView.frame.origin.y - 50.0
        // Do any additional setup after loading the view.
        pageControl = UIPageControl(frame: CGRect(x: 0, y: yIndex, width: UIScreen.main.bounds.width, height: 50))
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.32)
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        if let index = moreInfoPageViewController?.currentIndex {
            pageControl.currentPage = index
        }
    }
    
    func updateBackground(backgroundColor: UIColor) {
        // self.view.backgroundColor = backgroundColor
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
        
        if let pageViewController = destination as? MoreInfoPageViewController {
            moreInfoPageViewController = pageViewController
            moreInfoPageViewController?.moreInfoDelegate = self
        }
    }

}
