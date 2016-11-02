//
//  ConditionTest+CoreDataClass.swift
//  ConditionChecker
//
//  Created by Braden Gray on 10/31/16.
//  Copyright © 2016 Graycode. All rights reserved.
//

import Foundation
import CoreData


public class ConditionTest: NSManagedObject {
    
    class func conditionTestForInfo(info: Dictionary<String, Any?>, inNSManagedObjectContext context: NSManagedObjectContext)->ConditionTest? {
        let patientID = info[constants.patientIDKey]
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"ConditionTest")
        request.predicate = NSPredicate(format: "patientID == %@", patientID as! CVarArg)
        if let conditionTest = (try? context.fetch(request))?.first as? ConditionTest {
            return conditionTest
        } else if let conditionTest = NSEntityDescription.insertNewObject(forEntityName: "ConditionTest", into: context) as? ConditionTest {
            conditionTest.condition = info[constants.conditionKey] as! String?
            conditionTest.patientID = patientID as! String?
            conditionTest.results = info[constants.resultsKey] as! Double
            conditionTest.person = Person.personWithInfo(info: info, inManagedObjectContext: context)
            return conditionTest
        }
        return nil
    }
}
