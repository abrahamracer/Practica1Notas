//
//  NotesManager.swift
//  Notas
//
//  Created by Abraham Valderrabano Vega on 25/04/24.
//

import Foundation

class NotesManager{
    
    private var notes : [Note] = []
    
    func createNote(note: Note) {
        notes.append(note)
    }
    
    func deleteNote(at index : Int) {
        notes.remove(at: index)
    }
    
    func getNotes() -> [Note] {
        return notes
    }
    
    func getNote(at index : Int) -> Note {
        return notes[index]
    }
    
    func countNotes() -> Int {
        return notes.count
    }
    
    func updateNote(at index: Int, with note: Note) {
        notes[index] = note
    }
    
    func saveNotes() {
  
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
      
        let notesURL = documentsDirectory.appendingPathComponent("notes.json")
      
        do{
            let jsonData = try JSONEncoder().encode(notes)
            fileManager.createFile(atPath: notesURL.path, contents: jsonData)
        }
        catch let error{
            print(error)
        }
    }
    
    func loadNotes(){
    
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let notesURL = documentsDirectory.appendingPathComponent("notes.json")
        
        if fileManager.fileExists(atPath: notesURL.path){
            do{
                let jsondata = fileManager.contents(atPath: notesURL.path)
                notes = try JSONDecoder().decode([Note].self, from: jsondata! )
            }
            catch let error{
                print("error: ", error)
            }
        }
        else{
            print("No se localizó el archivo")
        }
    }
}
