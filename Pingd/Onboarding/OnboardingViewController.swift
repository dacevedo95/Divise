//
//  OnboardingViewController.swift
//  Pingd
//
//  Created by David Acevedo on 1/15/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import AuthenticationServices

class OnboardingViewController: UIViewController, OnboardingPageViewControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var signInWithApple: UIView! {
        didSet {
            let authBtn = ASAuthorizationAppleIDButton()
            authBtn.frame = CGRect(x: 0, y: 0, width: signInWithApple.frame.size.width, height: signInWithApple.bounds.height)
            // Handles the press
            authBtn.addTarget(self, action: #selector(handleAppleSignin), for: .touchUpInside)
            // Adds the button to the view
            signInWithApple.addSubview(authBtn)
        }
    }
    
    @IBOutlet var signInWithEmail: UIButton! {
        didSet {
            signInWithEmail.backgroundColor = .clear
            signInWithEmail.layer.cornerRadius = 5
            signInWithEmail.layer.borderWidth = 1
            signInWithEmail.layer.borderColor = UIColor.black.cgColor
            signInWithEmail.layer.masksToBounds = true
        }
    }
    
    // MARK: - Properties
    var onboardingPageViewController: OnboardingPageViewController?
    var swipeGR: UISwipeGestureRecognizer!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Helpers
    @objc func handleAppleSignin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    

    // MARK: - Actions
    func didUpdatePageIndex(currentIndex: Int) {
        if let index = onboardingPageViewController?.currentIndex {
            pageControl.currentPage = index
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? OnboardingPageViewController {
            onboardingPageViewController = pageViewController
            onboardingPageViewController?.onboardingDelegate = self
        }
        self.dismiss(animated: false, completion: nil)
    }
}

// MARK: - Extensions
extension OnboardingViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Create an account as per your requirement
            let appleId = appleIDCredential.user
            let appleUserFirstName = appleIDCredential.fullName?.givenName
            let appleUserLastName = appleIDCredential.fullName?.familyName
            let appleUserEmail = appleIDCredential.email
            //Write your code
            
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            let appleUsername = passwordCredential.user
            let applePassword = passwordCredential.password
            //Write your code

        }
    }
}

extension OnboardingViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
