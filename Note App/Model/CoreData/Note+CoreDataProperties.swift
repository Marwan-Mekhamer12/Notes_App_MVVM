//
//  Note+CoreDataProperties.swift
//  Note App
//
//  Created by Marwan Mekhamer on 21/07/2025.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var text: String?
    @NSManaged public var title: String?

}

extension Note : Identifiable {

}
