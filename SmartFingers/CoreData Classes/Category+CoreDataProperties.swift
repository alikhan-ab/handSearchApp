//
//  Category+CoreDataProperties.swift
//  SmartFingers
//
//  Created by Alikhan Abutalip on 5/10/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var over: NSSet?

}

// MARK: Generated accessors for over
extension Category {

    @objc(addOverObject:)
    @NSManaged public func addToOver(_ value: Subcategory)

    @objc(removeOverObject:)
    @NSManaged public func removeFromOver(_ value: Subcategory)

    @objc(addOver:)
    @NSManaged public func addToOver(_ values: NSSet)

    @objc(removeOver:)
    @NSManaged public func removeFromOver(_ values: NSSet)

}
