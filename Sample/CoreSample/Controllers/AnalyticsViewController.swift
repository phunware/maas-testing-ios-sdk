//
//  AnalyticsViewController.swift
//  CoreSample
//
//  Created on 4/24/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit
import PWCore

class AnalyticsViewController: UIViewController {
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var chooseFruitButton: UIButton!
    
    @IBOutlet weak var startTimedButton: UIButton!
    @IBOutlet weak var stopTimedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        PWAnalytics.addEvent("Events Page View")
    }
    
    func configureView() {
        let blueColor = UIColor(red: 0 / 255.0, green: 182 / 255.0, blue: 235 / 255.0, alpha: 1.0)
        redButton.backgroundColor = UIColor(red: 248 / 255.0, green: 92 / 255.0, blue: 86 / 255.0, alpha: 1.0)
        greenButton.backgroundColor = UIColor(red: 54 / 255.0, green: 252 / 255.0, blue: 56 / 255.0, alpha: 1.0)
        blueButton.backgroundColor = blueColor
        
        redButton.setTitle("Red Event", for: .normal)
        blueButton.setTitle("Blue Event", for: .normal)
        greenButton.setTitle("Green Event", for: .normal)
        
        redButton.addTarget(self, action: #selector(redButtonPressed(_:)), for: .touchUpInside)
        greenButton.addTarget(self, action: #selector(greenButtonPressed(_:)), for: .touchUpInside)
        blueButton.addTarget(self, action: #selector(blueButtonPressed(_:)), for: .touchUpInside)
        
        segmentedControl.setTitle("Apples", forSegmentAt: 0)
        segmentedControl.setTitle("Oranges", forSegmentAt: 1)
        segmentedControl.setTitle("Cherries", forSegmentAt: 2)
        
        chooseFruitButton.backgroundColor = blueColor
        chooseFruitButton.setTitle("Choose Fruit", for: .normal)
        chooseFruitButton.addTarget(self, action: #selector(chooseFruitButtonPressed(_:)), for: .touchUpInside)
        
        startTimedButton.backgroundColor = blueColor
        stopTimedButton.backgroundColor = blueColor
        
        startTimedButton.setTitle("Start Timed Event", for: .normal)
        stopTimedButton.setTitle("Stop Timed Event", for: .normal)
        
        startTimedButton.addTarget(self, action: #selector(startTimedButtonPressed(_:)), for: .touchUpInside)
        stopTimedButton.addTarget(self, action: #selector(stopTimedButtonPressed(_:)), for: .touchUpInside)
    }
}

// MARK: Button Actions

extension AnalyticsViewController {
    
    func redButtonPressed(_ sender: UIButton) {
        PWAnalytics.addEvent("Red Button Pressed")
    }
    
    func greenButtonPressed(_ sender: UIButton) {
        PWAnalytics.addEvent("Green Button Pressed")
    }
    
    func blueButtonPressed(_ sender: UIButton) {
        PWAnalytics.addEvent("Blue Button Pressed")
    }
    
    func chooseFruitButtonPressed(_ sender: UIButton) {
        let selectedSegmentTitle = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)!
        let parameters = ["fruit" : selectedSegmentTitle]
        PWAnalytics.addEvent("Fruit Button Pressed", withParameters: parameters)
    }
    
    func startTimedButtonPressed(_ sender: UIButton) {
        PWAnalytics.startTimedEvent("Test Timed Event")
    }
    
    func stopTimedButtonPressed(_ sender: UIButton) {
        PWAnalytics.endTimedEvent("Test Timed Event")
    }
}
