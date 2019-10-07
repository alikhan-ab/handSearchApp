//
//  Word+CoreDataProperties.swift
//  SmartFingers
//
//  Created by Alikhan Abutalip on 5/10/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var id: Int16
    @NSManaged public var translation: String?
    @NSManaged public var video: String?
    @NSManaged public var favourite: Bool
    @NSManaged public var from: Subcategory?

}
