//
//  ViewController.swift
//  tip
//
//  Created by Karina Zhang on 9/2/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var numPeopleTextField: UITextField!
    @IBOutlet weak var perPersonLabel: UILabel!
    @IBOutlet weak var resultsView: UIView!
    
    let formatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        view.sendSubviewToBack(resultsView)
        billAmountTextField.becomeFirstResponder()
        configureUI()
    }
   
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billAmountTextField.text!) ?? 0
        let numPeople = Double(numPeopleTextField.text!) ?? 1
        let tipPercentages = [0.15, 0.18, 0.2]
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        let perPerson = total / numPeople
        
        tipPercentageLabel.text = "\(formatter.string(from: tip as NSNumber) ?? "0")"
        perPersonLabel.text = "\(formatter.string(from: perPerson as NSNumber) ?? "0")"
    }

    func configureUI() {
        numPeopleTextField.placeholder = "1"
        numPeopleTextField.textAlignment = .right
        billAmountTextField.placeholder = "\(formatter.string(from: 0 as NSNumber) ?? "0")"
        billAmountTextField.textAlignment = .right
        
    }
    
}

