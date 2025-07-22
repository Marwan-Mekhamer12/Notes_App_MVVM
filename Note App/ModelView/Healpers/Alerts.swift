//
//  Alerts.swift
//  Note App
//
//  Created by Marwan Mekhamer on 20/07/2025.
//

import Foundation
import UIKit

protocol AlertController {
    func addMoreAlert(handler: @escaping (String) -> Void) -> UIAlertController
}

class Alerts: AlertController {
    
    func addMoreAlert(handler: @escaping (String) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "Add Notes...", message: "You Can Add What You Want.", preferredStyle: .alert)
        
        alert.addTextField { text in
            text.placeholder = "What are you think about?"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            if let note = alert.textFields?.first?.text, !note.isEmpty {
                handler(note)
            }
        }))
        return alert
    }
    
    
    
    
}
