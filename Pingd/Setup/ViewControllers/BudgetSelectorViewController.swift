//
//  BudgetSelectorViewController.swift
//  Pingd
//
//  Created by David Acevedo on 3/22/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class BudgetSelectorViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var topStaticLabel: InsetLabel!{
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5.0
            
            let attrString = NSMutableAttributedString(string: topStaticLabel.text!)
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
            
            topStaticLabel.attributedText = attrString
        }
    }
    @IBOutlet weak var bottomView: UIView! {
        didSet {
            self.bottomView.backgroundColor = .clear
        }
    }
    @IBOutlet weak var pickerContainer: UIPickerView!
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5.0
            
            let attrString = NSMutableAttributedString(string: descriptionLabel.text!)
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
            
            descriptionLabel.attributedText = attrString
        }
    }
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            self.nextButton.layer.cornerRadius = 25.0
            self.nextButton.enable()
        }
    }
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            self.backButton.layer.cornerRadius = 25.0
        }
    }
    
    // MARK: - Properties
    private let collectionView: CVSelector = {
        return CVSelector()
    }()
    
    private let scroller: CVNumberScroller = {
        return CVNumberScroller()
    }()
    
    private var pickerNumbers: [Int] = {
        var numbersList: [Int] = []
        
        for i in 20...60 {
            numbersList.append(i)
        }
        
        return numbersList
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        
        pickerContainer.delegate = self
        pickerContainer.dataSource = self

        // Do any additional setup after loading the view.
        container.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 1.0).isActive = true
        
        pickerContainer.addSubview(scroller)
        scroller.backgroundColor = .clear
        scroller.topAnchor.constraint(equalTo: pickerContainer.topAnchor, constant: 0).isActive = true
        scroller.leadingAnchor.constraint(equalTo: pickerContainer.leadingAnchor, constant: 0).isActive = true
        scroller.trailingAnchor.constraint(equalTo: pickerContainer.trailingAnchor, constant: 0).isActive = true
        scroller.heightAnchor.constraint(equalTo: pickerContainer.heightAnchor, multiplier: 1.0).isActive = true
        
        let roundedView = RoundedView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: bottomView.frame.size.height + 44))
        bottomView.insertSubview(roundedView, at: 0)
        
        collectionView.didSelectCell = { [weak self] data in
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                // self!.pickerContainer.backgroundColor = .cyan
            }, completion: nil)
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                self!.backButton.backgroundColor = data.supplementaryColor
                roundedView.changeBackgroundColor(to: data.bgColor)
                self!.descriptionLabel.alpha = 0.0
                self!.descriptionLabel.frame = CGRect(x: 0.0, y: self!.descriptionLabel.frame.origin.y + 5.0, width: self!.descriptionLabel.frame.width, height: self!.descriptionLabel.frame.height)
            }, completion: { (finished) in
                self!.descriptionLabel.text = data.description
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                    self!.descriptionLabel.alpha = 1.0
                    self!.descriptionLabel.frame = CGRect(x: 0.0, y: self!.descriptionLabel.frame.origin.y - 5.0, width: self!.descriptionLabel.frame.width, height: self!.descriptionLabel.frame.height)
                }, completion: nil)
            })
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

extension BudgetSelectorViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerNumbers.count
    }
}

extension BudgetSelectorViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerNumbers[row])
    }
}

