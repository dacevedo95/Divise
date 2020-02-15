//
//  PhoneInputViewController.swift
//  Pingd
//
//  Created by David Acevedo on 2/10/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import PhoneNumberKit

class PhoneInputViewController: UIViewController {
    
    var createUser: Bool?
    var phoneNumberKit: PhoneNumberKit?
    var updateUser: Bool?
    
    // MARK: - Outlets
    @IBOutlet weak var phoneTextField: PhoneNumberTextField! {
        didSet {
            phoneTextField.withExamplePlaceholder = true
        }
    }
    
    @IBOutlet weak var verifyBtn: UIButton! {
        didSet {
            verifyBtn.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""

        // Do any additional setup after loading the view.
        phoneTextField.becomeFirstResponder()
        phoneNumberKit = PhoneNumberKit()
        
        // Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !phoneNumberKit!.isValidPhoneNumber(phoneTextField.text!) {
            // Show Error culd not send verification
            errorLabel.text = "Please enter a valid phone number to proceed"
            return false
        }
        
        do {
            let phoneNumber = try phoneNumberKit!.parse(phoneTextField.text!)
            if !sendVerification(countryCode: String(phoneNumber.countryCode), phoneNumber: String(phoneNumber.nationalNumber)) {
                // Show Error culd not send verification
                errorLabel.text = "An error occured. Please try again later"
                return false
            }
            if !userAvailable(phoneNumber: String(phoneNumber.nationalNumber)) {
                // Show Error culd not send verification
                errorLabel.text = "This phone number already belongs to a user. Please sign in or reset your password"
                return false
            }
        } catch {
            // Show Error culd not send verification
            errorLabel.text = "An error occured. Please try again later"
            return false
        }
        
        return true
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    private func sendVerification(countryCode: String, phoneNumber: String) -> Bool {
        // TODO: Implement verification call
        return true
    }
    
    private func userAvailable(phoneNumber: String) -> Bool {
        // TODO: Make exists call
        return true
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
        let destinationVC = segue.destination as! VerifyViewController
        destinationVC.createUser = createUser
        
        errorLabel.text = ""
        do {
            let vc = segue.destination as! VerifyViewController
            let phoneNumber = try phoneNumberKit!.parse(phoneTextField.text!)
            vc.countryCode = phoneNumber.countryCode
            vc.phoneNumber = phoneNumber.nationalNumber
            vc.formattedNumber = phoneTextField.text!
        } catch {
            errorLabel.text = "An error occured. Please try again later"
            print("Error")
        }
    }

}
