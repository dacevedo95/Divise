//
//  NameViewController.swift
//  Pingd
//
//  Created by David Acevedo on 2/13/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import os

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
        // Initial work that needs to be ddone
        super.viewDidLoad()
        self.errorLabel.text = ""
        
        // Prefills the text from the UserDefaults
        prefillTextFields()
        
        // Adds listeners to the textfields
        firstNameTextField.addTarget(self, action: #selector(firstTextFieldDidChange), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(secondTextFieldDidChange), for: .editingChanged)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Sets up this class as a delegate
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Logs preparing the segues
        os_log("preparing segue with id: %{public}s", log: Log.view, type: .info, segue.identifier ?? "no value")
        
        // Resets the error label
        self.errorLabel.text = ""
        
        if segue.identifier == "toVerifySegue" {
            // Logs entry into the code block
            os_log("segue toVerifySegue triggered", log: Log.view, type: .debug)
            
            // Gets the destination controller and assigns name to user defaults
            let destinationVC = segue.destination as! PhoneInputViewController
            UserDefaults.standard.set(firstNameTextField.text, forKey: "firstName")
            UserDefaults.standard.set(lastNameTextField.text, forKey: "lastName")
            os_log("Storing firstName: %s, lastName %s to UserDefaults",
                   log: Log.view, type: .debug,
                   firstNameTextField.text ?? "no value", lastNameTextField.text ?? "no value")
            
            // Sends the info to the destination segue
            destinationVC.createUser = true
            destinationVC.firstName = firstNameTextField.text!
            destinationVC.lastName = lastNameTextField.text!
            // Logs the info
            os_log("Sending createUser: %s, firstName: %s, lastName: %s to PhoneInputViewController",
                   log: Log.view, type: .info,
                   true.description, firstNameTextField.text ?? "no value", lastNameTextField.text ?? "no value")
        }
    }
    
    
    // MARK: - Helper Functions
    private func prefillTextFields() {
        // Gets the value from UserDefaults
        let firstName = UserDefaults.standard.string(forKey: "firstName") ?? nil
        let lastName = UserDefaults.standard.string(forKey: "lastName") ?? nil
        
        // Logs the prefilled field
        os_log("Prefilling fields with firstName: %s, lastName: %s", log: Log.view, type: .debug, firstName ?? "no value", lastName ?? "no value")
        
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
            // Logs that we are performing a segue
            os_log("Performing segue toVerifySegue", log: Log.view, type: .info)
            performSegue(withIdentifier: "toVerifySegue", sender: self)
        }
        return true
    }
    
    
    // MARK: - Objective C Functions
    @objc func firstTextFieldDidChange(_ textField: UITextField) {
        errorLabel.text = ""
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
        errorLabel.text = ""
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
