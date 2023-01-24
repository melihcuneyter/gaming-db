//
//  NewNoteVCViewModel.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 23.01.2023.
//

import Foundation

protocol NewNoteVCViewModelProtocol {
    var delegate: NewNoteVCViewModelDelegate? { get set }
    func newNote(obj: NoteModel)
    func editNote(obj: Note, newObj: NoteModel)
}

protocol NewNoteVCViewModelDelegate: AnyObject {
    func notesLoaded()
}

final class NewNoteVCViewModel: NewNoteVCViewModelProtocol {
    weak var delegate: NewNoteVCViewModelDelegate?
    private var notes = [Note]()
    
    func newNote(obj: NoteModel) {
        _ = NoteCoreDataManager.shared.saveNote(noteModel: obj)
    }
    
    
    func editNote(obj:Note, newObj:NoteModel){
        NoteCoreDataManager.shared.editNote(noteModel: obj, newNoteModel: newObj)
    }
}
