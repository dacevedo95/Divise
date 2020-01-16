//
//  OnboardingContentViewController.swift
//  Pingd
//
//  Created by David Acevedo on 1/15/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class OnboardingContentViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var headingLabel: UILabel! {
        didSet {
            self.headingLabel.numberOfLines = 0
        }
    }
    @IBOutlet var subheadingLabel: UILabel! {
        didSet {
            self.subheadingLabel.numberOfLines = 0
        }
    }
    @IBOutlet var contentImageView: UIImageView!
    
    // MARK: - Properties
    var pageIndex = 0
    var heading: String?
    var subheading: String?
    var imageFileName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headingLabel.text = heading!
        subheadingLabel.text = subheading!
        contentImageView.image = UIImage(named: imageFileName!)
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
