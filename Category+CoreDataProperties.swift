//
//  Category+CoreDataProperties.swift
//  note_ASR_iOS
//
//  Created by User on 2021-02-01.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?

}

extension Category : Identifiable {

}
