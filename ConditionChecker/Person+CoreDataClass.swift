//
//  Person+CoreDataClass.swift
//  ConditionChecker
//
//  Created by Braden Gray on 10/31/16.
//  Copyright © 2016 Graycode. All rights reserved.
//

import Foundation
import CoreData


public class Person: NSManagedObject {
    
    class func personWithInfo(info: Dictionary<String, Any?>, inManagedObjectContext context: NSManagedObjectContext)->Person? {
        let uniqueID = info[constants.patientIDKey]
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        request.predicate = NSPredicate(format: "unique == %@", uniqueID as! CVarArg)
        if let person = (try? context.fetch(request))?.first as? Person {
            return person
        } else if let person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as? Person {
            person.name = info[constants.patientNameKey] as! String?
            person.unique = uniqueID as! String?
            return person
        }
        return nil
    }
}
