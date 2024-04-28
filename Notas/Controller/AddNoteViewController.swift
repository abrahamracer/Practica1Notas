//
//  AddNoteViewController.swift
//  Notas
//
//  Created by Abraham Valderrabano Vega on 25/04/24.
//

import UIKit

protocol AddNoteDelegate: AnyObject {
    func didUpdateNote()
}

class AddNoteViewController: UIViewController, UITextViewDelegate {
    
    var detailNote: Note?
    
    var indexNoteSend = -1
    
    @IBOutlet weak var noteTitle: UITextField!
    
    @IBOutlet weak var noteContent: UITextView!
    
    override func viewDidLoad() {
      
        noteContent.delegate = self

        super.viewDidLoad()
        if detailNote != nil {
            noteTitle.text = detailNote?.title
            noteContent.text = detailNote?.content
            
        }
        else{
            noteContent.text = "Write anything....."
            noteContent.textColor = .gray
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! NotesViewController
        
        if detailNote == nil {
            detailNote = Note(title: noteTitle.text ?? "", content: noteContent.text, date: Date())
        }
        else{
            detailNote?.title = noteTitle.text!
            detailNote?.content = noteContent.text
        }
        destination.indexNoteReceive = indexNoteSend
        destination.note = detailNote
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
       
        guard let title = noteTitle.text, !title.isEmpty,
              let content = noteContent.text, !content.isEmpty,
              content != "Write anything....." else {
            
            showAlert(message: "To continue, make sure you fill out all the required fields.")
            return false
        }
     
        return true
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
  
        let isModal = self.presentingViewController is UINavigationController
   
        if isModal {
            self.dismiss(animated: true)
        }
        else{
            navigationController?.popViewController(animated: true)
        }
    }
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Write anything....." {
            textView.text = ""
            textView.textColor = .label 
        }
    }
}
