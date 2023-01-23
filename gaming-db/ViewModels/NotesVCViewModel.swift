//
//  NotesVCViewModel.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 17.01.2023.
//

import Foundation

protocol NotesVCViewModelProtocol {
    var delegate: NotesVCViewModelDelegate? { get set }
    func fetchNotes()
    func getNoteCount() -> Int
    func getNote(at index: Int) -> Note?
    func deleteNote(at index:Int)
    func editNote(obj:Note, newObj: NoteModel)
    
    func getGameId(at index: Int) -> Int?
    func getGameImageID(at index: Int) -> String?
    
}

protocol NotesVCViewModelDelegate: AnyObject {
    func notesFetched()
}

final class NotesVCViewModel: NotesVCViewModelProtocol {
    weak var delegate: NotesVCViewModelDelegate?
    private var notes = [Note]()
    
    func fetchNotes() {
        Constants.sharedInstance.isNotesChanged = false
        notes = NoteCoreDataManager.shared.getNotes()
        notes = notes.reversed()
        delegate?.notesFetched()
    }
    
    func getNoteCount() -> Int {
        notes.count
    }
    
    func getNote(at index: Int) -> Note? {
        if index > notes.count - 1 {
            return nil
        }
        return notes[index]
    }
    
    func deleteNote(at index:Int) {
        NoteCoreDataManager.shared.deleteNote(note: notes[index])
        notes.remove(at: index)
        delegate?.notesFetched()
        
    }
    
    func editNote(obj:Note, newObj:NoteModel) {
        NoteCoreDataManager.shared.editNote(obj: obj,newObj: newObj)
    }
    
    func getGameId(at index: Int) -> Int? {
        if index > notes.count - 1{
            return nil
        }
        return Int(notes[index].gameID)
    }
    
    
    func getGameImageID(at index: Int) -> String? {
        if index > notes.count - 1 {
            return nil
        }
        return notes[index].imageID
    }
}
