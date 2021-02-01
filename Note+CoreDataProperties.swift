//
//  Note+CoreDataProperties.swift
//  note_ASR_iOS
//
//  Created by User on 2021-02-01.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var audio: String?
    @NSManaged public var category: String?
    @NSManaged public var date: Date?
    @NSManaged public var image: String?
    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var subDescription: String?
    @NSManaged public var title: String?

}

extension Note : Identifiable {

}
