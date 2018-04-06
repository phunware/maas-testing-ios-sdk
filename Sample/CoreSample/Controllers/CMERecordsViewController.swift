//
//  PeopleViewController.swift
//  CoreSample
//
//  Created on 4/24/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit
import PWCore

class CMERecordsViewController: UITableViewController {

    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var records = [Person]()
    var selectedRecord: Person?
	var containerID : String?
	var peopleStructureID : Int?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		containerID = "1234234231432" //put your container id here.
		peopleStructureID = 12468	  //put your structure id here.

        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshRecords()
    }
    
    func configureView() {
        tableView.allowsMultipleSelectionDuringEditing = true;
    }
    
    func refreshRecords() {
        
        addButton.isEnabled = true
        
        PWCME.getContentsForContainerID(containerID, structureID: peopleStructureID!, limit: 100, offset: 0, success: { [weak self] (contents, pagination, pagingEnabled) in
            if let contents = contents as? [[String : AnyObject]] {
                var personRecords = [Person]()
                for personDict in contents {
                    let person = Person(dictionary: personDict)
                    personRecords.append(person)
                }
                self?.records = personRecords
            }
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
        }) { [weak self] (error) in
            self?.presentErrorAlert(error: error)
            self?.refreshControl?.endRefreshing()
        }
    }
    
    func deleteRecord(indexPath: IndexPath) {
        let person = records[indexPath.row]
        records.remove(at: indexPath.row)
        tableView.reloadData()
        
        PWCME.deleteContent(forContentID: person.id, traverse: true, success: nil, failure: { [weak self] (error) in
            self?.presentErrorAlert(error: error)
            DispatchQueue.main.async {
                self?.records.append(person)
                self?.tableView.reloadData()
            }
        })
    }
    
    func presentErrorAlert(error: Error?) {
        let errorAlert = UIAlertController(title: "CME Error", message: error?.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        
        present(errorAlert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String(describing: RecordViewController.self) {
            if let recordNavigationController = segue.destination as? UINavigationController, let recordViewController = recordNavigationController.viewControllers.first as? RecordViewController {
                recordViewController.existingRecord = selectedRecord
            }
        }
    }
}

// MARK: Button Actions

extension CMERecordsViewController {
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        refreshRecords()
    }
}

// MARK: UITableViewDataSource

extension CMERecordsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let recordCell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecordCell.self), for: indexPath) as? RecordCell {
            
            let person = records[indexPath.row]
            if let firstName = person.firstName, let lastName = person.lastName {
                recordCell.nameLabel.text = "\(firstName) \(lastName)"
            }
            if let jobTitle = person.jobTitle {
                recordCell.titleLabel.text = jobTitle
            }
            if let office = person.office {
                recordCell.officeLabel.text = office
            }
            cell = recordCell
        }
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
           deleteRecord(indexPath: indexPath)
        }
    }
}

// MARK: UITableViewDelegate

extension CMERecordsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedRecord = records[indexPath.row]
        performSegue(withIdentifier: String(describing: RecordViewController.self), sender: self)
    }
}
