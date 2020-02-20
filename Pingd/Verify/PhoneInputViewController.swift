//
//  PhoneInputViewController.swift
//  Pingd
//
//  Created by David Acevedo on 2/10/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import PhoneNumberKit
import Alamofire
import SwiftyJSON
import os

class PhoneInputViewController: UIViewController {
    
    var firstName: String?
    var lastName: String?
    
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
    
    /*
    // MARK: - Lifecycle Functions
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""

        // Do any additional setup after loading the view.
        phoneTextField.becomeFirstResponder()
        phoneNumberKit = PhoneNumberKit()
        phoneTextField.delegate = self
        
        // Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Logs the inputs received when loading
        os_log("PhoneInputViewController loaded with createUser: %{public}s, firstName: %s, firstName: %s",
               log: Log.view, type: .info, createUser?.description ?? "no value", firstName ?? "no value", lastName ?? "no value")
    }
    
    
    // MARK: Private Functions
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Logs the segue being prepared
        os_log("Preparing for segue %{public}s", log: Log.view, type: .info, segue.identifier ?? "no value")
        
        if segue.identifier == "checkVerificationSegue" {
            // Logs that we are within this code block
            os_log("In code block for segue identifier checkVerificationSegue", log: Log.view, type: .debug)
            
            // Gets the destination view controller
            let destinationVC = segue.destination as! VerifyViewController
            
            // Assigns the variables to the destination controller
            destinationVC.createUser = createUser
            if createUser! {
                os_log("createUser flag is true", log: Log.view, type: .debug)
                destinationVC.firstName = firstName
                destinationVC.lastName = lastName
                os_log("Assigning firstName: %s, lastName: %s to VerifyViewController", log: Log.view, type: .info, firstName ?? "no value", lastName ?? "no value")
            }
            // Logs that what value we have sent to the VerifyViewController
            os_log("Assigning createUser: %{public}s to VerifyViewController", log: Log.view, type: .info, createUser?.description ?? "no value")
            
            // Resets the error label
            errorLabel.text = ""
            
            // Sends the phone information to the VerifyViewController
            do {
                let phoneNumber = try phoneNumberKit!.parse(phoneTextField.text!)
                destinationVC.countryCode = phoneNumber.countryCode
                destinationVC.phoneNumber = phoneNumber.nationalNumber
                destinationVC.formattedNumber = phoneTextField.text!
                os_log("Sending countryCode: %s, phoneNumber: %s, formattedNumber: %s to VerifyViewController", log: Log.view, type: .info, phoneNumber.countryCode.description, phoneNumber.nationalNumber.description, phoneTextField.text ?? "no value")
            } catch {
                // Sets the error label that something unexpected happened
                errorLabel.text = "An error occured. Please try again later"
                // Logs the error
                os_log("Error sending phone number information to VerifyViewController: %{public}s", log: Log.view, type: .error, error.localizedDescription)
            }
        }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        // Logs the entry into the button
        os_log("Back button pressed", log: Log.view, type: .debug)
        
        // Performs a segue based on its previous screen
        if createUser! {
            // Logs info and performs the segue to toNameSegue
            os_log("Performing segue to toNameSegue", log: Log.view, type: .info)
            performSegue(withIdentifier: "toNameSegue", sender: self)
        } else {
            // Logs info and performs the segue to toLoginSegue
            os_log("Performing segue to toLoginSegue", log: Log.view, type: .info)
            performSegue(withIdentifier: "toLoginSegue", sender: self)
        }
    }
    
    @IBAction func verifyClicked(_ sender: Any) {
        // Logs entry into the action function
        os_log("Verify button clicked", log: Log.view, type: .debug)
        
        // Checks if the phone number entered is valid
        if !phoneNumberKit!.isValidPhoneNumber(phoneTextField.text!) {
            // Show Error could not send verification
            errorLabel.text = "Please enter a valid phone number to proceed"
            os_log("Valid phone number entered: %s", log: Log.view, type: .error, phoneTextField.text ?? "No value")
        } else {
            do {
                let phoneNumber = try phoneNumberKit!.parse(phoneTextField.text!)
                if createUser! {
                    userDoesExist(countryCode: String(phoneNumber.countryCode), phoneNumber: String(phoneNumber.nationalNumber))
                } else {
                    sendVerification(countryCode: String(phoneNumber.countryCode), phoneNumber: String(phoneNumber.nationalNumber))
                }
            } catch {
                // Show Error could not send verification
                errorLabel.text = "An error occured. Please try again later"
                // Logs the error
                os_log("Error checking if user exists: %{public}s", log: Log.view, type: .error, error.localizedDescription)
            }
        }
    }
}


// MARK: API Calls
extension PhoneInputViewController {
    // Data model for checking if a user exists
    struct userExists: Encodable {
        let countryCode: String
        let phoneNumber: String
    }
    
    private func userDoesExist(countryCode: String, phoneNumber: String) {
        // Logs the entry into the function
        os_log("in userDoesExist", log: Log.view, type: .debug)
        
        // Sets up url and body for the request
        let checkUserURL = "http://PingdBackend-dev.us-east-1.elasticbeanstalk.com/api/v1/users/exists"
        let user = userExists(countryCode: countryCode, phoneNumber: phoneNumber)
        
        // Starts the signpost
        let signpostID = OSSignpostID(log: Log.networking)
        os_signpost(.begin, log: Log.networking, name: "Check User Exists", signpostID: signpostID, "Sending request with countryCode: %s, phoneNumber %s", user.countryCode, user.phoneNumber)
        
        // Performs the request
        AF.request(checkUserURL, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                // Determines what action to take based on the result
                switch response.result {
                case let .success(data):
                    do {
                        // Gets the body to a JSON format
                        let body = try JSON(data: data)
                        
                        // Checks if the user does exist
                        if body["exists"].boolValue {
                            // Sets the error label
                            self.errorLabel.text = "This phone number is already registered to a user. Please sign in"
                            // Logs the end of the signpost
                            os_signpost(.end, log: Log.networking, name: "Check User Exists", signpostID: signpostID, "This phone number is already registered to a user")
                        } else {
                            // Logs the end of the signpost
                            os_signpost(.end, log: Log.networking, name: "Check User Exists", signpostID: signpostID, "User does not exist, sending verification")
                            // Send Verification Code
                            self.sendVerification(countryCode: countryCode, phoneNumber: phoneNumber)
                        }
                    } catch {
                        // Sets the error label
                        self.errorLabel.text = "An error occured. Please try again later"
                        // Logs the end of the signpost
                        os_signpost(.end, log: Log.networking, name: "Check User Exists", signpostID: signpostID, "Error checking success result: %{public}s", error.localizedDescription)
                    }
                    // Breaks
                    break
                case let .failure(error):
                    // Sets the error label
                    self.errorLabel.text = "An error occured. Please try again later"
                    // Logs the end of the signpost
                    os_signpost(.end, log: Log.networking, name: "Check User Exists", signpostID: signpostID, "Error checking success result: %{public}s", error.localizedDescription)
                    // Breaks
                    break
                }
            }
    }
    
    private func sendVerification(countryCode: String, phoneNumber: String) {
        // Logs entry into the function
        os_log("in sendVerification", log: Log.view, type: .debug)
        
        // Sets up url and body for the request
        let sendVerificationURL = "http://PingdBackend-dev.us-east-1.elasticbeanstalk.com/api/v1/users/verification"
        let user = userExists(countryCode: countryCode, phoneNumber: phoneNumber)
        
        // Starts the signpost
        let signpostID = OSSignpostID(log: Log.networking)
        os_signpost(.begin, log: Log.networking, name: "Send Verification", signpostID: signpostID, "Sending request with countryCode: %s, phoneNumber %s", user.countryCode, user.phoneNumber)
        
        // Performs the request
        AF.request(sendVerificationURL, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    // Logs the success message
                    os_signpost(.end, log: Log.networking, name: "Send Verification", signpostID: signpostID, "Verification sent successfully")
                    // Performs the segue
                    os_log("Performing segue with id checkVerificationSegue", log: Log.view, type: .info)
                    self.performSegue(withIdentifier: "checkVerificationSegue", sender: self)
                    break
                case let .failure(error):
                    // Logs the end of the signpost
                    os_signpost(.end, log: Log.networking, name: "Send Verification", signpostID: signpostID, "Error sending verification: %{public}s", error.localizedDescription)
                    // Sets the error label
                    self.errorLabel.text = "An error occured. Please try again later"
                    break
                }
            }
    }
}

extension PhoneInputViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        errorLabel.text = ""
        return true
    }
}
