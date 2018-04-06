//
//  RegisterVersionViewController.swift
//  CoreSample
//
//  Created on 5/31/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit
import PWCore

class RegisterVersionViewController: UIViewController {
	
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var versionField: UITextField!
	@IBOutlet weak var registerButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}

	@IBAction func registerButtonPressed(_ sender: Any) {
		PWCore.registerModule(nameField.text!, version: versionField.text!, withCompletion: nil)
	}
	
	@IBAction func doneButtonPressed(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
	
}
