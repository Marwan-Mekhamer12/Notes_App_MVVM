//
//  NotesViewModel.swift
//  Note App
//
//  Created by Marwan Mekhamer on 20/07/2025.
//

import Foundation

protocol Logic {
    
    func arrayIndex(at index: Int) -> String  // for index.row in tableView cell
    func deleteNotes(at index: Int)
    func addnote(title: String, text: String)
    func noteAt(index: Int) -> Note
    func fetchNotes()
}

class NotesViewModel: Logic {
    
   private(set) var notes: [Note] = [] {
        didSet {
            didUpdate?()
        }
    }
    
    var NumberOfCount: Int {
        return notes.count
    }
    
    func arrayIndex(at index: Int) -> String {
        return notes[index].title ?? ""
    }
    
    var didUpdate: (() ->Void)?
    
    func deleteNotes(at index: Int) {
           let note = notes[index]
           CoreDataManager.shared.deleteNote(note)
           fetchNotes() // Update the array after deletion
       }
    
    func noteAt(index: Int) -> Note {  // from textField in array to TableView 
        return notes[index]
    }
    
    
    func addnote(title: String, text: String) {
        CoreDataManager.shared.SaveData(title: title, text: text)
        fetchNotes()
    }
    
    func fetchNotes() {
        notes = CoreDataManager.shared.fetchNotes()
    }
    
    
}
