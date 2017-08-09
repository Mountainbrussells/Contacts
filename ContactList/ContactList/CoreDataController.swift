//
//  CoreDataController.swift
//  ContactList
//
//  Created by BenRussell on 8/9/17.
//  Copyright © 2017 BenRussell. All rights reserved.
//

import Foundation
import CoreData

class CoreDataController:NSObject {
    
    let container: NSPersistentContainer!
    
    class var sharedInstance: CoreDataController {
        struct Static {
            static let instance: CoreDataController = CoreDataController()
        }
        return Static.instance
    }
    
    override init() {
        container = NSPersistentContainer(name: "ContactList")
        container.loadPersistentStores { (storeDEscription, error) in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        super.init()
    }
    
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occured while saving: \(error)")
            }
        }
    }
}
