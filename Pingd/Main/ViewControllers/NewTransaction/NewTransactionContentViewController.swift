//
//  NewTransactionContentViewController.swift
//  Pingd
//
//  Created by David Acevedo on 9/11/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class NewTransactionContentViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var paymentTitle: UILabel!
    @IBOutlet weak var paymentSubtitle: UILabel!
    
    // MARK: - Properties
    var pageIndex = 0
    
    var iconImage: UIImage?
    var titleString: String?
    var subtitleString: NSMutableAttributedString?

    override func viewDidLoad() {
        super.viewDidLoad()

        print(iconImageView == nil)
        // Do any additional setup after loading the view.
        self.iconImageView.image = iconImage
        self.paymentTitle.text = titleString
        self.paymentSubtitle.attributedText = subtitleString
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
