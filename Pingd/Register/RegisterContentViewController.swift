//
//  RegisterContentViewController.swift
//  Pingd
//
//  Created by David Acevedo on 1/20/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class RegisterContentViewController: UIViewController, UITextFieldDelegate {
    
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
    
    @IBOutlet weak var firstButton: UIButton! {
        didSet {
            self.firstButton.layer.cornerRadius = 20.0
        }
    }
    
    @IBOutlet weak var backButton: UIButton!
    
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
    var firstButtonTitle: String?
    var viewParent: RegisterPageViewController?
    
    var firstKeyboardType: UIKeyboardType?
    var secondKeyboardType: UIKeyboardType?
    
    var fieldOneHasText = false
    var fieldTwoHasText = false
    
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
        self.firstButton.setTitle(firstButtonTitle, for: .normal)
        self.firstButton.addTarget(viewParent, action: #selector(viewParent?.forwardPage), for: .touchUpInside)
        self.backButton.addTarget(viewParent, action: #selector(viewParent?.backwardPage), for: .touchUpInside)
        
        if !isOnlyOneField! {
            orLabel.alpha = 0.0
        }
        
        firstTextField.addTarget(self, action: #selector(firstTextFieldDidChange), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(secondTextFieldDidChange), for: .editingChanged)
        
        self.firstTextField.keyboardType = firstKeyboardType!
        self.secondTextField.keyboardType = secondKeyboardType!
        
    }
    
    @objc func firstTextFieldDidChange(_ textField: UITextField) {
        if textField.text!.count == 0 {
            fieldOneHasText = false
        } else {
            fieldOneHasText = true
        }
        
        if fieldOneHasText && fieldTwoHasText {
            self.firstButton.enable()
        } else {
            self.firstButton.disable()
        }
    }
    
    @objc func secondTextFieldDidChange(_ textField: UITextField) {
        print(textField.text!.count)
        if textField.text!.count == 0 {
            fieldTwoHasText = false
        } else {
            fieldTwoHasText = true
        }
        
        print(fieldTwoHasText)
        if fieldOneHasText && fieldTwoHasText {
            self.firstButton.enable()
        } else {
            self.firstButton.disable()
        }
    }
}
