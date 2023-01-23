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
    
    func saveNote(obj: NoteModel) -> Note? {
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        note.setValue(obj.gameID, forKey: "gameID")
        note.setValue(obj.imageID, forKey: "imageID")
        note.setValue(obj.imageURL, forKey: "imageURL")
        note.setValue(obj.noteTitle, forKey: "noteTitle")
        note.setValue(obj.noteDesc, forKey: "noteDesc")
        
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
    
    func editNote(obj: Note, newObj: NoteModel) {
        let note = managedContext.object(with: obj.objectID)
        note.setValue(newObj.gameID, forKey: "gameID")
        note.setValue(newObj.imageID, forKey: "imageID")
        note.setValue(newObj.imageURL, forKey: "imageURL")
        note.setValue(newObj.noteTitle, forKey: "noteTitle")
        note.setValue(newObj.noteDesc, forKey: "noteDesc")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            NotificationCenter.default.post(name: NSNotification.Name("noteGamesErrorMessage"), object: error.localizedDescription)
        }
    }
}
