//
//  DetailsNotesVC.swift
//  Note App
//
//  Created by Marwan Mekhamer on 20/07/2025.
//

import UIKit

class DetailsNotesVC: UIViewController {
    
    @IBOutlet weak var Headertxt: UITextField!
    @IBOutlet weak var textViewText: UITextView!
    
    
    var note: Note?
    
    var didsave: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Headertxt.text = note?.title
        textViewText.text = note?.text
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        note?.text = textViewText.text
        note?.title = Headertxt.text
        
        do {
            try note?.managedObjectContext?.save()
            didsave?()
        }
        catch {
            print("❌ Failed to save note:", error.localizedDescription)
        }
        
    }
    
}
