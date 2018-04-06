//
//  Person.swift
//  CoreSample
//
//  Created on 4/25/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import Foundation

class Person {
    
    var id: String!
    var firstName: String?
    var lastName: String?
    var jobTitle: String?
    var office: String?
    
    init(id: String!, firstName: String?, lastName: String?, jobTitle: String?, office: String?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.jobTitle = jobTitle
        self.office = office
    }
    
    init(dictionary: [String : AnyObject]) {
        id = dictionary["id"]! as! String
        if let firstName = dictionary["firstName"] as? String {
            self.firstName = firstName
        }
        if let lastName = dictionary["lastName"] as? String {
            self.lastName = lastName
        }
        if let jobTitle = dictionary["title"] as? String {
            self.jobTitle = jobTitle
        }
        if let office = dictionary["office"] as? String {
            self.office = office
        }
    }
}
