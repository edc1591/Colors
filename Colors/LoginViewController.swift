//
//  LoginViewController.swift
//  Colors
//
//  Created by Evan Coleman on 11/28/15.
//  Copyright © 2015 Evan Coleman. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa

class LoginViewController: ViewController, UITextFieldDelegate {
    var textFieldContainer: UIView!
    var usernameField: UITextField!
    var passwordField: UITextField!
    var loginButton: UIButton!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.grayColor()
        
        self.textFieldContainer = UIView()
        self.textFieldContainer.backgroundColor = UIColor.darkGrayColor()
        self.view.addSubview(self.textFieldContainer)
        
        self.usernameField = UITextField()
        self.usernameField.delegate = self
        self.usernameField.backgroundColor = UIColor.whiteColor()
        self.usernameField.borderStyle = UITextBorderStyle.Bezel
        self.usernameField.placeholder = "Username"
        self.usernameField.returnKeyType = UIReturnKeyType.Next
        self.usernameField.keyboardType = UIKeyboardType.EmailAddress
        self.textFieldContainer.addSubview(self.usernameField)
        
        self.passwordField = UITextField()
        self.passwordField.delegate = self
        self.passwordField.backgroundColor = UIColor.whiteColor()
        self.passwordField.borderStyle = UITextBorderStyle.Bezel
        self.passwordField.secureTextEntry = true
        self.passwordField.placeholder = "Password"
        self.passwordField.returnKeyType = UIReturnKeyType.Done
        self.textFieldContainer.addSubview(self.passwordField)
        
        self.loginButton = UIButton(type: UIButtonType.RoundedRect)
        self.loginButton.setTitle("Login!", forState: UIControlState.Normal)
        self.loginButton.addTarget(self, action: Selector("tapLogin:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.loginButton)
        
        self.textFieldContainer.snp_makeConstraints(closure: { (make) -> Void in
            make.centerY.equalTo(self.view).offset(-64)
            make.left.equalTo(self.view).offset(24)
            make.right.equalTo(self.view).offset(-24)
            make.bottom.equalTo(self.passwordField).offset(16)
        })
        self.usernameField.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo(self.textFieldContainer).offset(16)
            make.left.equalTo(self.textFieldContainer).offset(8)
            make.right.equalTo(self.textFieldContainer).offset(-8)
        })
        self.passwordField.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo(self.usernameField.snp_bottom).offset(16)
            make.left.equalTo(self.textFieldContainer).offset(8)
            make.right.equalTo(self.textFieldContainer).offset(-8)
        })
        self.loginButton.snp_makeConstraints(closure: { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-24)
        })
    }
    
    func tapLogin(sender: UIButton) {
        let viewModel = self.viewModel as! LoginViewModel
        
        viewModel.loginAction.apply((self.usernameField.text!, self.passwordField.text!)).start()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField === self.usernameField {
            self.passwordField.becomeFirstResponder()
            return false
        }
        
        return true
    }
}