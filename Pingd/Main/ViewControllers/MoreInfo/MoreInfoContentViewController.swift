//
//  MoreInfoContentViewController.swift
//  Pingd
//
//  Created by David Acevedo on 9/2/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class MoreInfoContentViewController: UIViewController {
    
    // MARK: - Properties
    var pageIndex = 0
    
    let smallerHeightMultiplier = CGFloat(0.14)
    let biggerHeightMultiplier = CGFloat(0.36)
    
    var stackView: UIStackView?
    
    var backgroundColor: UIColor? = #colorLiteral(red: 0.6588235294, green: 0.6352941176, blue: 0.9294117647, alpha: 1)
    var categoryTitle: String? = "Needs"
    var subcategoryTitle: String? = "The things in your life that are absolutely neccesary"
    
    var itemColorBackground: UIColor? = #colorLiteral(red: 0.7450980392, green: 0.7254901961, blue: 0.9568627451, alpha: 1)
    
    var askMoreTitle: String? = "Not sure? Ask this:"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewHeight = view.frame.height
        let viewWidth = view.frame.width
        view.backgroundColor = backgroundColor

        // Creates the stack view
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        // creates the constraints for the
        stackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.85).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackView.spacing = 20.0
        
        // Creates the ImageView
        let iconImageView = UIImageView()
        iconImageView.image = #imageLiteral(resourceName: "Calendar")
        iconImageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(iconImageView)
        // Sets the image view constraints
        iconImageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: smallerHeightMultiplier).isActive = true
        iconImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1.0).isActive = true
        
        // Creates the title and subvtitle stackView
        let titleStackView = UIStackView()
        titleStackView.axis = .vertical
        titleStackView.alignment = .fill
        titleStackView.distribution = .fill
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.spacing = 0
        stackView.addArrangedSubview(titleStackView)
        // Creates the UILabels
        let titleLabel = UILabel()
        titleLabel.text = categoryTitle
        titleLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 36.0)
        titleLabel.textColor = .white
        let subtitleLabel = UILabel()
        subtitleLabel.text = subcategoryTitle
        subtitleLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 16.0)
        subtitleLabel.textColor = .white
        subtitleLabel.numberOfLines = 2
        subtitleLabel.adjustsFontSizeToFitWidth = true
        // Adds labels to thee subviews
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subtitleLabel)
        // Attaches contraints to the labels
        titleLabel.widthAnchor.constraint(equalTo: titleStackView.widthAnchor, multiplier: 1.0).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: titleStackView.heightAnchor, multiplier: 0.53).isActive = true
        subtitleLabel.widthAnchor.constraint(equalTo: titleStackView.widthAnchor, multiplier: 1.0).isActive = true
        subtitleLabel.heightAnchor.constraint(equalTo: titleStackView.heightAnchor, multiplier: 0.47).isActive = true
        // Sets the titlestackview constraints
        titleStackView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: smallerHeightMultiplier, constant: -20).isActive = true
        titleStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1.0).isActive = true
        
        // Creates the stack
        let examplesStackView = UIStackView()
        examplesStackView.axis = .vertical
        examplesStackView.alignment = .fill
        examplesStackView.distribution = .fill
        examplesStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(examplesStackView)
        // Creates the label
        let exampleTitleLabel = UILabel()
        exampleTitleLabel.text = "Examples:"
        exampleTitleLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 16.0)
        exampleTitleLabel.textColor = .white
        // Creates the three UIViews
        let firstExampleView = UIView()
        firstExampleView.backgroundColor = itemColorBackground
        let secondExampleView = UIView()
        secondExampleView.backgroundColor = itemColorBackground
        let thirdExampleView = UIView()
        thirdExampleView.backgroundColor = itemColorBackground
        // Adds the views
        examplesStackView.addArrangedSubview(exampleTitleLabel)
        examplesStackView.addArrangedSubview(firstExampleView)
        examplesStackView.addArrangedSubview(secondExampleView)
        examplesStackView.addArrangedSubview(thirdExampleView)
        // Adds the constraints
        exampleTitleLabel.widthAnchor.constraint(equalTo: examplesStackView.widthAnchor, multiplier: 1.0).isActive = true
        exampleTitleLabel.heightAnchor.constraint(equalTo: examplesStackView.heightAnchor, multiplier: 0.10).isActive = true
        firstExampleView.widthAnchor.constraint(equalTo: examplesStackView.widthAnchor, multiplier: 1.0).isActive = true
        firstExampleView.heightAnchor.constraint(equalTo: examplesStackView.heightAnchor, multiplier: 0.30).isActive = true
        secondExampleView.widthAnchor.constraint(equalTo: examplesStackView.widthAnchor, multiplier: 1.0).isActive = true
        secondExampleView.heightAnchor.constraint(equalTo: examplesStackView.heightAnchor, multiplier: 0.30).isActive = true
        thirdExampleView.widthAnchor.constraint(equalTo: examplesStackView.widthAnchor, multiplier: 1.0).isActive = true
        thirdExampleView.heightAnchor.constraint(equalTo: examplesStackView.heightAnchor, multiplier: 0.30).isActive = true
        // Sets the examplesStackView constraints
        examplesStackView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: biggerHeightMultiplier, constant: -20).isActive = true
        examplesStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1.0).isActive = true
        
        // Sets up the ask more
        let askMoreStackView = UIStackView()
        askMoreStackView.axis = .vertical
        askMoreStackView.alignment = .fill
        askMoreStackView.distribution = .fill
        askMoreStackView.translatesAutoresizingMaskIntoConstraints = false
        // askMoreStackView.spacing = 20.0
        stackView.addArrangedSubview(askMoreStackView)
        // Creates the label
        let askMoreTitleLabel = UILabel()
        askMoreTitleLabel.text = askMoreTitle
        askMoreTitleLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 16.0)
        askMoreTitleLabel.textColor = .white
        // Creates the UIView
        let firstAskMoreView = UIView()
        firstAskMoreView.backgroundColor = itemColorBackground
        let secondAskMoreView = UIView()
        secondAskMoreView.backgroundColor = itemColorBackground
        // Adds the views
        askMoreStackView.addArrangedSubview(askMoreTitleLabel)
        askMoreStackView.addArrangedSubview(firstAskMoreView)
        askMoreStackView.addArrangedSubview(secondAskMoreView)
        // Adds the constraints
        askMoreTitleLabel.widthAnchor.constraint(equalTo: askMoreStackView.widthAnchor, multiplier: 1.0).isActive = true
        askMoreTitleLabel.heightAnchor.constraint(equalTo: askMoreStackView.heightAnchor, multiplier: 0.10).isActive = true
        firstAskMoreView.widthAnchor.constraint(equalTo: askMoreStackView.widthAnchor, multiplier: 1.0).isActive = true
        firstAskMoreView.heightAnchor.constraint(equalTo: askMoreStackView.heightAnchor, multiplier: 0.45).isActive = true
        secondAskMoreView.widthAnchor.constraint(equalTo: askMoreStackView.widthAnchor, multiplier: 1.0).isActive = true
        secondAskMoreView.heightAnchor.constraint(equalTo: askMoreStackView.heightAnchor, multiplier: 0.45).isActive = true
        // Sets the examplesStackView constraints
        askMoreStackView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: biggerHeightMultiplier, constant: -20).isActive = true
        askMoreStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1.0).isActive = true
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
