//
//  CoreDataManager.swift
//  Note App
//
//  Created by Marwan Mekhamer on 21/07/2025.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    init() {}
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func SaveData(title: String, text: String) {
        let note = Note(context: context)
        note.title = title
        note.text = text
        do {
            try context.save()
        }
        catch {
            print("❌ Failed to save note:", error.localizedDescription)
        }
    }
    
    
    
    func fetchNotes() -> [Note] {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("❌ Failed to fetch notes:", error.localizedDescription)
            return []
        }
    }
    
    
    
    func deleteNote(_ note: Note) {
        context.delete(note)
        do {
            try context.save()
        } catch {
            print("❌ Failed to delete note:", error.localizedDescription)
        }
    }
    
}
