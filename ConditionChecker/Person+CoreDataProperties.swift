//
//  Person+CoreDataProperties.swift
//  ConditionChecker
//
//  Created by Braden Gray on 11/1/16.
//  Copyright © 2016 Graycode. All rights reserved.
//

import Foundation
import CoreData

extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person");
    }

    @NSManaged public var name: String?
    @NSManaged public var unique: String?
    @NSManaged public var conditionTests: NSSet?

}

// MARK: Generated accessors for conditionTests
extension Person {

    @objc(addConditionTestsObject:)
    @NSManaged public func addToConditionTests(_ value: ConditionTest)

    @objc(removeConditionTestsObject:)
    @NSManaged public func removeFromConditionTests(_ value: ConditionTest)

    @objc(addConditionTests:)
    @NSManaged public func addToConditionTests(_ values: NSSet)

    @objc(removeConditionTests:)
    @NSManaged public func removeFromConditionTests(_ values: NSSet)

}
