//
//  ViewController.swift
//  ios
//
//  Created by Chanintorn Asavavichairoj on 9/18/2559 BE.
//  Copyright © 2559 JO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var logoConstraint: NSLayoutConstraint!
    @IBOutlet weak var signinFormView: UIView!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signinConstraint: NSLayoutConstraint!
    
    private let STATUS_BAR_HEIGHT:CGFloat = 20
    private let LOGO_DEFAULT_CONSTRAINT:CGFloat = 40
    private let LOGO_HEIGHT:CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        signinFormView.alpha = 0
        signinButton.alpha = 0
        logoConstraint.constant = view.center.y-(LOGO_HEIGHT/2)-STATUS_BAR_HEIGHT
        
        usernameTextfield.delegate = self
        passwordTextfield.delegate = self
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(dismissGesture)
        
        signinButton.isEnabled = false
        signinButton.setBackgroundColor(color: UIColor.black, forState: UIControlState.normal)
        signinButton.setBackgroundColor(color: UIColor.init(rgba: "#EEEEEE"), forState: UIControlState.disabled)
        
        usernameTextfield.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        passwordTextfield.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logoConstraint.constant = LOGO_DEFAULT_CONSTRAINT
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 3.0, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
        UIView.animate(withDuration: 2.0) { 
            self.signinFormView.alpha = 1
            self.signinButton.alpha = 1
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

}

extension ViewController: UITextFieldDelegate {
    
    private func animateTextField(textField: UITextField, up: Bool) {
        let movementDistance:CGFloat = -220
        let movementDuration: Double = 0.3
        
        let movement:CGFloat = up ? movementDistance : -movementDistance
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        signinConstraint.constant -= movement
        view.layoutIfNeeded()
        UIView.commitAnimations()
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateTextField(textField: textField, up:true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateTextField(textField: textField, up:false)
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if let username = usernameTextfield.text, let password = passwordTextfield.text {
            if (username.characters.count > 0) && (password.characters.count > 0) {
                signinButton.isEnabled = true
            } else {
                signinButton.isEnabled = false
            }
        }
    }

}

