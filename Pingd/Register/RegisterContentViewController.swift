//
//  RegisterContentViewController.swift
//  Pingd
//
//  Created by David Acevedo on 1/20/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct RegisterUser: Encodable {
    let firstName: String
    let lastName: String
    let password: String
}

class RegisterContentViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subheaaderLabel: UILabel!
    @IBOutlet weak var firstTextFieldLabel: UILabel!
    @IBOutlet weak var secondTextFieldLabel: UILabel!
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
            self.firstButton.layer.cornerRadius = 25.0
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
    var firstButtonTitle: String?
    var viewParent: RegisterPageViewController?
    var viewSecondInput: Bool?
    
    var firstKeyboardType: UIKeyboardType?
    var secondKeyboardType: UIKeyboardType?
    
    var fieldOneHasText = false
    var fieldTwoHasText = false
    
    // MARK: - App LifeCycle
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
        
        // Adds a textfield listener
        firstTextField.addTarget(self, action: #selector(firstTextFieldDidChange), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(secondTextFieldDidChange), for: .editingChanged)
        
        firstTextField.delegate = self
        
        // Assigns a type to the keyboard
        self.firstTextField.keyboardType = firstKeyboardType!
        self.secondTextField.keyboardType = secondKeyboardType!
        
        // Initializes the error label with nothing
        self.errorLabel.text = ""
        
        // Sets the password fields to secure entry
        if viewParent?.currentIndex == 1 {
            self.firstTextField.isSecureTextEntry = true
            self.secondTextField.isSecureTextEntry = true
        }
        
        // In this set of blocks, we pre-fill all text in the event the user goes back and forth
        // between pages
        switch viewParent?.currentIndex {
        case 0:
            // Captures the first name and last name from UserDefaults
            let firstName = UserDefaults.standard.string(forKey: "firstName") ?? nil
            let lastName = UserDefaults.standard.string(forKey: "lastName") ?? nil
            // Pre-fills the fields
            if firstName != nil {
                firstTextField.text = firstName
                fieldOneHasText = true
            }
            if lastName != nil {
                secondTextField.text = lastName
                fieldTwoHasText = true
            }
            // Enables the button when there is text in both
            if firstName != nil && lastName != nil {
                self.firstButton.enable()
            }
        default:
            break
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    // MARK: - TextField Delegates
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
        
        if viewParent?.currentIndex == 1 {
            if !fieldOneHasText {
                showErrorMessage(message: "Password must have one capital, one lowercase, and one number")
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstTextField.resignFirstResponder()
        secondTextField.becomeFirstResponder()
        return true
    }
    
    // MARK: - Button Handler
    @objc func firstButtonPressed(sender: UIButton!) {
        // Clears error label
        self.errorLabel.text = ""
        
        // Handles the validation first
        switch viewParent?.currentIndex {
        case 0:
            // Captures the first and last name to be stored later
            UserDefaults.standard.set(firstTextField.text, forKey: "firstName")
            UserDefaults.standard.set(secondTextField.text, forKey: "lastName")
            // Moves the page forward
            viewParent?.forwardPage()
        case 1:
            if firstTextField.text != secondTextField.text {
                showErrorMessage(message: "Password fields must match")
                return
            }
            if !isValidPassword(password: firstTextField.text!) {
                showErrorMessage(message: "Passwords need at least 8 characters, one capital, one lowercase, and one digit")
                return
            }
            
            let userCreated = createUser(password: firstTextField.text!)
            if !userCreated {
                showErrorMessage(message: "An error occured, please try again later")
            } else {
                // Transition to verify screen
                print("Transition to phone verification")
                performSegue(withIdentifier: "verifySegue", sender: self)
            }
        default:
            viewParent?.forwardPage()
        }
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
    
    func createUser(password: String?) -> Bool {
//        var responseStatusCode: Int = 0
//        let registerUser = RegisterUser(firstName: UserDefaults.standard.string(forKey: "firstName")!,
//                                        lastName: UserDefaults.standard.string(forKey: "lastName")!,
//                                        password: password!)
//        AF.request("http://PingdBackend-dev.us-east-1.elasticbeanstalk.com/api/v1/users", method: .post, parameters: registerUser, encoder: JSONParameterEncoder.default).validate(statusCode: 200..<300).validate(contentType: ["application/json"]).responseData { response in
//            // responseStatusCode = response.response!.statusCode
//            debugPrint(response)
//            switch response.result {
//            case .success:
//                print("Validation Successful")
//            case let .failure(error):
//                print(error)
//            }
//        }
//
//        return responseStatusCode == 201
        return true
    }
}
