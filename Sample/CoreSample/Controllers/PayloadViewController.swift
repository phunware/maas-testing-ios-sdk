//
//  PayloadViewController.swift
//  CoreSample
//
//  Created on 4/24/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit
import PWCore

class PayloadViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.isEditable = false;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
    
    func configureView() {
 
    }
}
