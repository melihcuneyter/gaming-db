//
//  NotesCoreDataManager.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 23.01.2023.
//

import UIKit
import CoreData

final class NoteCoreDataManager {
    static let shared = NoteCoreDataManager()
    private let managedContext: NSManagedObjectContext!
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func saveNote(noteModel: NoteModel) -> Note? {
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        note.setValue(noteModel.gameID, forKey: "gameID")
        note.setValue(noteModel.gameName, forKey: "gameName")
        note.setValue(noteModel.imageID, forKey: "imageID")
        note.setValue(noteModel.imageURL, forKey: "imageURL")
        note.setValue(noteModel.noteTitle, forKey: "noteTitle")
        note.setValue(noteModel.noteDesc, forKey: "noteDesc")
        
        do {
            try managedContext.save()
            return note as? Note
        } catch let error as NSError {
            NotificationCenter.default.post(name: NSNotification.Name("noteGamesErrorMessage"), object: error.localizedDescription)
        }
        
        return nil
    }
    
    func getNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        do {
            let notes = try managedContext.fetch(fetchRequest)
            return notes as! [Note]
        } catch let error as NSError {
            NotificationCenter.default.post(name: NSNotification.Name("noteGamesErrorMessage"), object: error.localizedDescription)
        }
        return []
    }
    
    func deleteNote(note: Note) {
        managedContext.delete(note)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            NotificationCenter.default.post(name: NSNotification.Name("noteGamesErrorMessage"), object: error.localizedDescription)
        }
    }
    
    func editNote(noteModel: Note, newNoteModel: NoteModel) {
        let note = managedContext.object(with: noteModel.objectID)
        note.setValue(newNoteModel.gameID, forKey: "gameID")
        note.setValue(newNoteModel.gameName, forKey: "gameName")
        note.setValue(newNoteModel.imageID, forKey: "imageID")
        note.setValue(newNoteModel.imageURL, forKey: "imageURL")
        note.setValue(newNoteModel.noteTitle, forKey: "noteTitle")
        note.setValue(newNoteModel.noteDesc, forKey: "noteDesc")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            NotificationCenter.default.post(name: NSNotification.Name("noteGamesErrorMessage"), object: error.localizedDescription)
        }
    }
}
