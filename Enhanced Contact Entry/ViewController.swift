//
//  ViewController.swift
//  Enhanced Contact Entry
//
//  Created by Daniel Moreh on 4/2/15.
//  Copyright (c) 2015 Daniel Moreh. All rights reserved.
//

import UIKit
import AddressBook

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the default text in notes.
        let now = NSDate()
        notesTextView.text = "Met at \(now)" // TODO: Format date appropriately.
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        // Create a new contact. 
        
        // Save it. 
        
        // Wipe our UI.
        
        // Open that new contact's page.
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // First three fields move to the next one. Last field dismisses keyboard.
        // TODO: Make social media requests.
        if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            phoneNumberTextField.becomeFirstResponder()
        } else if textField == phoneNumberTextField {
            emailAddressTextField.becomeFirstResponder()
        } else if textField == emailAddressTextField {
            emailAddressTextField.resignFirstResponder()
        }
        
        return false
    }
}

