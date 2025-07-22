//
//  ViewController.swift
//  Note App
//
//  Created by Marwan Mekhamer on 20/07/2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NoNotesYetLabel: UILabel!
    
    private var ViewModel = NotesViewModel()
    let alert = Alerts()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        AddNotes()
        update()
        ViewModel.fetchNotes()
        
    }
    
    func update() {
        ViewModel.didUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.checkEmptyState()
                self?.tableView.reloadData()
            }
        }
    }
    
    func checkEmptyState() {
        let isEmpty = ViewModel.NumberOfCount == 0
            self.tableView.isHidden = isEmpty
            self.NoNotesYetLabel.isHidden = !isEmpty
        }
    
    
    func AddNotes() {
        let bar = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addMore))
        let deletebar = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(DeleteRow))
        navigationItem.rightBarButtonItems = [bar, deletebar]
    }
    
    @objc
    func addMore() {
        let AlertVC = alert.addMoreAlert { [weak self] text in
            self?.ViewModel.addnote(title: text, text: "")
            self?.tableView.reloadData()
            
        }
        present(AlertVC, animated: true)
    }
    
    @objc
    func DeleteRow() {
        tableView.isEditing = !tableView.isEditing
    }
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewModel.NumberOfCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let items = ViewModel.arrayIndex(at: indexPath.row)
        cell.textLabel?.text = items
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let note = ViewModel.noteAt(index: indexPath.row)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "details") as? DetailsNotesVC {
            vc.modalPresentationStyle = .fullScreen
            vc.note = note
            vc.didsave = { [weak self] in
                self?.ViewModel.fetchNotes()
                self?.tableView.reloadData()
            }
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "") { _, _, _ in
            self.ViewModel.deleteNotes(at: indexPath.row)
            self.checkEmptyState()
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
        
        delete.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
}
