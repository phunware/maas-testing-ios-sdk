//
//  PersonViewController.swift
//  CoreSample
//
//  Created on 4/24/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit
import PWCore

class RecordViewController : UITableViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var officeTextField: UITextField!
    
    var existingRecord: Person?
	var containerID : String?
	var personStructureID : Int?
	

    override func viewDidLoad() {
        super.viewDidLoad()
		
		containerID = "55ccecb7a0f9c6652400022d" // put your container id here.
		personStructureID = 12469	// put your structure id here.
        
        if let existingRecord = existingRecord {
            let editButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed(_:)))
            navigationItem.rightBarButtonItem = editButton
            
            if let firstName = existingRecord.firstName {
                firstNameTextField.text = firstName
            }
            if let lastName = existingRecord.lastName {
                lastNameTextField.text = lastName
            }
            if let jobTitle = existingRecord.jobTitle {
                jobTitleTextField.text = jobTitle
            }
            if let office = existingRecord.office {
                officeTextField.text = office
            }
        }
        
        firstNameTextField.becomeFirstResponder()
    }
    
    func createRecord(recordDictionary: [String : AnyObject]) {
		
        PWCME.addContent(recordDictionary, containerID:containerID , structureID: UInt(personStructureID!), success: { [weak self] (newContentId) in
            DispatchQueue.main.async {
                self?.dismiss(animated: true, completion: nil)
            }
        }) { [weak self] (error) in
            DispatchQueue.main.async {
                if let error = error {
                    self?.presentAlert(title: "CME Error", message: error.localizedDescription)
                }
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func updateRecord(recordId: String, recordDictionary: [String : AnyObject]) {
		
        PWCME.updateContent(forContentID: recordId, containerID:containerID, structureID: UInt(personStructureID!), updatedContent: recordDictionary, success: { [weak self] in
            DispatchQueue.main.async {
                self?.dismiss(animated: true, completion: nil)
            }
        }) { [weak self] (error) in
			
            DispatchQueue.main.async {
                if let error = error {
                    self?.presentAlert(title: "CME Error", message: error.localizedDescription)
                }
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func validateInput() -> NSError? {
        var error: NSError?
        if firstNameTextField.text?.trimmingCharacters(in: .whitespaces).characters.count == 0 {
            error = NSError(domain: "CoreSampleDomain", code: 400, userInfo: [NSLocalizedDescriptionKey : "First name can't be empty"])
        } else if lastNameTextField.text?.trimmingCharacters(in: .whitespaces).characters.count == 0 {
            error = NSError(domain: "CoreSampleDomain", code: 400, userInfo: [NSLocalizedDescriptionKey : "Last name can't be empty"])
        } else if jobTitleTextField.text?.trimmingCharacters(in: .whitespaces).characters.count == 0 {
            error = NSError(domain: "CoreSampleDomain", code: 400, userInfo: [NSLocalizedDescriptionKey : "Job title can't be empty"])
        } else if officeTextField.text?.trimmingCharacters(in: .whitespaces).characters.count == 0 {
            error = NSError(domain: "CoreSampleDomain", code: 400, userInfo: [NSLocalizedDescriptionKey : "Office location can't be empty"])
        }
        
        return error
    }
    
    func presentAlert(title: String, message: String) {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        
        present(errorAlert, animated: true, completion: nil)
    }
}

// MARK: Button Actions

extension RecordViewController {
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let error = validateInput()
        
        if let error = error {
            presentAlert(title: "Validation Error", message: error.localizedDescription)
            return
        }
        
        var recordDictionary = [String : AnyObject]()
        recordDictionary["firstName"] = firstNameTextField.text! as AnyObject
        recordDictionary["lastName"] = lastNameTextField.text! as AnyObject
        recordDictionary["title"] = jobTitleTextField.text! as AnyObject
        recordDictionary["office"] = officeTextField.text! as AnyObject

        if let existingRecord = existingRecord {
            updateRecord(recordId: existingRecord.id, recordDictionary: recordDictionary)
        } else {
            createRecord(recordDictionary: recordDictionary)
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: UITextFieldDelegate

extension RecordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            jobTitleTextField.becomeFirstResponder()
        } else if textField == jobTitleTextField {
            officeTextField.becomeFirstResponder()
        } else if textField == officeTextField {
            firstNameTextField.becomeFirstResponder()
        }
        
        return true
    }
}
