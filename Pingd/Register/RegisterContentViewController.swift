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
    
    @IBOutlet weak var errorLabel: UILabel!
    
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

        // Here we assign all the fields now that the UI Elements have been initialized
        self.headerLabel.text = header!
        self.subheaaderLabel.text = subheader!
        self.firstTextFieldLabel.text = firstFieldName!
        self.firstTextField.placeholder = firstFieldPlaceHolder!
        self.secondTextFieldLabel.text = secondFieldName!
        self.secondTextField.placeholder = secondFieldPlaceHolder!
        self.firstImage.image = UIImage(named: firstImageName!)
        self.secondImage.image = UIImage(named: secondImageName!)
        self.firstButton.setTitle(firstButtonTitle, for: .normal)
        self.firstButton.addTarget(self, action: #selector(firstButtonPressed), for: .touchUpInside)
        self.backButton.addTarget(viewParent, action: #selector(viewParent?.backwardPage), for: .touchUpInside)
        
        // Blanks the field if both fields are required
        if !isOnlyOneField! {
            orLabel.alpha = 0.0
        }
        
        // Adds a textfield listener
        firstTextField.addTarget(self, action: #selector(firstTextFieldDidChange), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(secondTextFieldDidChange), for: .editingChanged)
        
        // Assigns a type to the keyboard
        self.firstTextField.keyboardType = firstKeyboardType!
        self.secondTextField.keyboardType = secondKeyboardType!
        
        // Initializes the error label with nothing
        self.errorLabel.text = ""
        
        // Sets the password fields to secure entry
        if viewParent?.currentIndex == 2 {
            self.firstTextField.isSecureTextEntry = true
            self.secondTextField.isSecureTextEntry = true
        }
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
        if textField.text!.count == 0 {
            fieldTwoHasText = false
        } else {
            fieldTwoHasText = true
        }
        
        if fieldOneHasText && fieldTwoHasText {
            self.firstButton.enable()
        } else {
            self.firstButton.disable()
        }
        
        if viewParent?.currentIndex == 2 {
            if !fieldOneHasText {
                showErrorMessage(message: "Password must have one capital, one lowercase, and one number")
            }
        }
    }
    
    @objc func firstButtonPressed(sender: UIButton!) {
        // Clears error label
        self.errorLabel.text = ""
        
        // Handles the validation first
        switch viewParent?.currentIndex {
        case 1:
            if !(firstTextField.text?.contains("@"))! || !(firstTextField.text?.contains("."))! {
                showErrorMessage(message: "Invalid email. Email must contain \"@\" and a domain")
                return
            }
            // Make call to see if email and phone are unused
        case 2:
            if firstTextField.text != secondTextField.text {
                showErrorMessage(message: "Password fields must match")
                return
            }
            if !isValidPassword(password: firstTextField.text!) {
                showErrorMessage(message: "Passwords need at least 8 characters, one capital, one lowercase, and one digit")
                return
            }
            return
        default:
            break
        }
        
        // Goes forward page
        viewParent?.forwardPage()
    }
    
    // MARK:: Private Functions
    private func showErrorMessage(message: String) {
        self.errorLabel.text = message
    }
    
    func isValidPassword(password: String?) -> Bool {
        guard password != nil else { return false }
     
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: password)
    }
}