//
//  Contact+CoreDataProperties.swift
//  ContactList
//
//  Created by BenRussell on 8/9/17.
//  Copyright © 2017 BenRussell. All rights reserved.
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var street: String?
    @NSManaged public var fullAddress: String?
    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var zipCode: Int32
    @NSManaged public var phone: String?
    @NSManaged public var email: NSObject?
    @NSManaged public var fullName: NSObject?
    @NSManaged public var created: NSDate?
    @NSManaged public var modified: NSDate?
    
    

}
