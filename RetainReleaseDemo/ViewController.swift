//
//  ViewController.swift
//  RetainReleaseDemo
//
//  Created by Sander Theeuwes on 20/05/2018.
//  Copyright © 2018 Move4Mobile. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonCreate: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    private let names: [String] = ["Niek", "Julian", "Dide", "Sander"]
    private var persons: [Person] = []
    
    public func log(_ log: String) {
        var text = self.textView.text ?? ""
        text = String(format: "%@%@\r\n", text, log)
        self.textView.text = text
        self.view.setNeedsDisplay()
    }
    
    public func logRetainCount(_ name: String, _ retainCount: Int) {
        self.log(String(format: "Current retain value of %@: %i", name, retainCount))
    }
    
    public func logPerson(_ person: Person) {
        self.logRetainCount(person.name, CFGetRetainCount(person))
    }

    @IBAction func createPerson(_ sender: Any) {
        let name = self.names[self.persons.count % self.names.count]
        self.log(String(format: "Creating Person with name: %@", name))
        let person = Person()
        self.logRetainCount(name, CFGetRetainCount(person))
        person.name = name
        self.logRetainCount(name, CFGetRetainCount(person))
        self.persons.append(person)
        self.logRetainCount(name, CFGetRetainCount(person))
    }

    @IBAction func createDriversLicences(_ sender: Any) {
        for person in self.persons {
            if (person.driversLicence == nil) {
                person.driversLicence = DriversLicence()
            }
        }
    }
    
    @IBAction func linkDriversLicence(_ sender: Any) {
        for person in self.persons {
            person.driversLicence.person = person
        }
    }
    
    @IBAction func linkDriversLicenceWeak(_ sender: Any) {
        for person in self.persons {
            person.driversLicence.weakPerson = person
        }
    }
    
    @IBAction func unlinkDriversLicence(_ sender: Any) {
        for person in self.persons {
            person.driversLicence.person = nil
            person.driversLicence.weakPerson = nil
        }
    }
    
    @IBAction func logPeople(_ sender: Any) {
        for person in self.persons {
            self.logRetainCount(person.name, CFGetRetainCount(person))
            self.logPerson(person)
        }
    }
}

