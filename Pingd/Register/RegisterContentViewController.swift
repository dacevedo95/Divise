//
//  RegisterContentViewController.swift
//  Pingd
//
//  Created by David Acevedo on 1/20/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class RegisterContentViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subheaaderLabel: UILabel!
    @IBOutlet weak var firstTextFieldLabel: UILabel!
    @IBOutlet weak var secondTextFieldLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    
    @IBOutlet weak var firstTextField: UITextField! {
        didSet {
            self.firstTextField.setUnderLine()
        }
    }
    
    @IBOutlet weak var secondTextField: UITextField! {
        didSet {
            self.secondTextField.setUnderLine()
        }
    }
    
    // MARK: - Properties
    var pageIndex = 0
    var header: String?
    var subheader: String?
    var firstFieldName: String?
    var firstImageName: String?
    var firstFieldPlaceHolder: String?
    var secondFieldName: String?
    var secondImageName: String?
    var secondFieldPlaceHolder: String?
    var isOnlyOneField: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.headerLabel.text = header!
        self.subheaaderLabel.text = subheader!
        self.firstTextFieldLabel.text = firstFieldName!
        self.firstTextField.placeholder = firstFieldPlaceHolder!
        self.secondTextFieldLabel.text = secondFieldName!
        self.secondTextField.placeholder = secondFieldPlaceHolder!
        self.firstImage.image = UIImage(named: firstImageName!)
        self.secondImage.image = UIImage(named: secondImageName!)
        
        if !isOnlyOneField! {
            orLabel.alpha = 0.0
        }
    }
}
