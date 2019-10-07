//
//  CategoryJSON.swift
//  SmartFingers
//
//  Created by Alikhan Abutalip on 3/10/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

struct CategoryJSON: Codable {
    let name: String
    let subcategories: [SubcategoryJSON]
}
