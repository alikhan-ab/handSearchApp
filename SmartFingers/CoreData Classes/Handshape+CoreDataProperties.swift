//
//  Handshape+CoreDataProperties.swift
//  SmartFingers
//
//  Created by Alikhan Abutalip on 20/11/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//
//

import Foundation
import CoreData


extension Handshape {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Handshape> {
        return NSFetchRequest<Handshape>(entityName: "Handshape")
    }

    @NSManaged public var id: Int16
    @NSManaged public var words: NSSet?

}

// MARK: Generated accessors for words
extension Handshape {

    @objc(addWordsObject:)
    @NSManaged public func addToWords(_ value: Word)

    @objc(removeWordsObject:)
    @NSManaged public func removeFromWords(_ value: Word)

    @objc(addWords:)
    @NSManaged public func addToWords(_ values: NSSet)

    @objc(removeWords:)
    @NSManaged public func removeFromWords(_ values: NSSet)

}
