//
//  ViewController.swift
//  Enhanced Contact Entry
//
//  Created by Daniel Moreh on 4/2/15.
//  Copyright (c) 2015 Daniel Moreh. All rights reserved.
//

import UIKit
import AddressBook

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendSMSButton: UIButton!
    
    var textFields: [UITextField] = []
    
    // Sorry for quick and dirty prototype code.
    // socialNetworksAdded maps indexes (below) to "has been added" flags.
    // Used in showing the correct images (add or check) in table view.
    var socialNetworksAdded = [false, false, false]
    var socialNetworkNames = ["facebook", "twitter", "linkedin"]
    
    let kFacebookIndex = 0
    let kTwitterIndex = 1
    let kLinkedInIndex = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        notesTextView.layer.borderWidth = 1
        
        
        // Set the default text in notes.
        let now = NSDate()
        notesTextView.text = "Met at \(now)" // TODO: Format date appropriately.
        
        textFields = [
            firstNameTextField,
            lastNameTextField,
            phoneNumberTextField,
            emailAddressTextField
        ]
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Buttons
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        // Create a new contact.
        
        // Save it.
        
        // Wipe our UI.
        
        // Open that new contact's page.
        
        // We'll do all the above later. For now, just wipe the screen and show an alert.
        let alert = UIAlertView(
            title: "Contact Saved",
            message: "\(firstNameTextField.text) \(lastNameTextField.text) has been saved to your contacts. (Not really though, this is just a prototype.)",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        
        alert.show()
        
        for textField in textFields {
            textField.text = ""
        }
        
        notesTextView.text = ""
        
        for var i = 0; i < socialNetworksAdded.count; i++ {
            socialNetworksAdded[i] = false
        }
    }
    
    @IBAction func sendSMSButtonPressed(sender: AnyObject) {
        UIAlertView(
            title: "Message sent",
            message: "But not actually, this is just a prototype.",
            delegate: nil,
            cancelButtonTitle: "OK"
        ).show()
    }
    
    
    // MARK: - UITextFieldDelegate
    
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
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        var newString: NSString = NSString(string: textField.text)
        newString = newString.stringByReplacingCharactersInRange(range, withString: string)
        
        // Show SMS button iff there are 10+ characters in the phone number field.
        if textField == phoneNumberTextField {
            sendSMSButton.hidden = !(newString.length >= 10)
        }
        
        // Show tableView iff the name is Daniel Moreh.
        var firstName = firstNameTextField.text.lowercaseString
        var lastName = lastNameTextField.text.lowercaseString
        if textField == firstNameTextField {
            firstName = newString.lowercaseString
        } else if textField == lastNameTextField {
            lastName = newString.lowercaseString
        }
        
        tableView.hidden = !(firstName == "daniel" && lastName == "moreh")
        
        return true
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let name = "\(firstNameTextField.text) \(lastNameTextField.text)"
        let network = socialNetworkNames[indexPath.row]
        let alert = UIAlertView(
            title: "Confirm",
            message: "Are you sure you want to add \(name) on \(network)?",
            delegate: self,
            cancelButtonTitle: "No",
            otherButtonTitles: "Yes"
        )
        alert.tag = indexPath.row
        alert.show()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell\(indexPath.row)", forIndexPath: indexPath) as UITableViewCell
        
        if socialNetworksAdded[indexPath.row] {
            cell.imageView?.image = UIImage(named: "\(socialNetworkNames[indexPath.row])_check")
        }
    
    
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    // MARK: - UIAlertViewDelegate
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 { // Cancel button
            tableView.reloadData() // Hacky workaround to unhighlight cell
            return
        }
        
        socialNetworksAdded[alertView.tag] = true
        
        let confirmationAlert: UIAlertView = UIAlertView(
            title: "Done",
            message: "Your friend request has been sent.",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        
        confirmationAlert.show()
        tableView.reloadData()
    }
    
}

