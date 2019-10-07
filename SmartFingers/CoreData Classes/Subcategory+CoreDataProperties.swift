//
//  Subcategory+CoreDataProperties.swift
//  SmartFingers
//
//  Created by Alikhan Abutalip on 5/10/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//
//

import Foundation
import CoreData


extension Subcategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subcategory> {
        return NSFetchRequest<Subcategory>(entityName: "Subcategory")
    }

    @NSManaged public var name: String?
    @NSManaged public var under: Category?
    @NSManaged public var contains: NSSet?

}

// MARK: Generated accessors for contains
extension Subcategory {

    @objc(addContainsObject:)
    @NSManaged public func addToContains(_ value: Word)

    @objc(removeContainsObject:)
    @NSManaged public func removeFromContains(_ value: Word)

    @objc(addContains:)
    @NSManaged public func addToContains(_ values: NSSet)

    @objc(removeContains:)
    @NSManaged public func removeFromContains(_ values: NSSet)

}
