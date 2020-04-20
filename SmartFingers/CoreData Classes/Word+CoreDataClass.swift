//
//  Word+CoreDataClass.swift
//  SmartFingers
//
//  Created by Alikhan Abutalip on 20/11/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Word)
public class Word: NSManagedObject {
    
    @objc dynamic var initialTranslation: String {
        self.willAccessValue(forKey: "initialTranslation")
        let initial = self.translation!.first!.uppercased()
        let test = String(initial.utf8)
        self.didAccessValue(forKey: "initialTranslation")
        return test
    }

}
