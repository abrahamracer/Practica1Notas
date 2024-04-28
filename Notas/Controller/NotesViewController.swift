//
//  NotesViewController.swift
//  Notas
//
//  Created by Abraham Valderrabano Vega on 25/04/24.
//

import UIKit

class NotesViewController: UITableViewController {
    
    @IBOutlet var noteList: UITableView!
    
    @IBOutlet var emptyNotesView: UIView!
    
    var notesManager = NotesManager()
    
    var note : Note!
    
    var indexNoteReceive = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesManager.loadNotes()
        updateEmptyNotesViewVisibility()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateEmptyNotesViewVisibility()
    }
    
    func updateEmptyNotesViewVisibility() {
        if notesManager.countNotes() == 0 {
            emptyNotesView.isHidden = false
            noteList.backgroundView = emptyNotesView
        } else {
            emptyNotesView.isHidden = true
        }
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editNote" {
            
            let destination = segue.destination as! AddNoteViewController
           
            destination.detailNote = notesManager.getNote(at: noteList.indexPathForSelectedRow!.row)
            destination.indexNoteSend = noteList.indexPathForSelectedRow!.row
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return notesManager.countNotes()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NoteCell
        cell?.noteTitle.text = notesManager.getNote(at: indexPath.row).title
        cell?.noteDate.text = notesManager.getNote(at: indexPath.row).date.iso8601String
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editNote", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
       
            notesManager.deleteNote(at: indexPath.row)
            notesManager.saveNotes()
            
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            if notesManager.countNotes() == 0 {
                
                emptyNotesView.isHidden = false
                noteList.backgroundView = emptyNotesView
            }
            tableView.endUpdates()
        }
    }
    
   
    @IBAction func unwidToNotesViewController(_ segue : UIStoryboardSegue){
        let source = segue.source as! AddNoteViewController
        if indexNoteReceive == -1{
            notesManager.createNote(note: note!)
        }
        else{
            notesManager.updateNote(at: indexNoteReceive, with: source.detailNote!)
        }
        notesManager.saveNotes()
        noteList.reloadData()
        updateEmptyNotesViewVisibility()
        
    }
    
}
