//
//  ConditionTest+CoreDataProperties.swift
//  ConditionChecker
//
//  Created by Braden Gray on 11/1/16.
//  Copyright © 2016 Graycode. All rights reserved.
//

import Foundation
import CoreData

extension ConditionTest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConditionTest> {
        return NSFetchRequest<ConditionTest>(entityName: "ConditionTest");
    }

    @NSManaged public var condition: String?
    @NSManaged public var results: Double
    @NSManaged public var patientID: String?
    @NSManaged public var person: Person?

}
