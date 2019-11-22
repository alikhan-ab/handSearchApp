//
//  Word+CoreDataProperties.swift
//  SmartFingers
//
//  Created by Alikhan Abutalip on 20/11/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var favourite: Bool
    @NSManaged public var id: Int16
    @NSManaged public var translation: String?
    @NSManaged public var video: String?
    @NSManaged public var from: Subcategory?
    @NSManaged public var handshapes: NSSet?

}

// MARK: Generated accessors for handshapes
extension Word {

    @objc(addHandshapesObject:)
    @NSManaged public func addToHandshapes(_ value: Handshape)

    @objc(removeHandshapesObject:)
    @NSManaged public func removeFromHandshapes(_ value: Handshape)

    @objc(addHandshapes:)
    @NSManaged public func addToHandshapes(_ values: NSSet)

    @objc(removeHandshapes:)
    @NSManaged public func removeFromHandshapes(_ values: NSSet)

}
