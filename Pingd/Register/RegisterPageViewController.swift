//
//  RegisterPageViewController.swift
//  Pingd
//
//  Created by David Acevedo on 1/20/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

protocol RegisterPageViewControllerDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class RegisterPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
        
    // MARK: - Properties
    weak var registerDelegate: RegisterPageViewControllerDelegate?
    
    var headers = [
        "What's Your Name?",
        "",
        "Set Your Password"
    ]
    var subheaders = [
        "We only use your first and last name as the display name for your profile.",
        "We will only use this to contact you for security reasons, like resetting your password.",
        "Your password should have at least one capital letter, one lowercase, and one number."
    ]
    var firstLabels = [
        "FIRST NAME",
        "EMAIL",
        "PASSWORD"
    ]
    var firstLabelPlaceHolders = [
        "John",
        "johndoe@email.com",
        "Password"
    ]
    var twoFields = [false, true, false]
    var secondLabels = [
        "LAST NAME",
        "PHONE NUMBER",
        "CONFIRM PASSWORD"
    ]
    var secondLabelPlaceHolders = [
        "Doe",
        "555-555-5555",
        "Confirm Password"
    ]
    var buttonLabels = ["Next", "Next", "Create Account"]
    
    var currentIndex = 0

    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Set datasource and delegate to itself
        delegate = self
        dataSource = self
        
        // Create First Walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Data Source Functions
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! RegisterContentViewController).pageIndex
        index -= 1

        return contentViewController(at: index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnboardingContentViewController).pageIndex
        index += 1

        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? RegisterContentViewController {
                currentIndex = contentViewController.pageIndex
                registerDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
    }
    
    
    
    // MARK: - Helpers
    func contentViewController(at index: Int) -> RegisterContentViewController? {
        if index < 0 || index >= headers.count {
            return nil
        }
        
        // Create new view controller with data
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(identifier: "RegisterContentViewController") as? RegisterContentViewController {
            
            pageContentViewController.header = headers[index]
            pageContentViewController.subheader = subheaders[index]
            pageContentViewController.firstFieldName = firstLabels[index]
            pageContentViewController.firstFieldPlaceHolder = firstLabelPlaceHolders[index]
            pageContentViewController.secondFieldName = secondLabels[index]
            pageContentViewController.secondFieldPlaceHolder = secondLabelPlaceHolders[index]
            pageContentViewController.isOnlyOneField = twoFields[index]
            
            return pageContentViewController
        }
        return nil
    }
    
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func backwardPage() {
        currentIndex -= 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .reverse, animated: true, completion: nil)
        }
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
