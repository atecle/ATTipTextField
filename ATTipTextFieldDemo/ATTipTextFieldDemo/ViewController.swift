//
//  ViewController.swift
//  ATTipTextFieldDemo
//
//  Created by Adam on 10/22/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import ATTipTextField
import PhoneNumberKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: TipTextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        emailTextField.autocorrectionType = .no
        emailTextField.tipViewCornerRadii = CGSize(width: 4.0, height: 4.0)
        emailTextField.tipFont = .boldSystemFont(ofSize: 18)
    }
    
    // MARK: IBAction
    
    @IBAction func nextButtonPressed(_ sender: AnyObject) {
        signup()
    }
    
    func signup() {
        if validateInput() == false {
            return;
        }
        //Sign the user up
    }
    
    // MARK: - UITextFieldDelegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        emailTextField.animateTip(visible: false)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextField.animateTip(visible: false)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            emailTextField.resignFirstResponder()
            signup()
        }
        return true
    }
    
    // MARK: - Helpers
    
    func validateInput() -> Bool {
        var emailInvalid = true
        if let email = emailTextField.text {
            if validate(email: email) == false {
                emailTextField.tipBackgroundColor = UIColor.init(red: CGFloat(236.0/255.0), green: CGFloat(100.0/255.0), blue: CGFloat(75.0/255.0), alpha: 1)
                emailTextField.tipText = "Enter a valid email"
                emailTextField.animateTip(visible: true, duration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [])
                emailInvalid = true
            } else {
                emailTextField.tipBackgroundColor = UIColor.init(red: CGFloat(63.0/255.0), green: CGFloat(195.0/255.0), blue: CGFloat(128.0/255.0), alpha: 1)
                emailTextField.tipText = "Check your email!"
                emailTextField.animateTip(visible: true, duration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [])
            }
        }
        return !emailInvalid
    }
    

    func validate(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
