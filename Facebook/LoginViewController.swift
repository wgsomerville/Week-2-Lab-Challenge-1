//
//  LoginViewController.swift
//  Facebook
//
//  Created by Somerville, Walter on 2/29/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var fieldsParentView: UIView!
    @IBOutlet weak var labelsParentView: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginIndicatior: UIActivityIndicatorView!

    var fieldsParentViewInitialY: CGFloat!
    var labelsParentViewInitialY: CGFloat!
    var logoInitialY: CGFloat!
    var offset: CGFloat!
    var alertController: UIAlertController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fieldsParentViewInitialY = fieldsParentView.frame.origin.y
        labelsParentViewInitialY = labelsParentView.frame.origin.y
        logoInitialY = logo.frame.origin.y
        offset = -120
        
        alertController = UIAlertController(title: "Access Denied", message: "Wrong Username or Password", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in})
        alertController.addAction(okAction)

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    func keyboardWillShow(notification: NSNotification) {
        let kbFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        labelsParentView.frame.origin.y = labelsParentViewInitialY - kbFrame.size.height + 20
        fieldsParentView.frame.origin.y = fieldsParentViewInitialY + offset
        logo.frame.origin.y = logoInitialY - 50
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        labelsParentView.frame.origin.y = labelsParentViewInitialY
        fieldsParentView.frame.origin.y = fieldsParentViewInitialY
        logo.frame.origin.y = logoInitialY
    }
    @IBAction func didTap(sender: AnyObject) {
        view.endEditing(true)
    }
    @IBAction func didPressLogin(sender: AnyObject) {
        
        loginIndicatior.startAnimating()
        loginButton.selected = true
        
        if emailField.text == "Walter" && passwordField.text == "12345" {
            
            delay(2, closure: { () -> () in
                self.loginIndicatior.stopAnimating()
                self.loginButton.selected = false
                
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            })
            
            // Code that runs if both email and password match the text we are looking for in each case
        } else {
            delay(2, closure: { () -> () in
                self.loginIndicatior.stopAnimating()
                self.loginButton.selected = false
                self.presentViewController(self.alertController, animated: true, completion: { () -> Void in })
            
            })
            // Code that runs if either the email or password do NOT match the text we are looking for in each case
        }
    }
    
    @IBAction func editingChanged(sender: AnyObject) {
        if emailField.text!.isEmpty || passwordField.text!.isEmpty {
            loginButton.enabled = false
        } else {
            loginButton.enabled = true
        }
    }
    
}
