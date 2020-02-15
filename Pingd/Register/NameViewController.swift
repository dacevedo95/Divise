//
//  NameViewController.swift
//  Pingd
//
//  Created by David Acevedo on 2/13/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var firstNameTextField: UITextField! {
        didSet {
            self.firstNameTextField.setUnderLine()
        }
    }
    @IBOutlet weak var lastNameTextField: UITextField! {
        didSet {
            self.lastNameTextField.setUnderLine()
        }
    }
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            self.nextButton.layer.cornerRadius = 25.0
        }
    }
    
    
    // MARK: - Properties
    var fieldOneHasText = false
    var fieldTwoHasText = false
    

    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.errorLabel.text = ""
        
        prefillTextFields()
        
        firstNameTextField.addTarget(self, action: #selector(firstTextFieldDidChange), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(secondTextFieldDidChange), for: .editingChanged)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.errorLabel.text = ""
        if segue.identifier == "toPasswordSegue" {
            let destinationVC = segue.destination as! PasswordViewController
            UserDefaults.standard.set(firstNameTextField.text, forKey: "firstName")
            UserDefaults.standard.set(lastNameTextField.text, forKey: "lastName")
            destinationVC.firstName = firstNameTextField.text!
            destinationVC.lastName = lastNameTextField.text!
        }
    }
    
    
    // MARK: - Helper Functions
    private func prefillTextFields() {
        let firstName = UserDefaults.standard.string(forKey: "firstName") ?? nil
        let lastName = UserDefaults.standard.string(forKey: "lastName") ?? nil
        // Pre-fills the fields
        if firstName != nil {
            firstNameTextField.text = firstName
            fieldOneHasText = true
        }
        if lastName != nil {
            lastNameTextField.text = lastName
            fieldTwoHasText = true
        }
        // Enables the button when there is text in both
        if firstName != nil && lastName != nil {
            self.nextButton.enable()
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}

extension NameViewController: UITextFieldDelegate {
    
    // MARK: - TextField Delegate Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            firstNameTextField.resignFirstResponder()
            lastNameTextField.becomeFirstResponder()
        } else {
            performSegue(withIdentifier: "toPasswordSegue", sender: self)
        }
        return true
    }
    
    
    // MARK: - Objective C Functions
    @objc func firstTextFieldDidChange(_ textField: UITextField) {
        if textField.text!.count == 0 {
            fieldOneHasText = false
        } else {
            fieldOneHasText = true
        }
        
        if fieldOneHasText && fieldTwoHasText {
            self.nextButton.enable()
        } else {
            self.nextButton.disable()
        }
    }
    
    @objc func secondTextFieldDidChange(_ textField: UITextField) {
        if textField.text!.count == 0 {
            fieldTwoHasText = false
        } else {
            fieldTwoHasText = true
        }
        
        if fieldOneHasText && fieldTwoHasText {
            self.nextButton.enable()
        } else {
            self.nextButton.disable()
        }
    }
}
